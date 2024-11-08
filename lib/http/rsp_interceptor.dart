import 'package:dio/dio.dart';
import 'package:exp1_10_29/http/BaseModel.dart';
import 'package:oktoast/oktoast.dart';

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
          showToast("登录状态失效，请重新登录");
          handler.reject(DioException(requestOptions: response.requestOptions, message: "未登录"));
        }
      } catch (e) {
        handler.reject(DioException(requestOptions: response.requestOptions, message: "$e"));
      }
    }
  }
}