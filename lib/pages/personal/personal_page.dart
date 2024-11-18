import 'dart:ui';

import 'package:exp1_10_29/route/routes.dart';
import 'package:exp1_10_29/utils/sp_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});
  @override createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {

  String? _nickname = null;

  @override
  void initState() {
    print("1111111111111111111111");
    // TODO: implement initState
    SpUtils.getString(Constants.SP_User_Nickname).then((value) {
      _nickname = value;
      setState(() {
      });
    });
    super.initState();
  }

  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: HexColor("#ffccdfdf"),
          ),
        child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _Header((){
                Navigator.pushNamed(context, RouteName.login);
              }),
              _Body(),
            ],
          )
    );}

  Widget _Header(GestureTapCallback? onTap){
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 30,sigmaY: 30),
      child: Container(
              //头像上半部分
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [HexColor("#64ffffff"), HexColor("#BAffffff")],
                      stops: [0.0, 1.0],),
                borderRadius:BorderRadius.circular(15.r),
                border:   Border.all(color: HexColor("#a39fa5"),width: 1.w),
              ),
              width: double.infinity,
              height: 220.h,
              child: GestureDetector(
                onTap: onTap,
                child: Container(   //头像名称承载容器
                  height: 50.h,
                  width: 10.w,
                  margin: EdgeInsets.only(top: 65.h,bottom: 50.h,left: 50.w,right: 50.w),
                  decoration: BoxDecoration(
                      color: HexColor("#fffffff",)),
                  child:Column(children: [
                    CircleAvatar(
                      radius: 35.r,
                      foregroundImage: AssetImage("assets/images/av2.jpg"),
                      backgroundColor: HexColor("fffffff"),
                    ),
                    SizedBox(height: 10.h),
                    Text(_nickname ?? "未登录",
                      style: TextStyle(fontSize: 15.sp,
                          color: HexColor("#6c7878")),)
              ],),),
              )
            ),
    );
  }

  Widget _Body(){//下方选项区域
    return Container(decoration: BoxDecoration(color: HexColor("#ffccdfdf")), //选项下半部分
                width: double.infinity,
                height: 350.h,
                child: Column(children:[
                  _SettingList(),
                ])
              );
  }

  Widget _SettingList(){
    var titles = ["我的收藏","检查更新","关于我的","退出登录"];
    return ListView.builder( //下方内容
        shrinkWrap: true,  //使滚动视图仅占用其子代实际所需的垂直空间
        physics: const NeverScrollableScrollPhysics(),   //禁止滚动
        itemBuilder: (context, index) {
          return _SettingItem(title: titles[index]);
        },
        itemCount: titles.length,);
  }

  Widget _SettingItem({required String title}){    //设置类List
    return GestureDetector(
      onTap: (){
        SpUtils.remove(Constants.SP_Cookie_List);
        SpUtils.remove(Constants.SP_User_Nickname);
        setState(() {

        });

      },
      child: Container(
      margin: EdgeInsets.only(top: 15.h,left: 5.w,right: 5.w),
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [HexColor("#ffccdfdf"), HexColor("#ffffff")],
                      stops: [0.2, 0.6],),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: HexColor("#a39fa5"),width: 1.w),
      ),
      child: Row(
          children:[
            Container(
              margin: EdgeInsets.only(left: 10.w),
              child: Text("${title}",
                style: TextStyle(fontSize: 16.sp,color: HexColor("#656565"),),)
            ),
            Spacer(flex: 1,),
            Container(
              margin: EdgeInsets.only(right: 5.w),
              child: Icon(Icons.arrow_back_ios,
                color: HexColor("#656565"),
                size: 15.sp,
              ),
            )
        ])
    ),
    );
  }

}

