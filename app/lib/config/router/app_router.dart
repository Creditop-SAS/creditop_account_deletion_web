import 'package:feature_auth/feature_auth.dart';
import 'package:feature_delete_account/feature_delete_account.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/app_localizations.dart';

/// Rutas de la aplicación.
abstract class AppRoutes {
  static const String landing = '/';
  static const String phoneInput = '/verificar-telefono';
  static const String otpVerification = '/verificar-otp';
  static const String dataInfo = '/informacion-datos';
  static const String deleteConfirmation = '/confirmar-eliminacion';
  static const String deleteSuccess = '/eliminacion-exitosa';
}

/// Crea el GoRouter de la aplicación.
GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: AppRoutes.landing,
    routes: [
      GoRoute(
        path: AppRoutes.landing,
        builder: (context, state) {
          final strings = AppLocalizations.of(context);
          return LandingPage(
            strings: LandingStrings(
              title: strings.landingTitle,
              description: strings.landingDescription,
              step1: strings.landingStep1,
              step2: strings.landingStep2,
              step3: strings.landingStep3,
              step4: strings.landingStep4,
              buttonLabel: strings.landingButton,
              privacyPolicyLabel: strings.landingPrivacyPolicy,
            ),
            onStartProcess: () => context.go(AppRoutes.phoneInput),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.phoneInput,
        builder: (context, state) {
          final strings = AppLocalizations.of(context);
          return PhoneInputPage(
            strings: PhoneInputStrings(
              title: strings.phoneInputTitle,
              subtitle: strings.phoneInputSubtitle,
              phoneLabel: strings.phoneInputLabel,
              phoneHint: strings.phoneInputHint,
              phonePrefix: strings.phoneInputPrefix,
              buttonLabel: strings.phoneInputButton,
              invalidPhoneError: strings.phoneInputError,
            ),
            onOtpRequested: (phone) => context.go(
              AppRoutes.otpVerification,
              extra: phone,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.otpVerification,
        builder: (context, state) {
          final phone = state.extra as String? ?? '';
          final strings = AppLocalizations.of(context);
          return OtpVerificationPage(
            phoneNumber: phone.isNotEmpty ? '+57$phone' : '',
            strings: OtpVerificationStrings(
              title: strings.otpTitle,
              subtitle: strings.otpSubtitle,
              resendLabel: strings.otpResend,
              resendCountdown: strings.otpResendCountdown,
              buttonLabel: strings.otpButton,
              invalidOtpError: strings.otpError,
            ),
            onVerified: () => context.go(AppRoutes.dataInfo),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.dataInfo,
        builder: (context, state) {
          final strings = AppLocalizations.of(context);
          return DataInfoPage(
            strings: DataInfoStrings(
              title: strings.dataInfoTitle,
              deletedDataTitle: strings.dataInfoDeletedTitle,
              deletedDataItems: [
                strings.dataInfoDeleted1,
                strings.dataInfoDeleted2,
                strings.dataInfoDeleted3,
                strings.dataInfoDeleted4,
              ],
              retainedDataTitle: strings.dataInfoRetainedTitle,
              retainedDataItems: [
                strings.dataInfoRetained1,
                strings.dataInfoRetained2,
                strings.dataInfoRetained3,
              ],
              retainedDataNote: strings.dataInfoRetainedNote,
              continueButtonLabel: strings.dataInfoContinue,
              cancelButtonLabel: strings.dataInfoCancel,
            ),
            onContinue: () => context.go(AppRoutes.deleteConfirmation),
            onCancel: () => context.go(AppRoutes.landing),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.deleteConfirmation,
        builder: (context, state) {
          final strings = AppLocalizations.of(context);
          return DeleteConfirmationPage(
            strings: DeleteConfirmationStrings(
              title: strings.confirmTitle,
              warningIrreversible: strings.confirmWarning1,
              warningLoseAccess: strings.confirmWarning2,
              warningRegulatedData: strings.confirmWarning3,
              deleteButtonLabel: strings.confirmDeleteButton,
              cancelButtonLabel: strings.confirmCancelButton,
              modalTitle: strings.confirmModalTitle,
              modalMessage: strings.confirmModalMessage,
              modalConfirmLabel: strings.confirmModalConfirm,
              modalCancelLabel: strings.confirmModalCancel,
            ),
            onDeleted: () => context.go(AppRoutes.deleteSuccess),
            onCancel: () => context.go(AppRoutes.landing),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.deleteSuccess,
        builder: (context, state) {
          final strings = AppLocalizations.of(context);
          return DeleteSuccessPage(
            strings: DeleteSuccessStrings(
              title: strings.successTitle,
              message: strings.successMessage,
              retainedDataNote: strings.successRetainedNote,
              buttonLabel: strings.successButton,
            ),
            onDone: () => context.go(AppRoutes.landing),
          );
        },
      ),
    ],
  );
}
