import 'package:flutter/material.dart';

void main() => runApp(MyApp());

//statelessWidget 无状态的
class MyApp extends StatelessWidget {
  @override
  //每个继承类必须有一个build
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QQ机器人管理',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),

      //通过MyHome构建页面
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //顶部导航栏
      appBar: AppBar(
        title: new Text("定时器列表"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      //侧边栏
      drawer: Drawer(),
    );
  }
}
