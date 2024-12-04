import 'package:dio/dio.dart';

abstract class Failure {
  final String message;
  final int? statusCode;

  Failure({required this.message, required this.statusCode});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, required super.statusCode});

  factory ServerFailure.fromDioError(DioException dioError) {
    final statusCode = dioError.response?.statusCode;

    if (dioError.type == DioExceptionType.badResponse) {
      final responseMessage = dioError.response?.data['status_message'];
      switch (statusCode) {
        case 400:
          return ServerFailure(
            message: responseMessage ?? 'Bad Request - Yêu cầu không hợp lệ',
            statusCode: statusCode,
          );
        case 401:
          return ServerFailure(
            message: responseMessage ?? 'Unauthorized - API key không hợp lệ',
            statusCode: statusCode,
          );
        case 404:
          return ServerFailure(
            message: responseMessage ?? 'Not Found - Không tìm thấy tài nguyên',
            statusCode: statusCode,
          );
        case 500:
          return ServerFailure(
            message: responseMessage ?? 'Internal Server Error - Lỗi máy chủ',
            statusCode: statusCode,
          );
        default:
          return ServerFailure(
            message: responseMessage ?? 'Lỗi HTTP $statusCode',
            statusCode: statusCode,
          );
      }
    }

    String message;
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Kết nối tới server quá thời gian cho phép';
      case DioExceptionType.sendTimeout:
        message = 'Gửi yêu cầu lên server quá thời gian';
      case DioExceptionType.receiveTimeout:
        message = 'Nhận phản hồi từ server quá thời gian';
      case DioExceptionType.cancel:
        message = 'Yêu cầu đã bị hủy';
      case DioExceptionType.connectionError:
        message = 'Không có kết nối internet';
      case DioExceptionType.badCertificate:
        message = 'Chứng chỉ bảo mật không hợp lệ';
      case DioExceptionType.unknown:
        message = 'Đã xảy ra lỗi không xác định';
      default:
        message = 'Đã xảy ra lỗi';
    }

    return ServerFailure(
      message: message,
      statusCode: statusCode,
    );
  }
}
