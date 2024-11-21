import 'package:dio/dio.dart';
import 'package:exp1_10_29/constants.dart';
import 'package:exp1_10_29/repository/api.dart';
import 'package:exp1_10_29/utils/sp_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:oktoast/oktoast.dart';

import '../../repository/datas/login_data.dart';

class AuthViewModel with ChangeNotifier{
  RegisterInfo registerInfo = RegisterInfo();  //实例化信息类
  LoginInfo loginInfo = LoginInfo();

  Future<dynamic> register() async{  //Post注册请求
    if(!(registerInfo.username == null || registerInfo.password == null || registerInfo.repassword == null)
        && registerInfo.password == registerInfo.repassword){
      return await Api.instance.register(registerInfo.username, registerInfo.password, registerInfo.repassword);
    }
    else if(registerInfo.username == null){showToast("账号为空");}
    else if(registerInfo.password == null){showToast("密码为空");}
    else if(registerInfo.repassword == null){showToast("确认密码为空");}
    else{showToast("两次密码不一致");}
    return false;
  }

  Future<dynamic> login() async{  //Post注册请求
    if((loginInfo.username == null || loginInfo.password == null)) {
      showToast("账号或密码为空");
      return false;
    }
    else {
      var response = await Api.instance.login(loginInfo.username, loginInfo.password);
      if(response!=false){
        LoginData loginData = response;
        SpUtils.saveString(Constants.SP_UserName, loginData.username?? "");  //本地存储用户数据
        SpUtils.saveString(Constants.SP_Password, loginData.password?? "");
        SpUtils.saveString(Constants.SP_User_Nickname, loginData.nickname?? "");
        return true;
      }

      return false;

    }
  }

}
class RegisterInfo{
  String? username;
  String? password;
  String? repassword;
}

class LoginInfo{
  String? username;
  String? password;
}