import 'package:exp1_10_29/commonUi/Loading_ui.dart';
import 'package:exp1_10_29/repository/datas/search_data.dart';
import 'package:flutter/cupertino.dart';

import '../../repository/api.dart';

class SearchViewModel with ChangeNotifier{

  List<SearchItemsData>? searchList;

  Future search(String keyword) async{
    searchList = await Api.instance.searchList("0",keyword);
    LoadingUi.hideLoading();
    notifyListeners();
  }


}