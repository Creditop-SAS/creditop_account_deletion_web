import 'config/app_environment.dart';

/// Configuración del entorno actual.
///
/// Cambiar este valor para alternar entre mock/dev/production.
abstract class CurrentEnvironment {
  CurrentEnvironment._();

  /// Entorno activo. Cambiar aquí para alternar.
  static const AppEnvironment environment = AppEnvironment.mock;

  /// Si usa Cognito real.
  static bool get usesRealBackend => environment.usesRealBackend;
}
