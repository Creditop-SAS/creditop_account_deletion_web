/// Categorías de visualización de errores en la UI.
enum ErrorCategory {
  /// Modal/Dialog centrado con overlay oscuro.
  modal,

  /// Página completa de error con navegación push.
  totalPage,

  /// Notificación temporal en parte superior (auto-dismiss).
  toast,
}
