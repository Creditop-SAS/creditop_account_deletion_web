import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';

/// DataSource para autenticación con AWS Cognito Custom Auth.
///
/// Flujo Custom Auth sin SRP:
/// 1. signIn(username) -> Cognito envía OTP
/// 2. confirmSignIn(otp) -> Valida OTP, retorna sesión
class CognitoDatasource {
  /// Inicia sesión con Custom Auth (envía OTP al teléfono).
  Future<SignInResult> signIn(String phoneNumber) async {
    // Cerrar sesión previa si existe
    await _ensureSignedOut();

    if (kDebugMode) {
      debugPrint('[CognitoDatasource] Iniciando signIn para: ${_redactPhone(phoneNumber)}');
    }

    return await Amplify.Auth.signIn(
      username: phoneNumber,
      options: const SignInOptions(
        pluginOptions: CognitoSignInPluginOptions(
          authFlowType: AuthenticationFlowType.customAuthWithoutSrp,
        ),
      ),
    );
  }

  /// Confirma el código OTP ingresado por el usuario.
  Future<SignInResult> confirmSignIn(String otpCode) async {
    if (kDebugMode) {
      debugPrint('[CognitoDatasource] Confirmando OTP');
    }

    return await Amplify.Auth.confirmSignIn(
      confirmationValue: otpCode,
    );
  }

  /// Obtiene la sesión de autenticación actual.
  Future<CognitoAuthSession> fetchAuthSession({
    bool forceRefresh = false,
  }) async {
    final session = await Amplify.Auth.fetchAuthSession(
      options: FetchAuthSessionOptions(forceRefresh: forceRefresh),
    );
    return session as CognitoAuthSession;
  }

  /// Cierra la sesión actual.
  Future<void> signOut() async {
    await Amplify.Auth.signOut();
  }

  /// Asegura que no hay sesión previa activa.
  Future<void> _ensureSignedOut() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();
      if (session.isSignedIn) {
        if (kDebugMode) {
          debugPrint('[CognitoDatasource] Cerrando sesión previa');
        }
        await Amplify.Auth.signOut();
      }
    } on SignedOutException {
      // Esperado: no hay sesión activa
    } catch (e) {
      if (kDebugMode) {
        debugPrint('[CognitoDatasource] Error al verificar sesión: $e');
      }
    }
  }

  /// Redacta el número de teléfono para logging seguro.
  static String _redactPhone(String phone) {
    if (phone.length <= 4) return '***';
    return '${phone.substring(0, 3)}***${phone.substring(phone.length - 4)}';
  }
}
