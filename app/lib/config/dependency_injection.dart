import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:feature_auth/feature_auth.dart';
import 'package:feature_delete_account/feature_delete_account.dart';

import '../current_environment.dart';
import '../infrastructure/auth/datasources/cognito_datasource.dart';
import '../infrastructure/auth/gateways/auth_gateway_mock.dart';
import '../infrastructure/auth/gateways/cognito_auth_gateway_impl.dart';
import '../infrastructure/delete_account/datasources/delete_account_datasource.dart';
import '../infrastructure/delete_account/gateways/delete_account_gateway_impl.dart';
import '../infrastructure/delete_account/gateways/delete_account_gateway_mock.dart';
import 'app_environment.dart';
import 'environment_config.dart';

// ============================================================================
// AUTH GATEWAY
// ============================================================================

AuthGateway createAuthGateway() {
  final env = CurrentEnvironment.environment;
  return switch (env) {
    AppEnvironment.mock => AuthGatewayMock(),
    _ => CognitoAuthGatewayImpl(CognitoDatasource()),
  };
}

// ============================================================================
// DELETE ACCOUNT GATEWAY
// ============================================================================

DeleteAccountGateway createDeleteAccountGateway() {
  final env = CurrentEnvironment.environment;
  return switch (env) {
    AppEnvironment.mock => DeleteAccountGatewayMock(),
    _ => DeleteAccountGatewayImpl(
        DeleteAccountDatasource(_createAuthenticatedDio(env)),
      ),
  };
}

// ============================================================================
// AUTHENTICATED DIO (internal helper)
// ============================================================================

Dio _createAuthenticatedDio(AppEnvironment env) {
  final baseUrl = EnvironmentConfig.getApiBaseUrl(env);

  return DioClient.create(
    baseUrl: baseUrl,
    interceptors: [
      AuthInterceptor(
        getToken: () async {
          try {
            final session = await Amplify.Auth.fetchAuthSession();
            if (session is CognitoAuthSession) {
              return session.userPoolTokensResult.value.accessToken.raw;
            }
          } catch (_) {}
          return null;
        },
      ),
    ],
  );
}
