import 'package:exp1_10_29/pages/mycollects/mycollects_vm.dart';
import 'package:exp1_10_29/route/routes.dart';
import 'package:exp1_10_29/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class MyCollectsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyCollectsPageState();
  }
}

class _MyCollectsPageState extends State<MyCollectsPage>{

  MyCollectsViewModel  ViewModel = MyCollectsViewModel();

  @override
  void initState() {
    super.initState();
    ViewModel.getCollects(false);  //lOADmORE = false
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyCollectsViewModel>(create: (context){  //设置变化监听对象vm
      return ViewModel;
    },
    child: Scaffold(
      appBar: AppBar(
        title: Text("我的收藏",style: TextStyle(color: theme_color.theme_color_Aveage,fontSize: 20.sp),),
        backgroundColor: theme_color.theme_color_Light,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: theme_color.theme_color_Aveage,size: 30.sp,),
          onPressed: (){
            Navigator.pop(context);
          }
        )
      ),
      body: Container(
        decoration: BoxDecoration(
          color: theme_color.theme_color_Lightest,
        ),
        child: Consumer<MyCollectsViewModel>(builder: (context,vm,child){
           return ListView.builder(
              itemCount: vm.collects.length,
              itemBuilder: (context,index){
                return _CollectItem(index: index);
              });
        }),

        )
      ));
  }

  Widget _CollectItem({required int index}){
      return Consumer<MyCollectsViewModel>(builder: (context,vm,child){
        return InkWell(
          onTap: (){
            Navigator.pushNamed(context, RouteName.webViewPage,arguments: {
                          "title":vm.collects[index].title ?? "",
                          "message":"Card index: ${index}",
                          "target_url": vm.collects[index].link ?? ""});
          },
          child: Container(    //收藏Items
              height: 80.h,
              width: double.infinity,
              margin: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h),
              decoration: BoxDecoration(
                color: theme_color.theme_color_Lighter,
                border: Border.all(color: theme_color.theme_color_Aveage,width: 1.w),
                borderRadius: BorderRadius.all(Radius.circular(15.r),
                ),
              ),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5.w,right: 5.w,top: 5.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.r)),
                        color: theme_color.theme_color_LighterP,
                      ),
                      height: 40.h,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 5.w),
                            child: CircleAvatar( //头像
                              radius: 20.r,
                              foregroundImage: AssetImage(
                                "assets/images/av2.jpg",),
                              backgroundColor: HexColor("#fffffff"),

                            ),
                          ),  //头像
                           Container(
                                  width: 250.w,
                                  margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 6.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        vm.collects[index].title ?? "",
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
                                ),  //内容



                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5.w,right: 5.w,top: 5.h),
                      decoration: BoxDecoration(
                        color: theme_color.theme_color_Lightest,
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      ),
                      height: 22.h,
                      child: Row(
                        children: [
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 13.w,vertical: 3.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            ),
                            width: 60.w,
                            height: 22.h,
                            child: Text("${vm.collects[index].niceDate}",style: TextStyle(fontSize: 10.sp,color: theme_color.theme_color_Aveage),),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
        );
      });
    }
}
