import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:feature_delete_account/feature_delete_account.dart';
import 'package:flutter/foundation.dart';

import 'package:creditop_account_deletion_web/infrastructure/delete_account/datasources/delete_account_datasource.dart';
import 'package:creditop_account_deletion_web/infrastructure/delete_account/models/delete_account_response_dto.dart';

/// Implementación real del gateway de eliminación de cuenta.
class DeleteAccountGatewayImpl implements DeleteAccountGateway {
  const DeleteAccountGatewayImpl(this._datasource);

  final DeleteAccountDatasource _datasource;

  @override
  Future<(ErrorItem?, void)> deleteAccount() async {
    try {
      if (kDebugMode) {
        debugPrint('[DeleteAccountGateway] Eliminando cuenta');
      }

      final response = await _datasource.deleteAccount();

      if (response.data == null) {
        return (
          const ErrorItem(
            code: 'null_response',
            title: 'Error del servidor',
            message: 'El servidor no devolvió datos.',
            category: ErrorCategory.totalPage,
          ),
          null,
        );
      }

      final dto = DeleteAccountResponseDto.fromJson(response.data!);
      if (kDebugMode) {
        debugPrint('[DeleteAccountGateway] Response code: ${dto.code}');
      }

      if (dto.isSuccess) {
        if (kDebugMode) {
          debugPrint('[DeleteAccountGateway] Cuenta eliminada exitosamente');
        }
        return (null, null);
      }

      return (_mapErrorCode(dto), null);
    } on DioException catch (e) {
      return (_handleDioException(e), null);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('[DeleteAccountGateway] Error inesperado: $e');
      }
      return (
        const ErrorItem(
          code: 'unexpected',
          title: 'Error inesperado',
          message: 'Ocurrió un error. Intenta nuevamente.',
          category: ErrorCategory.totalPage,
        ),
        null,
      );
    }
  }

  ErrorItem _mapErrorCode(DeleteAccountResponseDto dto) {
    if (dto.isNotFound) {
      return const ErrorItem(
        code: 'MOBA4002',
        title: 'Usuario no encontrado',
        message: 'No se encontró la cuenta asociada.',
        category: ErrorCategory.modal,
      );
    }
    if (dto.isNotAllowed) {
      return ErrorItem(
        code: 'MOBA4003',
        title: 'No se puede eliminar',
        message: dto.message ?? 'Tu cuenta no puede ser eliminada en este momento.',
        category: ErrorCategory.modal,
      );
    }
    return ErrorItem(
      code: dto.code,
      title: 'Error del servidor',
      message: dto.message ?? 'Ocurrió un error en el servidor.',
      category: ErrorCategory.totalPage,
    );
  }

  ErrorItem _handleDioException(DioException e) {
    if (kDebugMode) {
      debugPrint('[DeleteAccountGateway] DioException: ${e.message}');
    }

    // Intentar extraer código MOBA del response
    final responseData = e.response?.data;
    if (responseData is Map<String, dynamic>) {
      final code = responseData['code'] as String?;
      if (code != null) {
        return _mapErrorCode(DeleteAccountResponseDto.fromJson(responseData));
      }
    }

    return switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        const ErrorItem(
          code: 'timeout',
          title: 'Conexión lenta',
          message: 'La conexión tardó demasiado. Intenta nuevamente.',
          category: ErrorCategory.totalPage,
        ),
      DioExceptionType.connectionError => const ErrorItem(
          code: 'connection_error',
          title: 'Sin conexión',
          message: 'Verifica tu conexión a internet.',
          category: ErrorCategory.totalPage,
        ),
      _ => const ErrorItem(
          code: 'network_error',
          title: 'Error de red',
          message: 'Ocurrió un error de red. Intenta nuevamente.',
          category: ErrorCategory.totalPage,
        ),
    };
  }
}
