import 'package:app_movies/core/api/api_interceptor.dart';
import 'package:app_movies/core/enums/enum.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static final ApiService _apiService =
      ApiService(dotenv.env['BASE_URL'] ?? 'default_base_url');
  static ApiService get instance => _apiService;

  final Dio _dio;

  ApiService(String baseUrl) : _dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    // Thêm Interceptor vào Dio
    _dio.interceptors.add(ApiInterceptor());
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


// edit api key
//enum api key
