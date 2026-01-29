import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

/// Estado de la eliminación de cuenta.
@immutable
final class DeleteAccountState {
  const DeleteAccountState({
    this.isLoading = false,
    this.isDeleted = false,
    this.error,
  });

  final bool isLoading;
  final bool isDeleted;
  final ErrorItem? error;

  DeleteAccountState copyWith({
    bool? isLoading,
    bool? isDeleted,
    ErrorItem? error,
    bool clearError = false,
  }) {
    return DeleteAccountState(
      isLoading: isLoading ?? this.isLoading,
      isDeleted: isDeleted ?? this.isDeleted,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DeleteAccountState &&
        other.isLoading == isLoading &&
        other.isDeleted == isDeleted &&
        other.error == error;
  }

  @override
  int get hashCode => Object.hash(isLoading, isDeleted, error);
}
