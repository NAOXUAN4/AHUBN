import 'package:exp1_10_29/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

class LoadingUi {

  LoadingUi._();  //私有构造函数,不会被实例化

  static Future showLoading()async {
    showToastWidget(Container(
      color: Colors.transparent,
      constraints: const BoxConstraints.expand(),  //子类占满父类
      child: Align(
        child: Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: theme_color.theme_color_Aveage,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: CircularProgressIndicator(
            color: theme_color.theme_color_Lightest,
            strokeWidth: 2.w,

          ),
        ),
      ),
    ),
        duration: const Duration(days: 1),  //持续显示
        handleTouch: true);  //触摸时是否隐藏,否
  }

  static hideLoading() {
    dismissAllToast();
  }
}