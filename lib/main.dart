import 'package:flutter/material.dart';

//导入电影页面
import './task/list.dart';
import './task/task_func.dart';
import './task/add.dart';

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
    //底部tab栏需要添加 DefaultTabController
    return DefaultTabController(
        length: 4, //底部tab栏的个数
        child: Scaffold(
          //顶部导航栏
          appBar: AppBar(
            title: const Text("定时器列表"),
            centerTitle: true,
          ),
          //侧边栏
          drawer: Drawer(
            child: ListView(
              padding: const EdgeInsets.all(0),
              //动态变化 []前面不能加const
              children: [
                const UserAccountsDrawerHeader(
                  accountEmail: Text('abc@abc.com'),
                  accountName: Text('name'),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage("https://img.syt5.com/2021/0813/20210813050227298.jpg"),
                  ),
                  //美化当前控件
                  decoration: BoxDecoration(
                    //盒子的背景图片
                    image: DecorationImage(
                      //填充满整个box
                      fit: BoxFit.cover,
                       image:NetworkImage("https://img.syt5.com/2021/0813/20210813050227298.jpg"),
                    ),
                  ),
                ),


                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext ctx) {
                          return TaskFuncList();
                        },
                      ),
                    );
                  },
                  title: Text('定时器功能列表'),
                  trailing: Icon(Icons.list_alt),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext ctx) {
                          return AddTaskWidget();
                        },
                      ),
                    );
                  },
                  title: Text('添加定时器'),
                  trailing: Icon(Icons.add_alarm_outlined),
                ),
                ListTile(
                  onTap: () {
                    print('goat');
                  },
                  title: Text('定时器列表'),
                  trailing: Icon(Icons.list_outlined),
                ),

                //分割线控件
                const Divider(),
                ListTile(
                  onTap: () {
                    print('goat');
                  },
                  title: Text('退出'),
                  trailing: Icon(Icons.exit_to_app),
                ),
              ],
            ),
          ),

          bottomNavigationBar:  Container(
            decoration: const BoxDecoration(color: Colors.black),

            //一般高度为50
            height: 50,
            child: const TabBar(
              labelStyle: TextStyle(height: 0,fontSize: 10),

              tabs: [
                Tab(
                  text: '全部',
                  icon: Icon(Icons.all_inbox),
                ),
                Tab(
                  text: '运行中',
                  icon: Icon(Icons.all_inbox),
                ),
                Tab(
                  text: '未完成',
                  icon: Icon(Icons.all_inbox),
                ),
                Tab(
                  text: '已完成',
                  icon: Icon(Icons.all_inbox),
                ),
              ],
            ),
          ),

          body:  const TabBarView(children: [
            TaskListWidget(mt: 4,),
            TaskListWidget(mt: 2,),
            TaskListWidget(mt: 1,),
            TaskListWidget(mt: 3,),
          ],),
        ));
  }
}
