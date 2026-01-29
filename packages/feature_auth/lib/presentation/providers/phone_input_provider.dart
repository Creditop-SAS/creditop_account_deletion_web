import 'package:core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:feature_auth/domain/gateways/auth_gateway_provider.dart';
import 'package:feature_auth/presentation/providers/phone_input_state.dart';

part 'phone_input_provider.g.dart';

/// Provider para la lógica de input de teléfono.
@riverpod
class PhoneInputNotifier extends _$PhoneInputNotifier {
  @override
  PhoneInputState build() => const PhoneInputState();

  void updatePhone(String phone) {
    state = state.copyWith(phone: phone, clearPhoneError: true);
  }

  Future<bool> requestOtp() async {
    if (!PhoneValidator.isValidPhone(state.phone)) {
      state = state.copyWith(phoneError: 'invalid_phone');
      return false;
    }

    state = state.copyWith(isLoading: true);

    final phoneWithCode = PhoneValidator.formatWithCountryCode(state.phone);
    final (error, _) = await ref.read(authGatewayProvider).requestOtp(
      phoneWithCode,
    );

    if (!ref.mounted) return false;

    if (error != null) {
      state = state.copyWith(
        isLoading: false,
        phoneError: error.message,
      );
      return false;
    }

    state = state.copyWith(isLoading: false);
    return true;
  }
}
