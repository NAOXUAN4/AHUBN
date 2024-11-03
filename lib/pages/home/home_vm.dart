import 'package:dio/dio.dart';
import 'package:exp1_10_29/datas/home_Lists_data.dart';
import 'package:exp1_10_29/datas/home_banner_data.dart';
import 'package:exp1_10_29/http/dio_instance.dart';
import 'package:flutter/foundation.dart';


class HomeViewModel with ChangeNotifier{

  List<BannerData>? bannerList;
  List<HomeItemsData>? listData;

  // 获取轮播图数据
  Future getBanner() async {
    // TODO: implement getBanner
    Response response  = await DioInstance.instance().get(path: "banner/json");
    HomeBannerData bannerdata = HomeBannerData.fromJson(response.data);
    if(bannerdata.data!=null){
      bannerList =  bannerdata.data;
      print("Get succ");
    }else {
      bannerList = [];
      print("banner Null");
    }
    notifyListeners();
  }

  // 获取首页列表数据
  Future getHomeListData() async {
    Response response  = await DioInstance.instance().get(path: "article/list/1/json");  //异步中等待返回数据，才执行下面的
    HomeData homeData = HomeData.fromJson(response.data);
    if(homeData.data!=null){
      listData =  homeData.data?.datas;   //type:List<HomeItemData>
      print("HomeList Get succ");
    }else {
      listData = [];
      print("Home List Null");
    }
    notifyListeners();

  }
}