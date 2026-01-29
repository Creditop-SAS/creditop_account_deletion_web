import 'package:core/core.dart';
import 'package:feature_delete_account/feature_delete_account.dart';
import 'package:flutter/foundation.dart';

/// Mock del gateway de eliminación de cuenta.
class DeleteAccountGatewayMock implements DeleteAccountGateway {
  @override
  Future<ErrorItem?> deleteAccount() async {
    debugPrint('[DeleteAccountGatewayMock] Simulando eliminación de cuenta');
    await Future<void>.delayed(const Duration(milliseconds: 1500));
    debugPrint('[DeleteAccountGatewayMock] Cuenta eliminada (mock)');
    return null;
  }
}
