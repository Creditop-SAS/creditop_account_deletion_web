import 'package:cds_web/cds_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:feature_auth/presentation/models/phone_input_strings.dart';
import 'package:feature_auth/presentation/providers/phone_input_provider.dart';

/// Página de input de teléfono para verificación de identidad.
class PhoneInputPage extends ConsumerStatefulWidget {
  const PhoneInputPage({
    required this.strings,
    required this.onOtpRequested,
    super.key,
  });

  final PhoneInputStrings strings;
  final ValueChanged<String> onOtpRequested;

  @override
  ConsumerState<PhoneInputPage> createState() => _PhoneInputPageState();
}

class _PhoneInputPageState extends ConsumerState<PhoneInputPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(phoneInputProvider);

    return CtWebScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.strings.title,
            style: CdsTypography.heading.xxsmall.copyWith(
              color: CdsColors.neutral.shade900,
            ),
          ),
          const SizedBox(height: CdsSpacing.sm),
          Text(
            widget.strings.subtitle,
            style: CdsTypography.textRegular.normal.copyWith(
              color: CdsColors.neutral.shade600,
            ),
          ),
          const SizedBox(height: CdsSpacing.xl),
          CtTextField(
            controller: _controller,
            label: widget.strings.phoneLabel,
            hint: widget.strings.phoneHint,
            prefix: widget.strings.phonePrefix,
            autofocus: true,
            errorText: state.phoneError != null
                ? widget.strings.invalidPhoneError
                : null,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) {
              ref
                  .read(phoneInputProvider.notifier)
                  .updatePhone(value);
            },
          ),
          const SizedBox(height: CdsSpacing.xl),
          CtButton(
            label: widget.strings.buttonLabel,
            isLoading: state.isLoading,
            onPressed: state.isValid && !state.isLoading
                ? () async {
                    final success = await ref
                        .read(phoneInputProvider.notifier)
                        .requestOtp();
                    if (success && mounted) {
                      widget.onOtpRequested(state.phone);
                    }
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
