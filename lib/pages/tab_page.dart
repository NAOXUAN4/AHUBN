
import 'package:exp1_10_29/pages/personal/personal_page.dart';
import 'package:exp1_10_29/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import 'home/home_page.dart';
import 'hot_key/hot_key_page.dart';

class TabPage extends StatefulWidget{   //创建继承自StatefulWidget的类，必须要一个State实例
  @override
  State createState() {    //调用创建State的方法
    return _TabPageState();
  }
}

class _TabPageState extends State<TabPage>{
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomePage(),
          HotKeyPage(),
          PersonalPage(),
      ],),
      bottomNavigationBar: BottomNavigationBar(   //底部导航栏
        fixedColor: theme_color.theme_color_Dark,
        backgroundColor: theme_color.theme_color_Lightest,
        selectedLabelStyle: TextStyle(fontSize: 12.sp,fontFamily: "Roboto"),
        unselectedLabelStyle: TextStyle(fontSize: 8.sp,fontFamily: "Roboto"),
        currentIndex: _currentIndex,
        items: _barItems(),
        onTap: (int index){   //点击事件
          setState(() {
            _currentIndex = index;//切换index，刷新
          });
        },
      ),
    );
  }
  List<BottomNavigationBarItem> _barItems(){
    List <BottomNavigationBarItem> list = [];
    List<Map<String,IconData>> nameList = [
      {"Home" : Icons.home},
      {"HotKey":Icons.add_reaction},
      {"Personal" : Icons.account_box}];  //存储图标

    for (int i = 0; i < 3; i++){
      list.add(BottomNavigationBarItem(
        label: nameList[i].keys.first,
        activeIcon: Icon(
          nameList[i].values.first,
          color: theme_color.theme_color_Dark,),   //触发时
        icon: Icon(
          nameList[i].values.first,
          color: theme_color.theme_color_Light,),  //默认未触发时
      ));
    }
    return list;
  }
}
