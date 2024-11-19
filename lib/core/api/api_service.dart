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

  // Future<Response> get(
  //   String path,{

  //   Map<String, dynamic>? queryParameters,
  // }) async {
  //   return await _fetchData(path,
  //       method: HttpMethod.get, queryParameters: queryParameters);
  // }

  // Future<Response> post(
  //   String path, {
  //   Map<String, dynamic>? data,
  // }) async {
  //   return await _fetchData(path, method: HttpMethod.post, data: data);
  // }
  Future<Response> fetchData(
    String path, {
    HttpMethod method = HttpMethod.get,

    // sửa method thành get
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) async {
    return await _dio.request(path,
        queryParameters: queryParameters,
        options: Options(method: method.value));
  }
}

enum HttpMethod {
  get('get'),
  post('post');

  final String value;
  const HttpMethod(this.value);
}
// edit api key
//enum api key
