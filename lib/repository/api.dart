//api请求统一解析
import 'package:dio/dio.dart';
import 'package:exp1_10_29/repository/datas/home_banner_data.dart';
import '../http/dio_instance.dart';
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

  Future<List<HomeItemsData>?> getTopList() async {
    Response response = await DioInstance.instance().get(
        path: "article/top/json"); //异步中等待返回数据，才执行下面的
    HomeTopListData homeTopListData = HomeTopListData.fromJson(response.data);
    return homeTopListData.topList;
  }
}