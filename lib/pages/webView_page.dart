import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class WebViewPage extends StatefulWidget {
  // 传入标题
  final String title;
  //请求title，构造webView对象时候title为必传参数
  const WebViewPage({Key? key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {

  var _message = "NULL";
  var  _roll_times = 0;
  @override
  void initState() {
    super.initState();
  }
  void didChangeDependencies() {  // 当依赖改变
    super.didChangeDependencies();
    var map = ModalRoute.of(context)?.settings.arguments;
    if (map is Map){
      _message = map["message"];

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: SafeArea(child: Container(
        margin: EdgeInsets.all(15.r),
        height: 400.h,
        width: 400.h,
        decoration: BoxDecoration(
          color: HexColor("#b0abb2"),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_message,
                  textAlign:TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 15.sp),),
                Text("Roll_times: ${_roll_times}"),
              ],
            ),
            _buildButtons(),
          ],
        )
      )),

    );
  }

  void _on_Press(){
    setState(() {
      _roll_times += 1;
    });
  }

  Widget _buildButtons(){
    return Container(
      margin: EdgeInsets.all(15.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(HexColor("#fbf4ff")),
              shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r)
                  )
              )
            ),
            onPressed: _on_Press,
            child: Text('凸起按钮Dazhu🥰'),
          ),
          SizedBox(height: 16.0),
          TextButton(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(HexColor("#fbf4ff")),
                shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r)
                    )
                )
            ),
            onPressed: _on_Press,
            child: Text('文本按钮Daxu😿'),
          ),
          SizedBox(height: 16.0),
          OutlinedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(HexColor("#fbf4ff")),
                shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r)
                    )
                )
            ),
            onPressed: _on_Press,
            child: Text('轮廓按钮DAlu🤫'),
          ),
          SizedBox(height: 16.0),
        ]
      ),
    );
  }
}
