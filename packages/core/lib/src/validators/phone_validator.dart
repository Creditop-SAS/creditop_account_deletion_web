/// Validador de números de teléfono y OTP para Colombia.
class PhoneValidator {
  PhoneValidator._();

  /// Regex para número de teléfono colombiano (10 dígitos, empieza con 3).
  static final RegExp _phoneRegex = RegExp(r'^3\d{9}$');

  /// Regex para código OTP (4 dígitos).
  static final RegExp _otpRegex = RegExp(r'^\d{4}$');

  /// Valida un número de teléfono colombiano (sin código de país).
  static bool isValidPhone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'\s+'), '');
    return _phoneRegex.hasMatch(cleaned);
  }

  /// Valida un código OTP de 4 dígitos.
  static bool isValidOtp(String otp) {
    return _otpRegex.hasMatch(otp);
  }

  /// Formatea un número de teléfono con código de país Colombia.
  static String formatWithCountryCode(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'\s+'), '');
    return '+57$cleaned';
  }
}
