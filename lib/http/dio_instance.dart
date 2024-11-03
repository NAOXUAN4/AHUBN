import 'package:dio/dio.dart';
import 'package:exp1_10_29/http/http_methods.dart';

//封装dio实例
class DioInstance{
  static DioInstance ? _instance;
  DioInstance._();

  static DioInstance instance(){
    _instance ??= DioInstance._();
    return _instance!;
  }

  final Dio _dio = Dio();
  final _defualtTime = const Duration(seconds: 30);

  void initDio({
    String? httpMeethod =  HttpMethods.GET,
    required String baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    ResponseType? responseType,
    String? contentType,
  }){
    _dio.options = BaseOptions(
      method: httpMeethod,
      baseUrl: baseUrl,
      connectTimeout: connectTimeout ?? _defualtTime,
      receiveTimeout: receiveTimeout ?? _defualtTime,
      responseType: responseType ?? ResponseType.json,
      contentType: contentType ?? Headers.formUrlEncodedContentType,
    );
  }

  //封装get请求
  Future<Response>get({
    required String path,
    Map<String,dynamic>? param,
    Options? options,
    CancelToken? cancelToken,
  }) async{
    return await _dio.get(path,queryParameters: param,
      options: options ?? Options(
          method: HttpMethods.GET,
          receiveTimeout: _defualtTime,
          sendTimeout: _defualtTime),
      cancelToken: cancelToken,);
    }


  //封装post请求
  Future<Response>post({
    required String path,
    Object? data,
    Map<String,dynamic>? queryParam,
    Options? options,
    CancelToken? cancelToken,
  }) async{
    return await _dio.post(path,queryParameters: queryParam,
      data: data,
      options: options ?? Options(
          method: HttpMethods.POST,
          receiveTimeout: _defualtTime,
          sendTimeout: _defualtTime),
      cancelToken: cancelToken,);
  }




}
