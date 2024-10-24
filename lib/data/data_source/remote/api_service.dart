import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Để lấy API_KEY từ file .env

class ApiService {
  static final ApiService _apiService =
      ApiService(dotenv.env['BASE_URL'] ?? 'default_base_url');
  static ApiService get instance => _apiService;

  final Dio _dio;

  ApiService(String baseUrl) : _dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    // Thêm Interceptor vào Dio
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters.addAll({
            'api_key':
                dotenv.env['API_KEY'] ?? 'default_api_key', // Lấy từ file .env
          });

          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          // Xử lý khi có lỗi xảy ra
          print('Error occurred: ${e.response?.statusCode}');

          return handler.next(e); // Tiếp tục xử lý lỗi
        },
      ),
    );
  }
  Dio get dio => _dio;
}


//  static final ApiMoviesService _instance =
//       ApiMoviesService._internal(ApiService.instance);

//   // Getter for the singleton instance
//   static ApiMoviesService get instance => _instance;

//   final ApiService _apiService;

//   // Private constructor
//   ApiMoviesService._internal(this._apiService);