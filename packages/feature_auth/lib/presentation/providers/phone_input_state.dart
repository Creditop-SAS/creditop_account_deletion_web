import 'package:flutter/foundation.dart';

/// Estado de la página de input de teléfono.
@immutable
final class PhoneInputState {
  const PhoneInputState({
    this.phone = '',
    this.isLoading = false,
    this.phoneError,
  });

  final String phone;
  final bool isLoading;
  final String? phoneError;

  bool get isValid => phone.length == 10 && phone.startsWith('3');

  PhoneInputState copyWith({
    String? phone,
    bool? isLoading,
    String? phoneError,
    bool clearPhoneError = false,
  }) {
    return PhoneInputState(
      phone: phone ?? this.phone,
      isLoading: isLoading ?? this.isLoading,
      phoneError: clearPhoneError ? null : (phoneError ?? this.phoneError),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PhoneInputState &&
        other.phone == phone &&
        other.isLoading == isLoading &&
        other.phoneError == phoneError;
  }

  @override
  int get hashCode => Object.hash(phone, isLoading, phoneError);
}
