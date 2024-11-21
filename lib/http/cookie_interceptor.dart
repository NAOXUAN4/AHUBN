import 'dart:io';

import 'package:dio/dio.dart';
import 'package:exp1_10_29/utils/sp_utils.dart';

import '../constants.dart';

class CookieInterceptor extends Interceptor {

  //请求拦截器，对请求头加入cookie
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    SpUtils.getStringList(Constants.SP_Cookie_List).then((cookies){
      options.headers[HttpHeaders.cookieHeader] = cookies;   //重写请求头，加入cookie
      handler.next(options);
    });
  }

  //响应拦截器，对响应头进行解析，获取cookie
  @override
  void onResponse(Response response,ResponseInterceptorHandler handler) async {
    if (response.requestOptions.path.contains("user/login")) {
      dynamic list = response.headers[HttpHeaders.setCookieHeader];  //获取cookie
      List <String> cookieList = [];   //定义存储cookie的list
      if(list is List){
        for(String item in list){
          cookieList.add(item ?? "");
        }
      }
      SpUtils.saveStringList(Constants.SP_Cookie_List, cookieList);
    }

    super.onResponse(response, handler);

  }

}