import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:feature_auth/domain/entities/auth_session.dart' as domain;

/// Extension para convertir CognitoAuthSession a AuthSession del dominio.
extension AuthSessionDto on CognitoAuthSession {
  /// Convierte la sesión de Cognito a la entidad de dominio.
  domain.AuthSession toDomain() {
    return domain.AuthSession(
      accessToken: userPoolTokensResult.value.accessToken.raw,
      idToken: userPoolTokensResult.value.idToken.raw,
      refreshToken: userPoolTokensResult.value.refreshToken,
    );
  }
}
