import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Configuración de AWS Amplify para Cognito.
class AmplifyConfiguration {
  const AmplifyConfiguration._();

  static String get region =>
      dotenv.get('COGNITO_REGION', fallback: 'us-east-1');

  static String get userPoolId =>
      dotenv.get('COGNITO_USER_POOL_ID', fallback: '');

  static String get appClientId =>
      dotenv.get('COGNITO_CLIENT_ID', fallback: '');

  static String get appClientSecret =>
      dotenv.get('COGNITO_CLIENT_SECRET', fallback: '');

  static void validateConfiguration() {
    if (userPoolId.isEmpty) {
      throw ArgumentError('COGNITO_USER_POOL_ID no configurado en .env');
    }
    if (appClientId.isEmpty) {
      throw ArgumentError('COGNITO_CLIENT_ID no configurado en .env');
    }
  }

  static String get amplifyConfig => '''
{
  "UserAgent": "aws-amplify-cli/2.0",
  "Version": "1.0",
  "auth": {
    "plugins": {
      "awsCognitoAuthPlugin": {
        "UserAgent": "aws-amplify-cli/0.1.0",
        "Version": "0.1.0",
        "IdentityManager": {
          "Default": {}
        },
        "CredentialsProvider": {
          "CognitoIdentity": {
            "Default": {
              "PoolId": "",
              "Region": "$region"
            }
          }
        },
        "CognitoUserPool": {
          "Default": {
            "PoolId": "$userPoolId",
            "AppClientId": "$appClientId",
            ${appClientSecret.isNotEmpty ? '"AppClientSecret": "$appClientSecret",' : ''}
            "Region": "$region"
          }
        },
        "Auth": {
          "Default": {
            "authenticationFlowType": "CUSTOM_AUTH_WITHOUT_SRP"
          }
        }
      }
    }
  }
}
''';
}
