import 'package:exp1_10_29/constants.dart';
import 'package:exp1_10_29/utils/sp_utils.dart';

class User_info{

  String? getUserInfo(String key){
    SpUtils.getString(key).then((value){
      return value;
    });
    return null;
  }

  void setUserInfo(String key, String value){
    SpUtils.saveString(key, value);
  }

}

class User_info_data{
  String? icon;
  String nickname = Constants.SP_User_Nickname;
  String username = Constants.SP_UserName;
  String password = Constants.SP_Password;
}