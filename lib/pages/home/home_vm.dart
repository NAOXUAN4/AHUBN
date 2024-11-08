import 'package:dio/dio.dart';
import 'package:exp1_10_29/repository/api.dart';
import 'package:exp1_10_29/repository/datas/home_Lists_data.dart';
import 'package:exp1_10_29/http/dio_instance.dart';
import 'package:flutter/foundation.dart';

import '../../repository/datas/home_Lists_data.dart';
import '../../repository/datas/home_banner_data.dart';


class HomeViewModel with ChangeNotifier{

  List<HomeBannerData?>? bannerList;

  int ListPageCountNow = 0;  //default:1
  List<HomeItemsData>? listData = [];


  // 获取轮播图数据
  Future getBanner() async {
    // TODO: implement getBanner
    List<HomeBannerData?>? bannerdata = await Api.instance.getBanner();   //type:List<HomeBannerData>  封装的Api请求
    if(bannerdata!=null){
      bannerList =  bannerdata;
    }else {
      bannerList = [];
    }
    notifyListeners();
  }

  Future initListData(bool LoadMore)async{
    if(!LoadMore){
      listData?.clear();
      ListPageCountNow = 0;
      await getTopList();
      await getHomeListData(LoadMore);  //LoadMore = true
    }else {
      ListPageCountNow++;
      await getHomeListData(LoadMore);
    }

  }
  // 获取首页列表数据
  Future getHomeListData(bool LoadMore) async {
    List<HomeItemsData>? homeData = await Api.instance.getHomeListData("$ListPageCountNow");
    listData?.addAll(homeData ?? []);
    notifyListeners();

  }
  Future getTopList() async {
    List<HomeItemsData>? topList = await Api.instance.getTopList();
    listData?.addAll(topList ?? []);
  }

}