import 'package:dio/dio.dart';
import 'package:exp1_10_29/datas/home_banner_data.dart';


class HomeViewModel {
  static Future<List<BannerData>?> getBanner() async {
    // TODO: implement getBanner
    Dio dio = Dio();
    dio.options = BaseOptions(
      method: "get",
      baseUrl: "https://www.wanandroid.com/",
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      sendTimeout: Duration(seconds: 30)
    );
    Response response  = await dio.get("banner/json");
    HomeBannerData bannerdata = HomeBannerData.fromJson(response.data);
    if(bannerdata.data!=null){return bannerdata.data;}
    return [];
  }
}