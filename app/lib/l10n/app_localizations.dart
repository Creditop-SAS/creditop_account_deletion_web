import 'package:flutter/material.dart';

/// Localización manual de la aplicación.
///
/// Se usa directamente en vez de gen-l10n para simplificar el setup web.
class AppLocalizations {
  const AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        const AppLocalizations(Locale('es'));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  bool get _isEs => locale.languageCode == 'es';

  // ========================
  // LANDING
  // ========================
  String get landingTitle =>
      _isEs ? 'Eliminación de cuenta' : 'Account Deletion';
  String get landingDescription => _isEs
      ? 'Creditop te permite solicitar la eliminación de tu cuenta y datos personales. Este proceso es irreversible.'
      : 'Creditop allows you to request the deletion of your account and personal data. This process is irreversible.';
  String get landingStep1 => _isEs
      ? 'Verifica tu identidad con tu número de teléfono'
      : 'Verify your identity with your phone number';
  String get landingStep2 => _isEs
      ? 'Ingresa el código de verificación enviado por SMS'
      : 'Enter the verification code sent via SMS';
  String get landingStep3 => _isEs
      ? 'Revisa qué datos se eliminarán y cuáles se conservarán'
      : 'Review which data will be deleted and which will be retained';
  String get landingStep4 => _isEs
      ? 'Confirma la eliminación de tu cuenta'
      : 'Confirm the deletion of your account';
  String get landingButton => _isEs
      ? 'Iniciar proceso de eliminación'
      : 'Start deletion process';
  String get landingPrivacyPolicy => _isEs
      ? 'Política de privacidad'
      : 'Privacy policy';

  // ========================
  // PHONE INPUT
  // ========================
  String get phoneInputTitle =>
      _isEs ? 'Verificar identidad' : 'Verify identity';
  String get phoneInputSubtitle => _isEs
      ? 'Ingresa tu número de teléfono registrado en Creditop para verificar tu identidad.'
      : 'Enter your phone number registered in Creditop to verify your identity.';
  String get phoneInputLabel =>
      _isEs ? 'Número de teléfono' : 'Phone number';
  String get phoneInputHint => '300 123 4567';
  String get phoneInputPrefix => '+57 ';
  String get phoneInputButton =>
      _isEs ? 'Enviar código' : 'Send code';
  String get phoneInputError => _isEs
      ? 'Ingresa un número de teléfono válido de 10 dígitos'
      : 'Enter a valid 10-digit phone number';

  // ========================
  // OTP VERIFICATION
  // ========================
  String get otpTitle =>
      _isEs ? 'Verificar código' : 'Verify code';
  String get otpSubtitle => _isEs
      ? 'Ingresa el código de 4 dígitos que enviamos a tu teléfono'
      : 'Enter the 4-digit code we sent to your phone';
  String get otpResend =>
      _isEs ? 'Reenviar código' : 'Resend code';
  String get otpResendCountdown =>
      _isEs ? 'Reenviar en' : 'Resend in';
  String get otpButton =>
      _isEs ? 'Verificar' : 'Verify';
  String get otpError => _isEs
      ? 'El código ingresado no es válido'
      : 'The code entered is not valid';

  // ========================
  // DATA INFO
  // ========================
  String get dataInfoTitle => _isEs
      ? 'Información sobre tus datos'
      : 'Information about your data';
  String get dataInfoDeletedTitle =>
      _isEs ? 'Datos que se eliminarán' : 'Data that will be deleted';
  String get dataInfoDeleted1 => _isEs
      ? 'Información personal (nombre, email, teléfono)'
      : 'Personal information (name, email, phone)';
  String get dataInfoDeleted2 => _isEs
      ? 'Historial de navegación en la app'
      : 'App browsing history';
  String get dataInfoDeleted3 => _isEs
      ? 'Preferencias y configuraciones'
      : 'Preferences and settings';
  String get dataInfoDeleted4 => _isEs
      ? 'Tokens de sesión'
      : 'Session tokens';
  String get dataInfoRetainedTitle => _isEs
      ? 'Datos que se conservarán'
      : 'Data that will be retained';
  String get dataInfoRetained1 => _isEs
      ? 'Historial de créditos (requerido por la SFC por 10 años)'
      : 'Credit history (required by SFC for 10 years)';
  String get dataInfoRetained2 => _isEs
      ? 'Registros de transacciones'
      : 'Transaction records';
  String get dataInfoRetained3 => _isEs
      ? 'Información para prevención de fraude'
      : 'Fraud prevention information';
  String get dataInfoRetainedNote => _isEs
      ? 'Por regulación de la Superintendencia Financiera de Colombia, ciertos datos deben conservarse por un período mínimo de 10 años.'
      : 'By regulation of the Colombian Financial Superintendency, certain data must be retained for a minimum period of 10 years.';
  String get dataInfoActiveCreditNote => _isEs
      ? 'Si tienes créditos activos con Creditop, tu cuenta no podrá ser eliminada hasta que el crédito sea saldado en su totalidad.'
      : 'If you have active loans with Creditop, your account cannot be deleted until the loan is fully paid off.';
  String get dataInfoContinue => _isEs
      ? 'Continuar con la eliminación'
      : 'Continue with deletion';
  String get dataInfoCancel =>
      _isEs ? 'Cancelar' : 'Cancel';

  // ========================
  // CONFIRMATION
  // ========================
  String get confirmTitle => _isEs
      ? 'Confirmar eliminación de cuenta'
      : 'Confirm account deletion';
  String get confirmWarning1 => _isEs
      ? 'Esta acción es irreversible. No podrás recuperar tu cuenta.'
      : 'This action is irreversible. You will not be able to recover your account.';
  String get confirmWarning2 => _isEs
      ? 'Perderás acceso a tu cuenta y todos los servicios de Creditop.'
      : 'You will lose access to your account and all Creditop services.';
  String get confirmWarning3 => _isEs
      ? 'Los datos regulados se conservarán según la normativa vigente de la SFC.'
      : 'Regulated data will be retained according to current SFC regulations.';
  String get confirmDeleteButton =>
      _isEs ? 'Eliminar mi cuenta' : 'Delete my account';
  String get confirmCancelButton =>
      _isEs ? 'Cancelar' : 'Cancel';
  String get confirmModalTitle => _isEs
      ? '¿Estás seguro?'
      : 'Are you sure?';
  String get confirmModalMessage => _isEs
      ? 'Esta acción eliminará permanentemente tu cuenta de Creditop. No podrás revertir esta decisión.'
      : 'This action will permanently delete your Creditop account. You cannot undo this decision.';
  String get confirmModalConfirm => _isEs
      ? 'Sí, eliminar mi cuenta'
      : 'Yes, delete my account';
  String get confirmModalCancel =>
      _isEs ? 'No, conservar mi cuenta' : 'No, keep my account';

  // ========================
  // SUCCESS
  // ========================
  String get successTitle =>
      _isEs ? 'Solicitud procesada' : 'Request processed';
  String get successMessage => _isEs
      ? 'Tu cuenta ha sido eliminada exitosamente. Lamentamos verte partir.'
      : 'Your account has been successfully deleted. We are sorry to see you go.';
  String get successRetainedNote => _isEs
      ? 'Los datos financieros regulados por la SFC serán conservados por el período legal requerido (10 años).'
      : 'Financial data regulated by the SFC will be retained for the legally required period (10 years).';
  String get successButton =>
      _isEs ? 'Entendido' : 'Understood';
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['es', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
