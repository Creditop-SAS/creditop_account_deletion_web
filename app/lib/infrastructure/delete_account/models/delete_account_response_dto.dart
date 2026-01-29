/// DTO para respuesta de eliminación de cuenta.
///
/// Códigos posibles:
/// - MOBA4001: Usuario eliminado correctamente
/// - MOBA4002: Usuario no encontrado
/// - MOBA4003: Usuario no puede ser eliminado
/// - MOBA4004: Error interno del servidor
class DeleteAccountResponseDto {
  const DeleteAccountResponseDto({
    required this.code,
    this.message,
  });

  final String code;
  final String? message;

  factory DeleteAccountResponseDto.fromJson(Map<String, dynamic> json) {
    return DeleteAccountResponseDto(
      code: json['code'] as String? ?? '',
      message: json['message'] as String?,
    );
  }

  bool get isSuccess => code == 'MOBA4001';
  bool get isNotFound => code == 'MOBA4002';
  bool get isNotAllowed => code == 'MOBA4003';
  bool get isServerError => code == 'MOBA4004';
}
