import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../tokens/cds_border_radius.dart';
import '../../tokens/cds_colors.dart';
import '../../tokens/cds_spacing.dart';
import '../../tokens/cds_typography.dart';

/// Input OTP de 4 dígitos del Creditop Design System.
class CtOtpInput extends StatefulWidget {
  const CtOtpInput({
    required this.onCompleted,
    this.hasError = false,
    super.key,
  });

  final ValueChanged<String> onCompleted;
  final bool hasError;

  @override
  State<CtOtpInput> createState() => _CtOtpInputState();
}

class _CtOtpInputState extends State<CtOtpInput> {
  static const int _otpLength = 4;
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_otpLength, (_) => TextEditingController());
    _focusNodes = List.generate(_otpLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.length == 1 && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }

    final otp = _controllers.map((c) => c.text).join();
    if (otp.length == _otpLength) {
      widget.onCompleted(otp);
    }
  }

  void _onKeyDown(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _controllers[index - 1].clear();
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_otpLength, (index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: CdsSpacing.sm),
          child: SizedBox(
            width: 56,
            height: 56,
            child: KeyboardListener(
              focusNode: FocusNode(),
              onKeyEvent: (event) => _onKeyDown(index, event),
              child: TextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                autofocus: index == 0,
                style: CdsTypography.heading.xsmall.copyWith(
                  color: CdsColors.neutral.shade900,
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  counterText: '',
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: CdsBorderRadius.borderRadiusSm,
                    borderSide: BorderSide(
                      color: widget.hasError
                          ? CdsColors.rojo.shade500
                          : CdsColors.neutral.shade300,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: CdsBorderRadius.borderRadiusSm,
                    borderSide: BorderSide(
                      color: widget.hasError
                          ? CdsColors.rojo.shade500
                          : CdsColors.neutral.shade300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: CdsBorderRadius.borderRadiusSm,
                    borderSide: BorderSide(
                      color: widget.hasError
                          ? CdsColors.rojo.shade500
                          : CdsColors.morado.shade500,
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) => _onChanged(index, value),
              ),
            ),
          ),
        );
      }),
    );
  }
}
