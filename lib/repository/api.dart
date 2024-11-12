//api请求统一解析
import 'package:dio/dio.dart';
import 'package:exp1_10_29/repository/datas/home_banner_data.dart';
import 'package:exp1_10_29/repository/datas/hot_key_data.dart';
import '../http/dio_instance.dart';
import 'datas/common_website_data.dart';
import 'datas/home_Lists_data.dart';

class Api {
  static Api instance = Api._();

  Api._();

  //获取首页轮播图数据
  Future<List<HomeBannerData?>?> getBanner() async {
    // TODO: implement getBanner
    Response response = await DioInstance.instance().get(path: "banner/json");
    HomeBannerListData bannerdata = HomeBannerListData.fromJson(response.data);
    return bannerdata.bannerList;
  }

  //获取首页列表数据
  Future<List<HomeItemsData>?> getHomeListData(String? page) async {
    Response response = await DioInstance.instance().get(
        path: "article/list/$page/json"); //异步中等待返回数据，才执行下面的
    HomeListsData homeData = HomeListsData.fromJson(response.data);
    return homeData.datas;
  }

  Future<List<HomeItemsData>?> getTopList() async {     ///发送，接收，解析 置顶列表
    Response response = await DioInstance.instance().get(
        path: "article/top/json"); //异步中等待返回数据，才执行下面的
    HomeTopListData homeTopListData = HomeTopListData.fromJson(response.data);
    return homeTopListData.topList;
  }

  Future<List<CommonWebsiteData>?> getWebListData()async {   ///发送，接收，解析 常用网页列表
    Response response = await DioInstance.instance().get(
        path: "friend/json");  //发送请求，await直到获得回复
    CommonWebsiteListData commonwebsite = CommonWebsiteListData.fromJson(response.data);   //调用数据模型构造函数，解析数据
    return commonwebsite.websiteList;
  }

  Future<List<HotKeyData>?>getHotKeyData()async{
    Response response = await DioInstance.instance().get(
        path: "hotkey/json");
    HotKeyListData hotkey = HotKeyListData.fromJson(response.data);
    return hotkey.hotkeyList;
  }


}