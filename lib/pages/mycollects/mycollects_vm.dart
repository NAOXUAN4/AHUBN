import 'package:exp1_10_29/repository/api.dart';
import 'package:exp1_10_29/repository/datas/home_Lists_data.dart';
import 'package:flutter/cupertino.dart';

class MyCollectsViewModel with ChangeNotifier{
  List<HomeItemsData> collects = [];
  int _pageCount = 0;

  Future getCollects(bool LoadMore) async{

    if(!LoadMore){
      collects.clear();
      _pageCount = 0;
      collects = await Api.instance.mycollects("$_pageCount");
    }else{
      _pageCount++;
      collects.addAll(await Api.instance.mycollects("$_pageCount"));
    }

    notifyListeners();

  }

}