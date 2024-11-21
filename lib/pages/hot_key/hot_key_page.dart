
import 'package:exp1_10_29/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../route/routes.dart';
import 'hotkey_page_vm.dart';

class HotKeyPage extends StatefulWidget {
  const HotKeyPage({super.key});
  @override createState() => _HotKeyPageState();
}

class _HotKeyPageState extends State<HotKeyPage> {
  HotKeyViewModel vm = HotKeyViewModel(); //初始化vm，即实例化的数据模型

  @override
  void initState() {
    super.initState();
    vm.initHotKeyPageData();
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HotKeyViewModel>(create: (context){  //设置变化监听对象vm
      return vm;
    },
    child: Scaffold(
        backgroundColor: theme_color.theme_color_Lightest,
        body: SafeArea(child: SingleChildScrollView(child:  Column(
          children: [
            _hotKeyBar(),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(5.r),
              margin: EdgeInsets.only(left: 4.w,right: 4.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                color: theme_color.theme_color_Lighter,
                border: Border.all(color: theme_color.theme_color_Aveage, width: 1)
              ),
              child: _gridItems(0),
            ),//热词GridView1
            SizedBox(height: 10),
            _commonWebbar(),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(5.r),
              margin: EdgeInsets.only(left: 4.w,right: 4.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                color: theme_color.theme_color_Lighter, //
                border: Border.all(color: theme_color.theme_color_Aveage, width: 1)
              ),
              child: _gridItems(1),
            )//常用网站GridView2
          ],
        )),)
    ));
  }

  Widget _hotKeyBar(){
    return
      Container(   //第一排SizeBox
        margin: EdgeInsets.only(left: 4.w,right: 4.w),
        decoration: BoxDecoration(
            color: theme_color.theme_color_Lighter,
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            // border: Border.all(color: Colors.black12),
            border:Border.all(color: theme_color.theme_color_Aveage, width: 1)
        ),
        width: double.infinity,
        height: 50.h,
        child: Row(children: [
          Container(   //热词标题
            width: 300,
            margin: EdgeInsets.only(left: 20),
            child: Text("搜索热词",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: theme_color.theme_color_Aveage),),
          ),
          Expanded(   //搜索图标
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, RouteName.search,arguments: {
                      "search_text":"",
                  });
              },
              child: Icon(
                Icons.search_rounded,
                color: theme_color.theme_color_Dark,
                size: 30
            )
            ),
          ),
        ],//标题，搜索图标

        ),);
  }
  Widget _commonWebbar(){
    return Container(   //第一排SizeBox
        margin: EdgeInsets.only(left: 4.w,right: 4.w),
        decoration: BoxDecoration(
            color: theme_color.theme_color_Lighter,
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            // border: Border.all(color: Colors.black12),
            border:Border.all(color: theme_color.theme_color_Aveage, width: 1)
        ),
        width: double.infinity,
        height: 50.h,
        child: Row(children: [
          Container(   //热词标题
            width: 300,
            margin: EdgeInsets.only(left: 20),
            child: Text("常用网站",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: theme_color.theme_color_Aveage),),
          ),
        ],//标题，搜索图标

        ),);

  }

  Widget _gridItems(int ItemState) {  // 0:热词，1:常用网站
    late List dataList = (ItemState == 0 ? vm.hotkeyList : vm.websiteList) ?? [];
    return Consumer<HotKeyViewModel>(builder: (context, vm, child) {
      return GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 5,
              childAspectRatio: 2.5),
          itemCount: dataList.length ?? 0,
          itemBuilder: (context, index) {
            return GestureDetector (onTap: (){
            },
                child:GestureDetector(
                  onTap: ItemState == 0 ?
                      () {
                        Navigator.pushNamed(context, RouteName.search,arguments: {
                          "search_text":dataList[index].name ?? ""});}
                      :
                      (){
                        if(dataList[index].link != null){  //
                        //WebsiteState
                        Navigator.pushNamed(context, RouteName.webViewPage,arguments: {
                          "title":dataList[index].name ?? "",
                          "message":"Card index: ${index}",
                          "target_url": dataList[index].link ?? ""});}},
                  child:Container(  ///Item标签
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [theme_color.theme_color_Lightest, theme_color.theme_color_Lightest],
                      stops: [0.0, 1.0],),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border:Border.all(color: theme_color.theme_color_Aveage, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 90.w,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(2),
                        child: Text(" ${dataList[index].name ?? "" }",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(fontWeight: FontWeight.w500,color:theme_color.theme_color_Darker,fontSize: 15,fontFamily: "PingFangSC"),),
                      )
                    ]
                  ),
                ),
                ));
          }
      );
    });
  }
  //
  // Widget _gridViewItems(String? name,int? indexCount,ValueChanged<String>? itemTap){
  //   return
  // }

}
