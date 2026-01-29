/// Entornos de ejecución disponibles.
enum AppEnvironment {
  /// Mock: sin llamadas reales, OTP válido "1234"
  mock,

  /// Development: Cognito real con backend dev
  dev,

  /// Production: Cognito real con backend producción
  production;

  bool get isMock => this == AppEnvironment.mock;
  bool get isDev => this == AppEnvironment.dev;
  bool get isProduction => this == AppEnvironment.production;

  /// Si usa backend real (dev o production).
  bool get usesRealBackend => !isMock;
}
