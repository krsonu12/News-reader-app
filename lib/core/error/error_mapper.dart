import 'package:dio/dio.dart';
import 'package:news_reader_app/core/error/failures.dart';

AppFailure mapDioExceptionToFailure(DioException exception) {
  final statusCode = exception.response?.statusCode;

  if (statusCode == 401) {
    return const AppFailure('Unauthorized request. Check API key.', code: 401);
  }

  if (statusCode == 429) {
    return const AppFailure(
      'Rate limit reached. Please try again later.',
      code: 429,
    );
  }

  if (statusCode != null && statusCode >= 500) {
    return AppFailure('Server error occurred.', code: statusCode);
  }

  switch (exception.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const AppFailure('Request timed out. Please retry.');
    case DioExceptionType.connectionError:
      return const AppFailure('No internet connection.');
    case DioExceptionType.badResponse:
      return AppFailure(
        exception.response?.data?['message']?.toString() ??
            'Unexpected server response.',
        code: statusCode,
      );
    case DioExceptionType.cancel:
      return const AppFailure('Request cancelled.');
    case DioExceptionType.badCertificate:
    case DioExceptionType.unknown:
      return const AppFailure('Unexpected network error occurred.');
  }
}
