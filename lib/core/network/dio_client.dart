import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flower_blossom/core/api/api_endpoint.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


class DioClient {
  DioClient._();
  static final Dio _dio = _createDio();

  static Dio get dio => _dio;

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: ApiEndpoints.connectionTimeout,
        receiveTimeout: ApiEndpoints.receiveTimeout,
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.addAll([
      RetryInterceptor(dio: dio, retries: 3),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
      ),
    ]);

    return dio;
  }
}