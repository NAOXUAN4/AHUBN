import 'package:exp1_10_29/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Aboutpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: theme_color.theme_color_Lighter),
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.all(20.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("❤️感谢使用本app❤️",style: TextStyle(fontSize: 20.sp,color: theme_color.theme_color_Darker),),
              Text("本app是作者学习Flutter的第一个项目😿",style: TextStyle(fontSize: 15.sp,color: theme_color.theme_color_Darkest)),
              Text("通过项目学习了Flutter的常用组件和常用方法,前端接口连接,数据传输，本地存储等技能。经过在嵌套地狱的三个星期断断续续的挣扎和探索中，项目终于完成了。",style: TextStyle(fontSize: 15.sp,color: theme_color.theme_color_Darker)),
              Text("  相信以后还有很多和Dart和Flutter框架接触的机会🙊",style: TextStyle(fontSize: 15.sp,color: theme_color.theme_color_Darkest),),
              Text("                        ————编辑于 2024年11月21日 Nanyian❤️",style: TextStyle(fontSize: 12.sp,color: theme_color.theme_color_Darker))

            ],
          ),
        ),
      ),
    );
  }
}