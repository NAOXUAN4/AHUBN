import 'package:exp1_10_29/pages/auth/auth_vm.dart';
import 'package:exp1_10_29/route/routes.dart';
import 'package:exp1_10_29/theme.dart';
import 'package:exp1_10_29/utils/sp_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:oktoast/oktoast.dart';

import '../../constants.dart';
import '../tab_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  bool is_obscureText = true;
  AuthViewModel ViewModel = AuthViewModel();

  //用Controller来获取输入框的值
    // 定义控制器
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {   //销毁页面时，销毁控制器
    // TODO: implement dispose
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // 直接通过控制器获取输入值
    final username = _usernameController.text;
    final password = _passwordController.text;
    // print('用户名: $username, 密码: $password,');

    ViewModel.loginInfo.username = username == "" ? null : username;  //赋值给ViewModel.loginInfo
    ViewModel.loginInfo.password = password == "" ? null : password;

    ViewModel.login().then((value) {
      if(value == true){
        // showToast("登录成功");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => TabPage()), // 假设TabPage是你想要跳转的目标页面
            (Route<dynamic> route) => false, // 这个条件表示移除所有之前的路由
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body:Container(   //输入框承载
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme_color.theme_color_Lightest
          ),
          padding: EdgeInsets.all(30.r),
          child: Column(
            children: [
              SizedBox(height: 150.h),
              _InputBox("请输入账号", Icons.person,false,_usernameController),  //只有Require 的参数可以用 XXX: data  //账号输入框
              SizedBox(height: 20.h),
              _InputBox("请输入密码", Icons.lock,true,_passwordController),    //密码输入框
              SizedBox(height: 30.h),
              Container(     //登录按钮
                height: 35.h,
                width: 240.w,
                child: OutlinedButton(
                  onPressed: (){
                    print("登录");
                    _handleLogin();
                  },
                  child: Text("登录",style: TextStyle(color: theme_color.theme_color_Aveage,fontSize: 15.sp),),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: theme_color.theme_color_Aveage,width: 1.r),
                    foregroundColor: theme_color.theme_color_Lighter,
                    //backgroundColor: HexColor("#5cccc1"),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
              )), //登录按钮
              SizedBox(height: 10.h),
              Container(     //登录按钮
                height: 45.h,
                width: 250.w,
                child: TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, "/register");
                  },
                  child: Text("注册",style: TextStyle(color: theme_color.theme_color_Aveage,fontSize: 15.sp),),
                  style: TextButton.styleFrom(
                    foregroundColor: theme_color.theme_color_Aveage,
                    //backgroundColor: HexColor("#5cccc1"),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
              )) //注册按钮
            ],)
        ));
  }
  Widget _InputBox(String? text, IconData? icon, bool isPassword, TextEditingController controller)
    {
      return Container(
                width: 250.w,
                height: 50.h,
                child:TextField(
                  controller: controller,
                  obscureText: is_obscureText && isPassword,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: theme_color.theme_color_Aveage)),  //未激活状态
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: theme_color.theme_color_Darker,width: 2.r)), //激活状态
                    hintText: "${text}",
                    hintStyle: TextStyle(fontSize: 15,color: theme_color.theme_color_Aveage),
                    prefixIcon: Icon(icon, color: theme_color.theme_color_Aveage),
                    suffixIcon: isPassword ? IconButton(icon: Icon(is_obscureText ? Icons.visibility_off : Icons.visibility, color: theme_color.theme_color_Aveage), onPressed: (){
                      setState(() {
                        // TODO: implement onPressed
                           //密文输出型态切换
                        is_obscureText = !is_obscureText;
                      });
                    },) : null
                  ),
                  ),
                );
    }
}