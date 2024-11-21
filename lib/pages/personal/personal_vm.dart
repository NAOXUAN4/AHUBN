import 'package:exp1_10_29/repository/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import '../../constants.dart';
import '../../utils/sp_utils.dart';
import '../tab_page.dart';

class PersonalViewModel with ChangeNotifier{

  String? nickname;

  Future getUserNickname() async{
    nickname = await SpUtils.getString(Constants.SP_User_Nickname);

    if(nickname == null){
      nickname = "未登录";
    }
    print("nickname = $nickname");
    notifyListeners();
  }

  Future logout() async{
    bool? logoutSucc = await Api.instance.logout();
    print("logout = $logoutSucc");
    if(logoutSucc == true){
      await SpUtils.removeAll();  //等待清理本地数据
      showToast("已退出登录");
    }
    notifyListeners();

  }

}