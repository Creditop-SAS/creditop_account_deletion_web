import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:core/core.dart';
import 'package:feature_auth/feature_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:creditop_account_deletion_web/infrastructure/auth/datasources/cognito_datasource.dart';
import 'package:creditop_account_deletion_web/infrastructure/auth/models/auth_session_dto.dart';

/// Implementación real del gateway de auth usando Cognito.
/// Solo para usuarios existentes (no registro).
class CognitoAuthGatewayImpl implements AuthGateway {
  const CognitoAuthGatewayImpl(this._datasource);

  final CognitoDatasource _datasource;

  @override
  Future<(ErrorItem?, void)> requestOtp(String phoneNumber) async {
    try {
      if (kDebugMode) {
        debugPrint('[CognitoAuthGateway] Solicitando OTP');
      }

      final result = await _datasource.signIn(phoneNumber);

      if (kDebugMode) {
        debugPrint(
          '[CognitoAuthGateway] SignIn step: ${result.nextStep.signInStep}',
        );
      }

      return (null, null);
    } on AuthException catch (e) {
      if (kDebugMode) {
        debugPrint('[CognitoAuthGateway] AuthException: ${e.message}');
      }
      return (_mapAuthException(e), null);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('[CognitoAuthGateway] Error inesperado: $e');
      }
      return (
        const ErrorItem(
          code: 'unexpected',
          title: 'Error inesperado',
          message: 'Ocurrió un error. Intenta nuevamente.',
          category: ErrorCategory.modal,
        ),
        null,
      );
    }
  }

  @override
  Future<(ErrorItem?, OtpVerificationResult?)> verifyOtp(
    String phoneNumber,
    String otpCode,
  ) async {
    try {
      if (kDebugMode) {
        debugPrint('[CognitoAuthGateway] Verificando OTP');
      }

      final result = await _datasource.confirmSignIn(otpCode);

      if (result.isSignedIn) {
        final cognitoSession = await _datasource.fetchAuthSession();
        final session = cognitoSession.toDomain();

        if (kDebugMode) {
          debugPrint('[CognitoAuthGateway] OTP verificado exitosamente');
        }
        return (
          null,
          OtpVerificationAuthenticated(session: session),
        );
      }

      return (
        const ErrorItem(
          code: 'verification_failed',
          title: 'Verificación fallida',
          message: 'No se pudo completar la verificación.',
          category: ErrorCategory.modal,
        ),
        null,
      );
    } on AuthException catch (e) {
      if (kDebugMode) {
        debugPrint('[CognitoAuthGateway] AuthException: ${e.message}');
      }
      return (_mapAuthException(e), null);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('[CognitoAuthGateway] Error inesperado: $e');
      }
      return (
        const ErrorItem(
          code: 'unexpected',
          title: 'Error inesperado',
          message: 'Ocurrió un error. Intenta nuevamente.',
          category: ErrorCategory.modal,
        ),
        null,
      );
    }
  }

  ErrorItem _mapAuthException(AuthException e) {
    return switch (e) {
      UserNotFoundException() => const ErrorItem(
          code: 'user_not_found',
          title: 'Usuario no encontrado',
          message: 'Este número no está registrado en Creditop.',
          category: ErrorCategory.modal,
        ),
      CodeMismatchException() => const ErrorItem(
          code: 'invalid_otp',
          title: 'Código incorrecto',
          message: 'El código ingresado no es válido. Intenta nuevamente.',
          category: ErrorCategory.modal,
        ),
      LimitExceededException() => const ErrorItem(
          code: 'rate_limit',
          title: 'Demasiados intentos',
          message: 'Has excedido el límite de intentos. Espera unos minutos.',
          category: ErrorCategory.modal,
        ),
      NotAuthorizedServiceException() => const ErrorItem(
          code: 'not_authorized',
          title: 'No autorizado',
          message: 'No se pudo completar la operación. Intenta nuevamente.',
          category: ErrorCategory.modal,
        ),
      _ => const ErrorItem(
          code: 'auth_error',
          title: 'Error de autenticación',
          message: 'Ocurrió un error. Intenta nuevamente.',
          category: ErrorCategory.modal,
        ),
    };
  }
}
