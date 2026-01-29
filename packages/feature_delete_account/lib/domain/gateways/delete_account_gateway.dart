import 'package:core/core.dart';

/// Gateway para operaciones de eliminación de cuenta.
abstract class DeleteAccountGateway {
  /// Elimina la cuenta del usuario autenticado.
  /// Retorna (null, null) si fue exitoso, (ErrorItem, null) si hubo error.
  Future<(ErrorItem?, void)> deleteAccount();
}
