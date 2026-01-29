import 'package:dio/dio.dart';

/// DataSource HTTP para eliminación de cuenta.
class DeleteAccountDatasource {
  const DeleteAccountDatasource(this._dio);

  final Dio _dio;

  static const String _path = '/legacy-api/onboarding/mobile/delete-user';

  /// Elimina la cuenta del usuario autenticado.
  /// El backend extrae el userId del token JWT.
  Future<Response<Map<String, dynamic>>> deleteAccount() async {
    return await _dio.delete<Map<String, dynamic>>(_path);
  }
}
