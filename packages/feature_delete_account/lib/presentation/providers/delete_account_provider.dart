import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/gateways/delete_account_gateway_provider.dart';
import 'delete_account_state.dart';

part 'delete_account_provider.g.dart';

/// Provider para la lógica de eliminación de cuenta.
@riverpod
class DeleteAccountNotifier extends _$DeleteAccountNotifier {
  @override
  DeleteAccountState build() => const DeleteAccountState();

  Future<bool> deleteAccount() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final error = await ref.read(deleteAccountGatewayProvider).deleteAccount();

    if (!ref.mounted) return false;

    if (error != null) {
      state = state.copyWith(isLoading: false, error: error);
      return false;
    }

    state = state.copyWith(isLoading: false, isDeleted: true);
    return true;
  }
}
