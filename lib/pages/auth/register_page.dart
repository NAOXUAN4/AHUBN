import 'package:exp1_10_29/pages/auth/auth_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {

   AuthViewModel ViewModel = AuthViewModel();
   bool is_obscureText = true;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthViewModel>(create: (context){  //设置变化监听对象vm
      return ViewModel;
    },
    // TODO: implement build
    child: Scaffold(
        body:Container(   //输入框承载
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.all(30.w),
          child: Consumer<AuthViewModel>(builder: (context,vm,child){
            return Column(
              children: [
                SizedBox(height: 150.h),
                _InputBox("请输入账号", Icons.person,false, (value){
                  vm.registerInfo.username = value;  //通过回调函数在每次输入时更新vm的registerInfo对象
                }),  //只有Require 的参数可以用 XXX: data  //账号输入框
                SizedBox(height: 20.h),
                _InputBox("请输入密码", Icons.lock, true,(value){
                  vm.registerInfo.password = value;
                }),    //密码输入框
                SizedBox(height: 20.h),
                _InputBox("请再次输入密码", Icons.lock,true,(value){
                  vm.registerInfo.repassword = value;
                }),
                SizedBox(height: 20.h),
                Container(     //登录按钮
                  height: 35.h,
                  width: 240.w,
                  child: OutlinedButton(
                    onPressed: (){
                      print("注册");
                      ViewModel.register().then((value){
                         if(value?? false){
                           showToast("注册成功");
                           Navigator.pop(context);
                         }
                      });
                    },
                    child: Text("注册",style: TextStyle(color: Colors.grey,fontSize: 15.sp),),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey,width: 1.r),
                      foregroundColor: HexColor("#5cccc1"),
                      //backgroundColor: HexColor("#5cccc1"),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    ),
                )), //登录按钮
              ],);
          })
        ))

    );
  }
  Widget _InputBox(String? text, IconData? icon, bool isPassword, ValueChanged<String>? onChanged)
    {
      return Container(
                width: 250.w,
                height: 50.h,
                child:TextField(
                  obscureText: is_obscureText && isPassword,
                  onChanged: onChanged,  //监听输入框内容,使用onChanged回调函数
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: Colors.grey)),  //未激活状态
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: HexColor("#5cccc1"),width: 2.r)), //激活状态
                    hintText: "${text}",
                    hintStyle: TextStyle(fontSize: 15,color: Colors.grey),
                    prefixIcon: Icon(icon),
                    suffixIcon: isPassword ? IconButton(icon: Icon(is_obscureText ? Icons.visibility_off : Icons.visibility), onPressed: (){
                      setState(() {
                        // TODO: implement onPressed
                           //密文输出型态切换
                        is_obscureText = !is_obscureText;
                      });
                    },) : null
                  ),
                ),);
    }
}

