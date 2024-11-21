//拦截器，在返回数据时，对数据进行预处理，并返回给viewmodel，此时数据已经过预处理，但未返回，此时数据未过预处理
import 'package:dio/dio.dart';
import 'package:oktoast/oktoast.dart';
import 'BaseModel.dart';

class ResponseInterceptor extends Interceptor {

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    if (response.statusCode == 200) {
      try {
        var rsp =BaseModel.fromJson(response.data);
        //errorCode == 0  请求执行成功
        //errorCode == -1001 请求登录状态失效
        if (rsp.errorCode == 0){
          if (rsp.data == null) {
            handler.next(Response(
                requestOptions: response.requestOptions, data: true));
          }
          else {
            handler.next(Response(
                requestOptions: response.requestOptions, data: rsp.data));  // 若返回数据不为空，则返回数据，此时数据已经过预处理
                                                                            //errCode 和 errMsg被剥离
          }
        }else if(rsp.errorCode == -1001){
          showToast("${rsp.errorMsg}");
         handler.next(Response(
              requestOptions: response.requestOptions, data: "未登录"));
        }else if(rsp.errorCode == -1){   //注册报错
          showToast('${rsp.errorMsg}');
          handler.next(Response(
              requestOptions: response.requestOptions, data: false));  // 拦截器重写数据表：若返回数据为空，则返回false，此时数据未过预处理
        }
      } catch (e) {
        handler.reject(DioException(requestOptions: response.requestOptions, message: "$e"));
      }
    }
  }
}