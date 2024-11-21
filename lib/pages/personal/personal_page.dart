import 'dart:ui';
import 'package:exp1_10_29/pages/personal/personal_vm.dart';
import 'package:exp1_10_29/route/routes.dart';
import 'package:exp1_10_29/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import '../tab_page.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});
  @override createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  PersonalViewModel personalViewModel = PersonalViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    personalViewModel.getUserNickname();
  }


  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context){  //设置变化监听对象vm
      return personalViewModel;
    },
    child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: theme_color.theme_color_Lightest,
          ),
        child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _Header((){
                Navigator.pushNamed(context, RouteName.login);
              },personalViewModel),
              _Body(personalViewModel),
            ],
          )
    ),);}

  Widget _Header(GestureTapCallback? onTap,PersonalViewModel vm){
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 30,sigmaY: 30),
      child: Container(
              //头像上半部分
              margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
              padding: EdgeInsets.only(top: 0.h,bottom: 0.h),
              decoration: BoxDecoration(
                color: theme_color.theme_color_Lighter,
                borderRadius:BorderRadius.circular(15.r),
                border:   Border.all(color: theme_color.theme_color_Aveage,width: 1.w),
              ),
              width: double.infinity,
              height: 200.h,
              child: GestureDetector(
                onTap: vm.nickname == "未登录"  ? onTap : null,
                child: Container(   //头像名称承载容器
                  height: 50.h,
                  width: 10.w,
                  margin: EdgeInsets.only(top: 40.h,bottom: 50.h,left: 50.w,right: 50.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                      ),
                  child:Column(children: [
                    CircleAvatar(
                      radius: 35.r,
                      foregroundImage: AssetImage("assets/images/av2.jpg"),

                    ),
                    SizedBox(height: 10.h),
                    Text(vm.nickname ?? "",
                      style: TextStyle(fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: theme_color.theme_color_Aveage),)
              ],),),
              )
            ),);

  }

  Widget _Body(PersonalViewModel vm){//下方选项区域
    return Container(
        decoration: BoxDecoration(color: theme_color.theme_color_Lighter,
          border: Border.all(color: theme_color.theme_color_Aveage,width: 1.w),
          borderRadius: BorderRadius.circular(15.r)), //选项下半部分
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        width: double.infinity,
        height: 350.h,
        child: Column(children:[
          _SettingList(vm),
        ])
    );
  }

  Widget _SettingList(PersonalViewModel vm){
    var titles = ["我的收藏","检查更新","关于我的","退出登录"];
    List<GestureTapCallback> callbacks = [
      vm.nickname == "未登录" ? (){} : (){showToast("未登录");},
      (){},
      (){},
      vm.nickname != "未登录" ? (){
        personalViewModel.logout().then((value){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => TabPage()), // 假设TabPage是你想要跳转的目标页面
            (Route<dynamic> route) => false, // 这个条件表示移除所有之前的路由
          );
        });

      } : (){showToast("未登录");},
    ];
    return ListView.builder( //下方内容
        shrinkWrap: true,  //使滚动视图仅占用其子代实际所需的垂直空间
        physics: const NeverScrollableScrollPhysics(),   //禁止滚动
        itemBuilder: (context, index) {
          return _SettingItem(title: titles[index], onTap: callbacks[index]);
        },
        itemCount: titles.length,);
  }

  Widget _SettingItem({required String title, GestureTapCallback? onTap}){    //设置类List
    return InkWell(
      onTap: onTap,
      child: Container(
      margin: EdgeInsets.only(top: 15.h,left: 20.w,right: 20.w),
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        color: theme_color.theme_color_Lightest,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: theme_color.theme_color_Dark,width: 1.w),
      ),
      child: Row(
          children:[
            Container(
              margin: EdgeInsets.only(left: 10.w),
              child: Text("${title}",
                style: TextStyle(fontSize: 16.sp,color: theme_color.theme_color_Dark,),)
            ),
            Spacer(flex: 1,),
            Container(
              margin: EdgeInsets.only(right: 5.w),
              child: Icon(Icons.arrow_back_ios,
                color: theme_color.theme_color_Aveage,
                size: 15.sp,
              ),
            )
        ])
    ),
    );
  }

}


