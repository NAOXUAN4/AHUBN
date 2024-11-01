import 'package:exp1_10_29/pages/home/home_vm.dart';
import 'package:exp1_10_29/pages/webView_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../datas/home_banner_data.dart';
import '../../route/routes.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  List<BannerData>? bannerList;

  void initState() {
    super.initState();
    initBannerData();
  }

  void initBannerData() async{   //异步获取banner数据
    bannerList = await HomeViewModel.getBanner();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // scaffold组件
      body: SafeArea(child: SingleChildScrollView(  //避免被顶部导航栏遮挡
        child: Column(children: [ //使用safe_area，防止顶部导航栏被遮挡
          _banner(),
          ListView.builder( //下方内容
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _ListItem(index: index);
            },
            itemCount: bannerList?.length ?? 0,)
        ],)),
      ));
  }

  Widget _banner(){
    return Container(height: 200.h, child: //顶部导航栏，
      Swiper(itemCount: bannerList?.length ?? 0, itemBuilder: (context, index) { //滚动banner组件
        return Container(
          color: Colors.white,
          height: 150.h,
          width: double.infinity,
          //撑满屏幕
          margin: EdgeInsets.all(15.r),

          //外边距
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.r), //圆角Clipt
            child: Image.network(bannerList?[index].imagePath ?? "",
              fit: BoxFit.cover,), //资源需要在pubspec.yaml声明
          ),
        );
      },),
      ); //顶部导航栏，
  }  // 顶部Banner，

  Widget _ListItem({required int index}) {
    //下方详细列表单元
    return InkWell(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context){   //跳转页面,构造页面为组件
          //   return WebViewPage(title: "首页跳转",);
          // }));
          Navigator.pushNamed(context, RouteName.webViewPage,arguments: {
            "title":"从此首页跳转",
            "message":"Card index: ${index}"});  //路由跳转,传入参数
        },
        child:
        Container( //外部包裹Container
            height: 150.h,
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 5.r, horizontal: 15.r),
            decoration: BoxDecoration(
              color: HexColor("#f1e9f2"), //
              borderRadius: BorderRadius.circular(15.r), //卡片圆角
              border: Border.all(color: HexColor("#fcf5ff"), width: 2.r),
            ),
            child: Column( //内部元素行排列
                children: [
                  Container( //card头部Container
                      width: double.infinity,
                      height: 30.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.r), //标题圆角
                        color: HexColor("#f1e9f2"), // 淡紫色
                      ),
                      margin: EdgeInsets.symmetric(
                          vertical: 5.r, horizontal: 10.r),

                      child: Row(
                        children: [
                          CircleAvatar( //头像
                            radius: 15.r,
                            foregroundImage: AssetImage(
                              "assets/images/av2.jpg",),
                            backgroundColor: HexColor("#fffffff"),

                          ),
                          Column( //标题
                            crossAxisAlignment: CrossAxisAlignment.start, //文本靠左
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 5.r),
                                child: Column(
                                  children: [
                                    Text(
                                      bannerList?[index].desc ?? "",
                                      style: TextStyle(fontSize: 10.sp,
                                      ),),
                                    Text(
                                      "副标题副标题副标题副标题副标题副标题副标题副标题副标题副标题",
                                      style: TextStyle(fontSize: 5.sp
                                      ),),
                                  ],
                                ),
                              )

                            ],),
                          Expanded( //点赞图标
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5.r),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [

                                    Icon(
                                      Icons.thumb_up,
                                      color: HexColor("#a39fa5"),
                                      size: 15.sp,
                                    ),
                                  ],
                                )
                            ),
                          )
                        ],
                      )),
                  Container( //card正文Container
                      margin: EdgeInsets.all(5.r),
                      width: double.infinity,
                      height: 105.sp,
                      child: Row( //行布局
                        crossAxisAlignment: CrossAxisAlignment.start, //靠左
                        children: [
                          ClipRRect( //圆角图片承载
                            borderRadius: BorderRadius.circular(15.r),
                            child: Image.network(bannerList?[index].imagePath ?? "",
                              fit: BoxFit.cover,),
                          ),
                          Expanded(child: Container( //右边功能按钮
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.r),
                              color: HexColor("#dbdeff0"),
                            ),
                            height: 110.sp,
                            margin: EdgeInsets.symmetric(
                                vertical: 0.r, horizontal: 5.r),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.more_vert,
                                  color: HexColor("#a39fa5"),
                                )
                              ],
                            ),
                          ))
                        ],)
                  )
                ])
        ) //外部包裹Container
    );
  }  //内容卡片
}



