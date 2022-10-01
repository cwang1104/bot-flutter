import 'package:botflutter/task/detail.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

Dio dio = Dio();

//有数据  则定义有状态state
class TaskListWidget extends StatefulWidget {
  //接收mt参数后放入mt string中
  final int mt;

  //key取消必传参数,在类型后添加?
  const TaskListWidget({Key? key, required this.mt}) : super(key: key);

  @override
  _TaskListState createState() {
    return _TaskListState();
  }
}

//有状态控件 结合状态管理类  进行实现
//必须传入<TaskListWidget>才可用
class _TaskListState extends State<TaskListWidget> {
  var taskResponseList = [];

  //控件被创建的时候，执行initstate
  @override
  void initState() {
    super.initState();
    getTaskList();
  }

  //渲染当前页面控件的ui结构
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //代表循环次数
      itemCount: taskResponseList.length,
      itemBuilder: (BuildContext ctx, int i) {
        var taskItem = taskResponseList[i];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext ctx) {
                  return TaskDetail(
                    id: taskItem['id'],
                    taskName: taskItem['task_name'],
                  );
                },
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 6),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white30,
                border: Border.all(
                  color: Colors.white30,
                  width: 3,
                  style: BorderStyle.solid,
                ),
              ),
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                //横向轴
                crossAxisAlignment: CrossAxisAlignment.start,
                //纵向轴
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("名称: ${taskItem['task_name']}"),
                  Text("定时器类型: ${taskItem['timer_type_name']}"),
                  Text(
                      "定时策略: 每日定时：${taskItem['timing_strategy']['time_limit_start']}-${taskItem['timing_strategy']['time_limit_end']}点，间隔${taskItem['timing_strategy']['interval']}分钟"),
                  Text("当前状态: ${taskItem['status']}"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //
  getTaskList() async {
    //

    print('kaishi');
    var response = await dio.post(
      "https://4c37-240e-398-7189-e5b0-71cf-9476-e9f7-e7da.ap.ngrok.io/bot/get_task_list",
      data: {"current_page": 1, "page_size": 10, "status": widget.mt},
      options: Options(headers: {
        'Content-Type': "application/json;charset=utf-8",
        "authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVSUQiOjMsIlVzZXJOYW1lIjoid2FuZ2xpIiwiZXhwIjoxNjk1ODgxNDQyLCJpc3MiOiJncWJvdCIsIm5iZiI6MTY2NDM0NDQ0Mn0.kDhg8x3GPMDqsEZVY6hNU3r6x0HUEFoov_zDQ3EITew",
      }),
    );

    var result = response.data['data']['tasks'];
    print(result);
    if (result != null){
      //对私有数据赋值,必须用set，否则数据不会更新
      setState(() {
        //通过dio返回的数据，都需要把复制的操作放到setState中
        //此处的变量需要在_TaskListState 开始时候声明
        taskResponseList = result;
      });
    }


  }
}
