import 'package:cds_web/cds_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/delete_confirmation_strings.dart';
import '../providers/delete_account_provider.dart';

/// Página de confirmación de eliminación de cuenta.
class DeleteConfirmationPage extends ConsumerWidget {
  const DeleteConfirmationPage({
    required this.strings,
    required this.onDeleted,
    required this.onCancel,
    super.key,
  });

  final DeleteConfirmationStrings strings;
  final VoidCallback onDeleted;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(deleteAccountProvider);

    ref.listen(deleteAccountProvider, (prev, next) {
      if (next.isDeleted && !(prev?.isDeleted ?? false)) {
        onDeleted();
      }
      if (next.error != null && prev?.error == null) {
        CtErrorModal.show(
          context: context,
          title: next.error!.title ?? 'Error',
          message: next.error!.message ?? 'Ocurrió un error inesperado.',
          primaryButtonLabel: next.error!.primaryButtonLabel ?? 'Entendido',
          onPrimaryPressed: () {},
        );
      }
    });

    return CtWebScaffold(
      body: Column(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: 56,
            color: CdsColors.naranja.shade500,
          ),
          const SizedBox(height: CdsSpacing.lg),
          Text(
            strings.title,
            style: CdsTypography.heading.xxsmall.copyWith(
              color: CdsColors.neutral.shade900,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: CdsSpacing.xl),
          CtInlineAlert(
            message: strings.warningIrreversible,
            type: CtInlineAlertType.error,
          ),
          const SizedBox(height: CdsSpacing.md),
          CtInlineAlert(
            message: strings.warningLoseAccess,
            type: CtInlineAlertType.warning,
          ),
          const SizedBox(height: CdsSpacing.md),
          CtInlineAlert(
            message: strings.warningRegulatedData,
            type: CtInlineAlertType.info,
          ),
          const SizedBox(height: CdsSpacing.xl),
          CtButton(
            label: strings.deleteButtonLabel,
            isLoading: state.isLoading,
            variant: CtButtonVariant.destructive,
            onPressed: state.isLoading
                ? null
                : () => _showConfirmationModal(context, ref),
          ),
          const SizedBox(height: CdsSpacing.md),
          CtButton(
            label: strings.cancelButtonLabel,
            onPressed: state.isLoading ? null : onCancel,
            variant: CtButtonVariant.ghost,
          ),
        ],
      ),
    );
  }

  void _showConfirmationModal(BuildContext context, WidgetRef ref) {
    CtErrorModal.show(
      context: context,
      title: strings.modalTitle,
      message: strings.modalMessage,
      icon: Icons.warning_amber_rounded,
      primaryButtonLabel: strings.modalConfirmLabel,
      onPrimaryPressed: () {
        ref.read(deleteAccountProvider.notifier).deleteAccount();
      },
      secondaryButtonLabel: strings.modalCancelLabel,
      onSecondaryPressed: () {},
    );
  }
}
