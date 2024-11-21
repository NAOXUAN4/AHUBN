import 'package:exp1_10_29/commonUi/Loading_ui.dart';
import 'package:exp1_10_29/pages/search/search_vm.dart';
import 'package:exp1_10_29/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../route/routes.dart';

class SearchPage extends StatefulWidget {

  final String keyword;
  const SearchPage({Key? key, required this.keyword}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _controller;
  SearchViewModel ViewModel = SearchViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    // 在第一帧绘制后显示 loading
      LoadingUi.showLoading();
    });
    _controller = TextEditingController(text: widget.keyword ?? "");
    ViewModel.search(widget.keyword);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchViewModel>(create: (context){  //设置变化监听对象vm
      return ViewModel;
    },
        child:Scaffold(
      body: Container(
        color: theme_color.theme_color_Lightest,
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              _searchBar(  //顶部搜索区域
                onBack: (){Navigator.pop(context);},
                onSearch: (value) {
                  ViewModel.search(value);
                },
                onClean: () {
                  _controller.text = "";  //使用_controller清空输入框
                  ViewModel.search("");
                }
              ),
              _searchResults()
            ],))
        ),
    ));
  }

  Widget _searchBar( { required GestureTapCallback? onBack, ValueChanged<String>? onSearch,
      GestureTapCallback? onClean}){   //顶部输入区域
    return Container(  //搜索输入框承载
      padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 5.h),
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: theme_color.theme_color_Lighter,
        border: Border.all(color: theme_color.theme_color_Aveage,width: 1.r),
      ),
      width: double.infinity,
      child: Row(
        children: [
          GestureDetector(   //返回按钮
              onTap: onBack,
              child:Icon(Icons.arrow_back_ios,color: theme_color.theme_color_Aveage,)),
          SizedBox(width: 10.w,),
          Expanded(
            child: TextField(   //输入框
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,  //监听回车
              onSubmitted: onSearch,
              controller: _controller,
              decoration: InputDecoration(
                fillColor: theme_color.theme_color_Lightest,
                filled: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: theme_color.theme_color_Light)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: theme_color.theme_color_Aveage)),
                hintText: "搜索",
                hintStyle: TextStyle(color: theme_color.theme_color_Aveage,fontSize: 15.sp),
              )
            ),),
          SizedBox(width: 10.w,),
         GestureDetector(onTap: onClean,   //清除输入按钮
             child: Icon(Icons.close,color: theme_color.theme_color_Aveage,)),
        ]
      ));
  }

  Widget _searchResults(){
    return Consumer<SearchViewModel>(builder: (context,vm,child){
      return Expanded(  //搜索结果承载
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: theme_color.theme_color_Aveage,blurRadius: 1.r)],
          border: Border.all(color: theme_color.theme_color_Aveage,width: 1.r),
          color: theme_color.theme_color_Lighter,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: ListView.builder(itemBuilder: (context,index){
          return _resultItems(vm.searchList?[index].title?? "", (){
            print("点击了${vm.searchList?[index].link?? ""}");
            // TODO: 点击跳转事件
            Navigator.pushNamed(context, RouteName.webViewPage,arguments: {
                          "title":vm.searchList?[index].title ?? "",
                          "message":"Card index: ${index}",
                          "target_url": vm.searchList?[index].link ?? ""});
          },index);    //搜索结果Items
        }
        ,itemCount: vm.searchList?.length?? 0,),
      ));
    });
  }

  Widget _resultItems(String text,GestureTapCallback ? onTap,int index){
    return Consumer<SearchViewModel>(builder: (context,vm,child){   //搜索结果列表
      return  InkWell(
        onTap: onTap,
        child: Container(     //搜索结果Items
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: theme_color.theme_color_Aveage,
                    width: 1.r,)),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                height: 50.h,
                child: Html(data:"${vm.searchList?[index].title?? ""}",style: {
                  'html': Style(color: theme_color.theme_color_Darkest,
                    fontSize: FontSize(15.sp),textOverflow:TextOverflow.ellipsis),
                  'em': Style(color: theme_color.theme_color_Aveage,fontWeight: FontWeight.bold,
                      textDecoration: TextDecoration.underline), //下划线
                },),
              ),
      );
    });
  }
}