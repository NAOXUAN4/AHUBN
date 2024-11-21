//api请求统一解析
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:exp1_10_29/repository/datas/login_data.dart';
import 'package:exp1_10_29/repository/datas/search_data.dart';
import '../http/dio_instance.dart';
import 'datas/common_website_data.dart';
import 'datas/home_Lists_data.dart';
import 'datas/home_banner_data.dart';
import 'datas/hot_key_data.dart';

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

  Future<dynamic>register(String? username,String? password,String? repassword)async{
    Response response = await DioInstance.instance().post(   //发送Post传参请求
        path: "user/register",
        data: {"username":username,"password":password,"repassword":repassword});
    // print(response.data);
    try{ //若报错肯定进入过拦截器的错误处理
      response.data["errorCode"] == 0; //没被修改过，还存在"errcode"
      return true;
    }
    catch(e){
      return false;
    }//拦截器会返回true或false
  }

  Future<dynamic>login(String? username,String? password)async{  //登录
    Response response = await DioInstance.instance().post(   //发送Post传参请求
        path: "user/login",
        data: {"username":username,"password":password,});
    // print(response.data);
    try{ //若报错肯定进入过拦截器的错误处理
      response.data["errorCode"] == 0; //没被修改过，还存在"errcode
      return LoginData.fromJson(response.data);
    }
    catch(e){
      return false;
    }//拦截器会返回true或false
  }

   Future<dynamic>logout()async{  //登录
    Response response = await DioInstance.instance().get(   //发送Post传参请求
        path: "user/logout/json",);
    // print(response.data);
    if(response.data == true){
      return response.data;
    }else{
      return false;
    }
  }

  //收藏
  Future<bool?> collect(String? id,bool isCollect) async{
    String pathCollect = isCollect? "collect": "uncollect_originId";
    Response response = await DioInstance.instance().post(
        path: "lg/$pathCollect/$id/json");
    if(response.data == true){
      return response.data;
    }else{
      return false;
    }
  }

  Future<List<SearchItemsData>?> searchList(String pageCount,String keyword) async{
    Response response = await DioInstance.instance().post(
        path: "article/query/$pageCount/json",
        data: {"k":keyword});
    var searchData = SearchData.fromJson(response.data);
    return searchData.datas;
  }

}