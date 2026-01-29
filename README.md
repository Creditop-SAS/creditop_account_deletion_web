# Creditop - Web de Eliminacion de Cuenta

Web responsiva que permite a los usuarios solicitar la eliminacion de su cuenta y datos personales sin acceder a la app movil. Requisito obligatorio de [Google Play (mayo 2024)](https://support.google.com/googleplay/android-developer/answer/13327111) y [Apple App Store (Guidelines 5.1.1(v))](https://developer.apple.com/app-store/review/guidelines/#data-collection-and-storage).

## Tabla de Contenidos

- [Requisitos Previos](#requisitos-previos)
- [Instalacion](#instalacion)
- [Configuracion de Entorno](#configuracion-de-entorno)
- [Ejecutar el Proyecto](#ejecutar-el-proyecto)
- [Arquitectura](#arquitectura)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Flujo de Navegacion](#flujo-de-navegacion)
- [Paquetes](#paquetes)
- [Design System (cds_web)](#design-system-cds_web)
- [Autenticacion](#autenticacion)
- [Internacionalizacion](#internacionalizacion)
- [Patrones y Convenciones](#patrones-y-convenciones)
- [Comandos Utiles](#comandos-utiles)
- [Cumplimiento Regulatorio](#cumplimiento-regulatorio)

---

## Requisitos Previos

| Herramienta | Version | Instalacion |
|-------------|---------|-------------|
| **FVM** | latest | `dart pub global activate fvm` |
| **Flutter** | 3.35.5 | `fvm install 3.35.5` (automatico con `.fvmrc`) |
| **Dart** | 3.9.2+ | Incluido con Flutter |
| **Chrome** | latest | Para correr la web |

> **Nota:** Este proyecto usa [FVM (Flutter Version Management)](https://fvm.app/) para asegurar que todos usen la misma version de Flutter. Todos los comandos de Flutter deben ejecutarse con el prefijo `fvm`.

---

## Instalacion

```bash
# 1. Clonar el repositorio
git clone <repo-url>
cd creditop_account_deletion_web

# 2. Instalar la version de Flutter definida en .fvmrc
fvm install

# 3. Obtener dependencias (desde la carpeta app/)
cd app
fvm flutter pub get

# 4. Generar codigo (providers de Riverpod)
fvm dart run build_runner build --delete-conflicting-outputs
```

---

## Configuracion de Entorno

El proyecto maneja 3 entornos: **mock**, **dev** y **production**.

### Variables de entorno (.env)

Crear los archivos `.env` y `.env.dev` en `app/` basandose en el ejemplo:

```bash
cp app/.env.example app/.env
cp app/.env.example app/.env.dev
```

Contenido requerido:

```env
COGNITO_REGION=us-east-2
COGNITO_USER_POOL_ID=<user-pool-id>
COGNITO_CLIENT_ID=<client-id>
COGNITO_CLIENT_SECRET=
COGNITO_DOMAIN=<cognito-domain>
```

> Los valores reales se obtienen del equipo de backend o del proyecto `creditop_mobile`.

### Cambiar entorno activo

Editar `app/lib/current_environment.dart`:

```dart
// Para desarrollo local con datos mock (no requiere .env):
static const AppEnvironment environment = AppEnvironment.mock;

// Para apuntar al backend de desarrollo:
static const AppEnvironment environment = AppEnvironment.dev;

// Para apuntar a produccion:
static const AppEnvironment environment = AppEnvironment.production;
```

| Entorno | Backend | API Base URL | .env |
|---------|---------|--------------|------|
| `mock` | Simulado | N/A | No requerido |
| `dev` | AWS Cognito | `https://api.dev.creditop.com` | `.env.dev` |
| `production` | AWS Cognito | `https://v2.api.creditop.com` | `.env` |

---

## Ejecutar el Proyecto

```bash
cd app

# Modo mock (default, no requiere backend)
fvm flutter run -d chrome

# Con puerto especifico
fvm flutter run -d chrome --web-port=8080
```

### Flujo de prueba en modo mock

1. `/` - Landing: presionar "Iniciar proceso de eliminacion"
2. `/verificar-telefono` - Ingresar cualquier telefono de 10 digitos (ej: `3178622287`)
3. `/verificar-otp` - Ingresar OTP `1234`
4. `/informacion-datos` - Revisar datos eliminados vs conservados
5. `/confirmar-eliminacion` - Presionar "Eliminar mi cuenta" y confirmar en el modal
6. `/eliminacion-exitosa` - Verificar mensaje de confirmacion

---

## Arquitectura

El proyecto sigue **Arquitectura Hexagonal (Ports & Adapters)** con la misma estructura del proyecto `creditop_mobile`.

```
┌──────────────────────────────────────────────────┐
│  app/                                            │
│  ┌────────────────────────────────────────────┐  │
│  │  infrastructure/ (ADAPTERS)                │  │
│  │  - Cognito datasource                      │  │
│  │  - Delete account datasource (Dio)         │  │
│  │  - Gateway implementations                 │  │
│  │  - Gateway mocks                           │  │
│  └────────────────────────────────────────────┘  │
│  ┌────────────────────────────────────────────┐  │
│  │  config/                                   │  │
│  │  - Router (GoRouter)                       │  │
│  │  - Dependency injection (Riverpod)         │  │
│  │  - Environment & Amplify config            │  │
│  └────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────┘
        │ implementa                ▲ inyecta
        ▼                          │
┌──────────────────────────────────────────────────┐
│  packages/                                       │
│  ┌──────────────┐  ┌──────────────────────────┐  │
│  │ feature_auth  │  │ feature_delete_account   │  │
│  │ ┌──────────┐ │  │ ┌──────────────────────┐ │  │
│  │ │ domain/  │ │  │ │ domain/ (PORTS)       │ │  │
│  │ │ gateways │ │  │ │ gateways             │ │  │
│  │ └──────────┘ │  │ └──────────────────────┘ │  │
│  │ ┌──────────┐ │  │ ┌──────────────────────┐ │  │
│  │ │ present. │ │  │ │ presentation         │ │  │
│  │ │ pages    │ │  │ │ pages, providers     │ │  │
│  │ │ providers│ │  │ │ models               │ │  │
│  │ └──────────┘ │  │ └──────────────────────┘ │  │
│  └──────────────┘  └──────────────────────────┘  │
│  ┌──────────────┐  ┌──────────────────────────┐  │
│  │    core       │  │       cds_web            │  │
│  │  errors       │  │  tokens, atoms           │  │
│  │  network      │  │  molecules, organisms    │  │
│  │  validators   │  │  fonts, logos             │  │
│  └──────────────┘  └──────────────────────────┘  │
└──────────────────────────────────────────────────┘
```

**Regla de oro:** Los features NUNCA dependen de implementaciones concretas. Solo de abstracciones (gateways abstractos en `domain/`). Las implementaciones viven en `app/infrastructure/` y se inyectan via Riverpod.

---

## Estructura del Proyecto

```
creditop_account_deletion_web/
├── app/                              # Host de la aplicacion
│   ├── lib/
│   │   ├── main.dart                 # Entry point
│   │   ├── current_environment.dart  # Toggle de entorno activo
│   │   ├── config/
│   │   │   ├── app_environment.dart          # Enum mock/dev/production
│   │   │   ├── environment_config.dart       # URLs y .env por entorno
│   │   │   ├── amplify_configuration.dart    # Config AWS Cognito
│   │   │   ├── dependency_injection.dart     # Wiring de DI (Riverpod)
│   │   │   └── router/app_router.dart        # GoRouter (6 rutas)
│   │   ├── infrastructure/
│   │   │   ├── auth/                 # Adapter: AWS Cognito
│   │   │   └── delete_account/       # Adapter: API eliminacion
│   │   └── l10n/                     # Internacionalizacion (es/en)
│   └── web/                          # Assets web (HTML, icons, PWA)
│
├── packages/
│   ├── core/                         # Utilidades compartidas
│   ├── cds_web/                      # Design System para web
│   ├── feature_auth/                 # Feature: login (phone + OTP)
│   └── feature_delete_account/       # Feature: eliminacion de cuenta
│
├── .fvmrc                            # Flutter 3.35.5
├── .env.example                      # Template de variables de entorno
└── analysis_options.yaml             # Reglas de lint
```

---

## Flujo de Navegacion

```
    ┌─────────────────────┐
    │   / (Landing)       │  Info de Creditop + pasos del proceso
    │   Publica            │
    └─────────┬───────────┘
              │ "Iniciar proceso"
              ▼
    ┌─────────────────────┐
    │ /verificar-telefono  │  Input telefono +57
    │ Publica              │
    └─────────┬───────────┘
              │ OTP enviado
              ▼
    ┌─────────────────────┐
    │ /verificar-otp       │  Input OTP 4 digitos + reenvio
    │ Publica              │
    └─────────┬───────────┘
              │ Verificado (sesion activa)
              ▼
    ┌─────────────────────┐
    │ /informacion-datos   │  Datos eliminados vs conservados
    │ Protegida            │
    └─────────┬───────────┘
              │ "Continuar"
              ▼
    ┌─────────────────────┐
    │ /confirmar-eliminacion│ Warnings + modal de confirmacion
    │ Protegida             │
    └─────────┬───────────┘
              │ Confirma eliminacion
              ▼
    ┌─────────────────────┐
    │ /eliminacion-exitosa │  Mensaje de exito
    │ Protegida            │
    └─────────────────────┘
```

Las rutas **protegidas** requieren sesion activa de Cognito. Si el usuario no esta autenticado, se redirige a `/`. En modo mock, la proteccion esta desactivada.

---

## Paquetes

### `core`

Utilidades compartidas entre features.

| Modulo | Descripcion |
|--------|-------------|
| `ErrorItem` | Modelo estandar de errores con code, title, message, category |
| `ErrorCategory` | Enum: toast, modal, totalPage |
| `DioClient` | Cliente HTTP preconfigurado con interceptores |
| `PhoneValidator` | Validacion de telefono (10 digitos) y OTP (4 digitos) |

### `cds_web`

Creditop Design System para web. Tokens identicos al proyecto mobile (`cds_mobile`).

**Tokens:**
- `CdsColors` - 10 paletas de colores (primary: morado `#4C39FF`)
- `CdsTypography` - Tipografia Satoshi (heading + text scales)
- `CdsSpacing` - Sistema de espaciado (micro, sm, md, lg, xl)
- `CdsBorderRadius` - Radios de borde estandar
- `CdsShadow` - Sombras del sistema

**Componentes:**

| Nivel | Componente | Descripcion |
|-------|-----------|-------------|
| Atom | `CtButton` | Botones: primary, secondary, ghost, destructive |
| Atom | `CtLoader` | Indicador de carga circular |
| Molecule | `CtTextField` | Input de texto con prefix, error, hint |
| Molecule | `CtOtpInput` | 4 campos para OTP con auto-focus |
| Molecule | `CtErrorModal` | Modal de error/confirmacion |
| Molecule | `CtInlineAlert` | Banner info/warning/error/success/neutral |
| Organism | `CtWebScaffold` | Layout responsive centrado con logo y footer |
| Organism | `CtDataInfoSection` | Seccion de datos con icono + lista |

**Naming:** `Cds*` = Tokens, `Ct*` = Widgets

### `feature_auth`

Autenticacion con phone + OTP via AWS Cognito.

- **PhoneInputPage:** Input de telefono con prefijo +57
- **OtpVerificationPage:** Input de OTP con countdown para reenvio
- **AuthGateway:** Interfaz abstracta (`requestOtp`, `verifyOtp`)

### `feature_delete_account`

Flujo principal de eliminacion de cuenta (4 paginas).

- **LandingPage:** Info de Creditop, pasos del proceso, link a politica de privacidad
- **DataInfoPage:** Datos que se eliminan vs datos que se conservan (regulacion SFC)
- **DeleteConfirmationPage:** Warnings + modal de confirmacion final
- **DeleteSuccessPage:** Confirmacion de eliminacion exitosa
- **DeleteAccountGateway:** Interfaz abstracta (`deleteAccount`)

---

## Design System (cds_web)

Los tokens son identicos al sistema de diseno mobile (`cds_mobile`) para mantener consistencia visual.

### Colores principales

| Color | Uso | Hex |
|-------|-----|-----|
| Morado | Primary/Brand | `#4C39FF` |
| Azul | Info | `#22BAFF` |
| Verde | Success | `#01A702` |
| Naranja | Warning | `#F79008` |
| Rojo | Error/Destructive | `#F14437` |
| Neutral | Texto, fondos, bordes | `#F5F5F5` - `#000000` |

### Tipografia

Fuente: **Satoshi** (4 pesos: Light 300, Normal 400, Medium 500, Bold 700)

### Layout responsive

`CtWebScaffold` maneja el layout responsive:
- **Mobile** (<600px): full-width con padding 16px
- **Desktop** (>600px): card centrada, max-width 480px, fondo gris claro

---

## Autenticacion

### AWS Cognito (Custom Auth)

El flujo usa `CUSTOM_AUTH_WITHOUT_SRP`:

1. `signIn(username: phone)` - Inicia challenge
2. `confirmSignIn(confirmationValue: otp)` - Verifica OTP
3. `fetchAuthSession()` - Obtiene JWT tokens
4. JWT se usa como Bearer token para la API de eliminacion

### API de Eliminacion

```
DELETE https://v2.api.creditop.com/legacy-api/onboarding/mobile/delete-user
Authorization: Bearer <jwt-token>
```

Codigos de respuesta:

| Codigo | Significado |
|--------|-------------|
| MOBA4001 | Eliminacion exitosa |
| MOBA4002 | Usuario no encontrado |
| MOBA4003 | No se puede eliminar (credito activo) |
| MOBA4004 | Error del servidor |

---

## Internacionalizacion

Idiomas soportados: **Espanol (es)** - primario, **Ingles (en)**

Los strings se definen en archivos ARB (`app/lib/l10n/`) y se inyectan a los features via modelos de strings (ej: `LandingStrings`, `PhoneInputStrings`). Los features **nunca** acceden directamente a `AppLocalizations`.

---

## Patrones y Convenciones

### Tuple Pattern (Gateways)

Todos los gateways retornan una tupla `(ErrorItem?, T?)`:

```dart
// Definicion en domain/
abstract class AuthGateway {
  Future<(ErrorItem?, AuthSession?)> verifyOtp(String phone, String otp);
}

// Uso en provider
final (error, session) = await gateway.verifyOtp(phone, otp);
if (error != null) { /* manejar error */ }
```

### DI Placeholder

Los features declaran providers placeholder que se sobreescriben en `main.dart`:

```dart
// En feature (domain/gateways/auth_gateway_provider.dart)
@riverpod
AuthGateway authGateway(Ref ref) => throw UnimplementedError('Override in main.dart');

// En app (main.dart)
ProviderScope(
  overrides: [
    authGatewayProvider.overrideWithValue(authGatewayImpl),
  ],
)
```

### Mounted Check

Antes de actualizar estado o navegar despues de una operacion asincrona:

```dart
final result = await gateway.deleteAccount();
if (!ref.mounted) return; // Evita updates en widgets desmontados
state = state.copyWith(isDeleted: true);
```

### Seguridad

- `debugPrint` solo con `kDebugMode` (`import 'package:flutter/foundation.dart'`)
- PII (telefono) redactado en logs: `+57317***2287`
- Mensajes de error genericos al usuario (sin detalles tecnicos)
- Rutas protegidas con guard de sesion en GoRouter

### Git

- **Branch:** `<type>/<ticket>-<package>-<descripcion>`
- **Commit:** `<type>(<scope>): <subject>`
- Ejemplo: `feat(feature_auth): implementar verificacion OTP`

---

## Comandos Utiles

```bash
# Desde app/

# Analisis estatico (todo el proyecto)
fvm flutter analyze

# Ejecutar tests
fvm flutter test

# Generar codigo (providers Riverpod)
fvm dart run build_runner build --delete-conflicting-outputs

# Correr en Chrome
fvm flutter run -d chrome

# Correr en puerto especifico
fvm flutter run -d chrome --web-port=8080

# Build para produccion
fvm flutter build web --release

# Limpiar cache
fvm flutter clean && fvm flutter pub get
```

---

## Cumplimiento Regulatorio

Esta web cumple los requisitos obligatorios de Google Play y Apple App Store:

| Requisito | Implementacion |
|-----------|---------------|
| Referencia al nombre de la app | Landing page con logo y branding Creditop |
| Pasos claros para solicitar eliminacion | Proceso visual de 4 pasos en landing |
| Especificar datos eliminados vs conservados | Pagina dedicada (DataInfoPage) |
| Periodos de retencion | 10 anos para datos financieros (regulacion SFC Colombia) |
| URL publica accesible sin app | Web responsiva independiente |
| Verificacion de identidad | OTP via SMS (AWS Cognito) |
| Diseno responsivo | Mobile-first + desktop centered card |
| Multi-idioma | Espanol + Ingles |

### Datos que se eliminan
- Informacion personal (nombre, email, telefono)
- Historial de navegacion en la app
- Preferencias y configuraciones
- Tokens de sesion

### Datos que se conservan (regulacion SFC)
- Historial de creditos (10 anos)
- Registros de transacciones
- Informacion para prevencion de fraude

---

## Stack Tecnologico

| Tecnologia | Version | Proposito |
|------------|---------|-----------|
| Flutter | 3.35.5 | Framework UI |
| Dart | 3.9.2+ | Lenguaje |
| Riverpod | 3.x | State management |
| GoRouter | 16.x | Navegacion |
| Dio | 5.x | Cliente HTTP |
| AWS Amplify | 2.7.x | Autenticacion Cognito |
| flutter_svg | 2.1.x | Renderizado SVG |
| url_launcher | 6.3.x | Links externos |
