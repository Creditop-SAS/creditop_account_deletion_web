import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cds_web/cds_web.dart';
import 'package:feature_auth/feature_auth.dart';
import 'package:feature_delete_account/feature_delete_account.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:creditop_account_deletion_web/config/amplify_configuration.dart';
import 'package:creditop_account_deletion_web/config/dependency_injection.dart' as di;
import 'package:creditop_account_deletion_web/config/environment_config.dart';
import 'package:creditop_account_deletion_web/config/router/app_router.dart';
import 'package:creditop_account_deletion_web/current_environment.dart';
import 'package:creditop_account_deletion_web/l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Cargar variables de entorno
  final envFileName = EnvironmentConfig.getEnvFileName(
    CurrentEnvironment.environment,
  );

  try {
    await dotenv.load(fileName: envFileName);
  } catch (_) {
    // En modo mock, .env puede no existir
    if (kDebugMode) {
      debugPrint('No se pudo cargar $envFileName');
    }
  }

  // Configurar Amplify en modo real
  if (CurrentEnvironment.usesRealBackend) {
    await _configureAmplify();
  } else {
    if (kDebugMode) {
      debugPrint('Modo MOCK: Amplify deshabilitado');
    }
  }

  // Crear router
  final router = createAppRouter();

  runApp(
    ProviderScope(
      overrides: [
        authGatewayProvider.overrideWithValue(di.createAuthGateway()),
        deleteAccountGatewayProvider.overrideWithValue(
          di.createDeleteAccountGateway(),
        ),
      ],
      child: MainApp(router: router),
    ),
  );
}

Future<void> _configureAmplify() async {
  try {
    AmplifyConfiguration.validateConfiguration();
    await Amplify.addPlugin(AmplifyAuthCognito());
    await Amplify.configure(AmplifyConfiguration.amplifyConfig);
    if (kDebugMode) {
      debugPrint('Amplify configurado');
    }
  } on AmplifyAlreadyConfiguredException {
    if (kDebugMode) {
      debugPrint('Amplify ya configurado');
    }
  } catch (e) {
    if (kDebugMode) {
      debugPrint('Error al configurar Amplify: $e');
    }
  }
}

/// Widget raíz de la aplicación.
class MainApp extends StatelessWidget {
  const MainApp({required this.router, super.key});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Creditop - Eliminar Cuenta',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'),
        Locale('en'),
      ],
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: CdsColors.neutral.shade100,
        fontFamily: CdsTypography.fontFamily,
      ),
    );
  }
}
