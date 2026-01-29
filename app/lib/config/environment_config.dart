import 'package:creditop_account_deletion_web/config/app_environment.dart';

/// Configuración por entorno.
abstract class EnvironmentConfig {
  EnvironmentConfig._();

  /// URL base de la API según el entorno.
  static String getApiBaseUrl(AppEnvironment env) => switch (env) {
        AppEnvironment.mock => 'https://mock.api.creditop.com',
        AppEnvironment.dev => 'https://api.dev.creditop.com',
        AppEnvironment.production => 'https://v2.api.creditop.com',
      };

  /// Nombre del archivo .env según el entorno.
  static String getEnvFileName(AppEnvironment env) => switch (env) {
        AppEnvironment.mock => '.env.dev',
        AppEnvironment.dev => '.env.dev',
        AppEnvironment.production => '.env',
      };
}
