import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../constant/api_end_point.dart';

class DioClient {
  late Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,

        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),

        headers: {'Accept': 'application/json'},
        responseType: ResponseType.json,
      ),
    );

    /// LOGGER
    dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          /// TOKEN
          /// get token from local storage

          String? token = "";

          if (token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },

        onResponse: (response, handler) {
          return handler.next(response);
        },

        onError: (DioException e, handler) {
          print("ERROR => ${e.message}");
          return handler.next(e);
        },
      ),
    );
  }

  /// GET API
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return response;
    } on DioException catch (e) {
      throw Exception(handleError(e));
    }
  }

  /// POST API
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        options: Options(headers: headers),
      );

      return response;
    } on DioException catch (e) {
      throw Exception(handleError(e));
    }
  }

  /// ERROR HANDLING
  String handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection Timeout";

      case DioExceptionType.sendTimeout:
        return "Send Timeout";

      case DioExceptionType.receiveTimeout:
        return "Receive Timeout";

      case DioExceptionType.badResponse:
        return error.response?.data["message"] ?? "Server Error";

      case DioExceptionType.cancel:
        return "Request Cancelled";

      default:
        return "Something Went Wrong";
    }
  }
}
