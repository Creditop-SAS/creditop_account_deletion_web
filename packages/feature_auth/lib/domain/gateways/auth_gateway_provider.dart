import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_gateway.dart';

/// Placeholder provider para AuthGateway.
/// Se debe override en main.dart con la implementación real.
final authGatewayProvider = Provider<AuthGateway>(
  (ref) => throw UnimplementedError('Override authGatewayProvider in main.dart'),
);
