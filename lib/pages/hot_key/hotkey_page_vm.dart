import 'package:flutter/cupertino.dart';
import '../../repository/api.dart';
import '../../repository/datas/common_website_data.dart';
import '../../repository/datas/hot_key_data.dart';

class HotKeyViewModel with ChangeNotifier{

  List<HotKeyData>? hotkeyList;
  List<CommonWebsiteData>? websiteList;

  Future initHotKeyPageData() async{
    getHotKeyData ().then((value){
      getWebListData().then((value){
        notifyListeners();
      });
    });
  }

  Future getHotKeyData() async {
    hotkeyList = await Api.instance.getHotKeyData();

  }
  Future getWebListData() async {
    websiteList = await Api.instance.getWebListData();
  }



 }