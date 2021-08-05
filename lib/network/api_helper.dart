import 'package:dio/dio.dart';

import 'network_config.dart';

class ApiHelper {
  static final String baseUrl = NetworkConfig.getNetworkUrl();
  static BaseOptions opts = BaseOptions(
    baseUrl: baseUrl,
    responseType: ResponseType.json,
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );

  static Dio createDio() {
    return Dio(opts);
  }

  static Dio addInterceptors(Dio dio) {
    return dio
      ..interceptors.add(
        InterceptorsWrapper(
            onRequest: (RequestOptions options,RequestInterceptorHandler handler) => requestInterceptor(options,handler),
            onError: (DioError e,ErrorInterceptorHandler handler) async {
              return e.response!.data;
            }),
      );
  }


  static dynamic requestInterceptor(RequestOptions options,RequestInterceptorHandler handler) async {
    // Get your JWT token
    const token = '';
    options.headers.addAll({"Authorization": "Bearer: $token"});
    return options;
  }

  static final dio = createDio();
  static final baseAPI = addInterceptors(dio);

  Future<Response> get(String url) async {
    try {
      Response response = await baseAPI.get(url);
      return response;
    } on DioError catch(e) {
      // Handle error
      throw e;
    }
  }

  Future<dynamic> post(String url, data) async {
    try {
      String methodUrl = baseUrl+url;
      Response response = await dio.post(methodUrl, data: data);
      return response.data;
    } on DioError catch(e) {
      // Handle error
      throw e;
    }
  }

  Future<Response> put(String url, dynamic data) async {
    try {
      Response response = await baseAPI.put(url, data: data);
      return response;
    } on DioError catch(e) {
      // Handle error
      throw e;
    }
  }

  Future<Response> delete(String url) async {
    try {
      Response response = await baseAPI.delete(url);
      return response;
    } on DioError catch(e) {
      // Handle error
      throw e;
    }
  }
}

