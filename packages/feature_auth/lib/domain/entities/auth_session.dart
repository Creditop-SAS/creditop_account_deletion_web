/// Representa una sesión de autenticación con tokens JWT de Cognito.
class AuthSession {
  const AuthSession({
    required this.accessToken,
    this.idToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String? idToken;
  final String refreshToken;

  bool get hasIdToken => idToken != null && idToken!.isNotEmpty;

  AuthSession copyWith({
    String? accessToken,
    String? idToken,
    String? refreshToken,
  }) {
    return AuthSession(
      accessToken: accessToken ?? this.accessToken,
      idToken: idToken ?? this.idToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthSession &&
        other.accessToken == accessToken &&
        other.idToken == idToken &&
        other.refreshToken == refreshToken;
  }

  @override
  int get hashCode => Object.hash(accessToken, idToken, refreshToken);

  @override
  String toString() => 'AuthSession(tokens: [REDACTED])';
}
