import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:feature_auth/feature_auth.dart';
import 'package:feature_delete_account/feature_delete_account.dart';

import 'package:creditop_account_deletion_web/config/app_environment.dart';
import 'package:creditop_account_deletion_web/config/environment_config.dart';
import 'package:creditop_account_deletion_web/current_environment.dart';
import 'package:creditop_account_deletion_web/infrastructure/auth/datasources/cognito_datasource.dart';
import 'package:creditop_account_deletion_web/infrastructure/auth/gateways/auth_gateway_mock.dart';
import 'package:creditop_account_deletion_web/infrastructure/auth/gateways/cognito_auth_gateway_impl.dart';
import 'package:creditop_account_deletion_web/infrastructure/delete_account/datasources/delete_account_datasource.dart';
import 'package:creditop_account_deletion_web/infrastructure/delete_account/gateways/delete_account_gateway_impl.dart';
import 'package:creditop_account_deletion_web/infrastructure/delete_account/gateways/delete_account_gateway_mock.dart';

// ============================================================================
// AUTH GATEWAY
// ============================================================================

AuthGateway createAuthGateway() {
  const env = CurrentEnvironment.environment;
  return switch (env) {
    AppEnvironment.mock => AuthGatewayMock(),
    _ => CognitoAuthGatewayImpl(CognitoDatasource()),
  };
}

// ============================================================================
// DELETE ACCOUNT GATEWAY
// ============================================================================

DeleteAccountGateway createDeleteAccountGateway() {
  const env = CurrentEnvironment.environment;
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
