import 'package:core/core.dart';

/// Gateway para operaciones de eliminación de cuenta.
abstract class DeleteAccountGateway {
  /// Elimina la cuenta del usuario autenticado.
  /// Retorna null si fue exitoso, ErrorItem si hubo error.
  Future<ErrorItem?> deleteAccount();
}
