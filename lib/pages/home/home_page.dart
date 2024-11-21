
import 'package:exp1_10_29/commonUi/Loading_ui.dart';
import 'package:exp1_10_29/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../repository/datas/home_Lists_data.dart';
import '../../repository/datas/home_banner_data.dart';
import '../../route/routes.dart';
import 'home_vm.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  HomeViewModel vm = HomeViewModel();  //初始化vm，即实例化的数据模型
  RefreshController refreshController = RefreshController();  //下拉刷新控制器
  List<HomeBannerData?>? bannerList;
  List<HomeItemsData?>? listData;  //type = ["datas"]
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    // 在第一帧绘制后显示 loading
      LoadingUi.showLoading();
    });
    vm.getBanner();   //数据模型获取banner数据
    // vm.getHomeListData();   //数据模型获取首页列表数据
    vm.initListData(false);

  }

  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget build(BuildContext context){
    return ChangeNotifierProvider<HomeViewModel>(create: (context){  //设置变化监听对象vm
      return vm;
    },
    child: Scaffold( // scaffold组件
        backgroundColor: theme_color.theme_color_Lightest,
        body: SafeArea(  //避免被顶部导航栏遮挡
          child:SmartRefresher(    //页面拉动刷新
            controller: refreshController,
            enablePullUp: true,
            enablePullDown: true,
            header: MaterialClassicHeader(),
            footer: ClassicFooter(),
            onLoading: () {
              vm.initListData(true).then((value){
                refreshController.loadComplete();
              });
            },
            onRefresh: () {
              vm.getBanner().then((value){
                vm.initListData(false).then((value){
                  refreshController.refreshCompleted();
                });
              });   //数据模型获取banner数据
            },
            child:SingleChildScrollView(
              child: Column(
                children: [
                  //使用safe_area，防止顶部导航栏被遮挡
                  _banner(),
                  _ListView(),
                ],
              )
            )
        ))
    ));
  }

  Widget _banner(){
    return Consumer<HomeViewModel>(builder: (context,vm,child) {   //provider刷新组件，监听vm有变化刷新Comsumer
      return Container(height: 200.h, child:
      Swiper(itemCount: vm.bannerList?.length ?? 0,
        autoplay: true,
        autoplayDelay: 5000,
        itemBuilder: (context, index) { //滚动banner组件
        return Container(

          decoration: BoxDecoration(
            color: theme_color.theme_color_Lightest,
          ),
          height: 150.h,
          width: double.infinity,
          //撑满屏幕
          margin: EdgeInsets.all(15.r),

          //外边距
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: theme_color.theme_color_Lightest,
              border: Border.all(color: theme_color.theme_color_Dark, width: 1.r)
            ),
            child: ClipRRect(
            borderRadius: BorderRadius.circular(15.r), //圆角Clipt
            child: Image.network(vm.bannerList?[index]?.imagePath ?? "",
                fit:BoxFit.fill), //资源需要在pubspec.yaml声明
          ),
          ),
        );
      },),
      );
    }); //顶部导航栏，
  }  // 顶部Banner，

  Widget _ListView(){
    return Consumer<HomeViewModel>(builder: (context,vm,child){
      return ListView.builder( //下方内容
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _ListItem(index: index);
        },
        itemCount: vm.listData?.length ?? 0,);
    });

  }

  Widget _ListItem({required int index}) {
    return Consumer<HomeViewModel>(builder: (context,vm,child){
      return Container( //外部包裹Container
              height: 120.h,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 5.r, horizontal: 15.r),
              decoration: BoxDecoration(
                color: theme_color.theme_color_Lighter,
                borderRadius: BorderRadius.circular(15.r), //卡片圆角
                border: Border.all(
                    color: (vm.listData?[index].type?.toInt() == 0) ?  theme_color.theme_color_Aveage : theme_color.theme_color_Darkest,
                    width: 1.r),
              ),
              child: Column( //内部元素行排列
                  children: [
                    Container( //card头部Container
                        padding: EdgeInsets.all(10.r),
                        width: double.infinity,
                        height: 60.sp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r), //标题圆角
                          color: theme_color.theme_color_Lightest,
                        ),
                        margin: EdgeInsets.symmetric(
                            vertical: 10.r, horizontal: 10.r),

                        child: Row(
                          children: [
                            CircleAvatar( //头像
                              radius: 20.r,
                              foregroundImage: AssetImage(
                                "assets/images/av2.jpg",),
                              backgroundColor: HexColor("#fffffff"),

                            ),
                            Column( //标题
                              crossAxisAlignment: CrossAxisAlignment.start, //文本靠左
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 200.w,
                                  margin: EdgeInsets.symmetric(horizontal: 5.r),
                                  child: Column(
                                    children: [
                                      Text(
                                        vm.listData?[index].title ?? "",
                                        style: TextStyle(fontSize: 12.sp,color: theme_color.theme_color_Darkest,),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        " ",
                                        style: TextStyle(fontSize: 5.sp,
                                            color: theme_color.theme_color_Darkest,
                                        ),),
                                    ],
                                  ),
                                )

                              ],),
                            Expanded( //点赞图标
                              child: GestureDetector(
                                onTap: () {
                                  bool is_collected = vm.listData?[index].collect ?? false;
                                  vm.setCollect("${vm.listData?[index].id}", index, !is_collected).then((value){
                                    if(value == true){
                                      showToast(is_collected ? "取消收藏成功" : "收藏成功");
                                    }else{
                                      print("未登录");
                                      Navigator.pushNamed(context, RouteName.login);
                                    }
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.r),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [

                                      Icon(
                                        vm.listData?[index].collect == true ? Icons.star : Icons.star_border,   //Icons.star
                                        color:  vm.listData?[index].collect == true ? theme_color.theme_color_Aveage:theme_color.theme_color_Aveage,
                                        size: 25.sp,
                                      ),
                                    ],))),)],
                        )),
                    InkWell(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context){   //跳转页面,构造页面为组件
                        //   return WebViewPage(title: "首页跳转",);
                        // }));
                        Navigator.pushNamed(context, RouteName.webViewPage,arguments: {
                          "title":vm.listData?[index].title ?? "",
                          "message":"Card index: ${index}",
                          "target_url": vm.listData?[index].link ?? ""});  //路由跳转,传入参数
                      },
                      child: Container( //card正文Container
                        decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                        margin: EdgeInsets.only(top: 10.r,left: 10.r,right: 10.r,bottom: 10.r),
                        width: double.infinity,
                        height: 20.sp,
                        child: Row( //行布局
                          crossAxisAlignment: CrossAxisAlignment.start, //靠左
                          children: [
                            // Container(   //左侧图片
                            //
                            //   width: 200.w,
                            //   height: 105.sp,
                            //   child:
                            //     ClipRRect( //圆角图片承载
                            //       borderRadius: BorderRadius.circular(15.r),
                            //       child: Image.asset("assets/images/banner1.jpg",
                            //         fit: BoxFit.cover,)
                            //       // child: Image.asset("assets/images/av2.jpg",
                            //       //   fit: BoxFit.cover,),
                            //     )),
                            Expanded(child: Container( //右边功能按钮
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.r),
                                color: HexColor("#dbdeff0"),
                              ),
                              height: 40.sp,
                              margin: EdgeInsets.symmetric(
                                  vertical: 0.r, horizontal: 5.r),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 5.r),
                                    alignment: Alignment.centerLeft,
                                    height: 20.sp,
                                    constraints: BoxConstraints(
                                      maxWidth: 60.w,  // 最大宽度
                                      minWidth: 0,     // 最小宽度设为0，允许自适应
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7.r),
                                      color: HexColor("#fcf5ff"),
                                    ),
                                    child:
                                      Text("${vm.listData?[index].chapterName}",
                                        style: TextStyle(fontSize: 8.sp,color: theme_color.theme_color_Aveage),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,),
                                  ),
                                  Icon(
                                    Icons.more_vert,
                                    color: HexColor("#a39fa5"),
                                  )],),))],)
                    ))
                  ])
          ); //外部包裹Container

    });

    //下方详细列表单元

  }  //内容卡片
}



