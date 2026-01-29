import 'package:dio/dio.dart';

/// Cliente HTTP basado en Dio con configuración base.
class DioClient {
  /// Crea una instancia de Dio con configuración base.
  static Dio create({
    required String baseUrl,
    Duration connectTimeout = const Duration(seconds: 30),
    Duration receiveTimeout = const Duration(seconds: 30),
    Map<String, dynamic>? headers,
    List<Interceptor>? interceptors,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          ...?headers,
        },
      ),
    );

    if (interceptors != null) {
      dio.interceptors.addAll(interceptors);
    }

    return dio;
  }
}

/// Interceptor para agregar el token de autenticación a cada request.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.getToken});

  final Future<String?> Function() getToken;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
