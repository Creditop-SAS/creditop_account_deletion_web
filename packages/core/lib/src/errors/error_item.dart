import 'package:flutter/foundation.dart';

import 'error_category.dart';

/// Entidad central de errores para toda la aplicación.
@immutable
final class ErrorItem {
  const ErrorItem({
    this.code,
    this.message,
    this.title,
    this.category = ErrorCategory.modal,
    this.primaryButtonLabel,
    this.secondaryButtonLabel,
    this.meta,
  });

  final String? code;
  final String? message;
  final String? title;
  final ErrorCategory category;
  final String? primaryButtonLabel;
  final String? secondaryButtonLabel;
  final Map<String, dynamic>? meta;

  ErrorItem copyWith({
    String? code,
    String? message,
    String? title,
    ErrorCategory? category,
    String? primaryButtonLabel,
    String? secondaryButtonLabel,
    Map<String, dynamic>? meta,
  }) {
    return ErrorItem(
      code: code ?? this.code,
      message: message ?? this.message,
      title: title ?? this.title,
      category: category ?? this.category,
      primaryButtonLabel: primaryButtonLabel ?? this.primaryButtonLabel,
      secondaryButtonLabel: secondaryButtonLabel ?? this.secondaryButtonLabel,
      meta: meta ?? this.meta,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ErrorItem &&
        other.code == code &&
        other.message == message &&
        other.title == title &&
        other.category == category &&
        other.primaryButtonLabel == primaryButtonLabel &&
        other.secondaryButtonLabel == secondaryButtonLabel &&
        mapEquals(other.meta, meta);
  }

  @override
  int get hashCode => Object.hash(
        code,
        message,
        title,
        category,
        primaryButtonLabel,
        secondaryButtonLabel,
        meta,
      );

  @override
  String toString() {
    return 'ErrorItem('
        'code: $code, '
        'title: $title, '
        'message: $message, '
        'category: $category'
        ')';
  }
}
