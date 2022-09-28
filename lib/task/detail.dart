import 'dart:html';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

Dio dio = Dio();

class TaskDetail extends StatefulWidget {
  final int id;
  final String taskName;

  const TaskDetail({Key? key, required this.id,required this.taskName}) : super(key: key);

  @override
  _TaskDetailState createState() {
    return _TaskDetailState();
  }
}

class _TaskDetailState extends State<TaskDetail> {
  var taskDetail;

  //控件被创建的时候，执行initstate
  @override
  void initState() {
    super.initState();
    getTaskDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('定时器详情'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          //横向轴
          crossAxisAlignment: CrossAxisAlignment.start,
          //纵向轴
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('名称: ${taskDetail['task_name']}'),
            Text('定时器类型: ${taskDetail['timer_type_name']}'),
            Text('是否定时开始: ${taskDetail['timed_start']}'),
            Text('定时开始时间: ${taskDetail['start_time']}'),
            Text('是否定时结束: ${taskDetail['timed_end']}'),
            Text('定时结束时间: ${taskDetail['end_time']}'),
            Text(
                "定时策略: 每日定时：${taskDetail['timing_strategy']['time_limit_start']}-${taskDetail['timing_strategy']['time_limit_end']}点，间隔${taskDetail['timing_strategy']['interval']}分钟"),
            Text('接受号码: ${taskDetail['send_to']}'),
            Text('接收者类型: ${taskDetail['send_type']}'),
            Text('消息内容: ${taskDetail['sent_content']}'),
            Text('当前状态: ${taskDetail['status']}'),
            Text('创建时间: ${taskDetail['created_time']}'),
            Text('定时器说明: ${taskDetail['task_explain']}'),
            RawMaterialButton(
              child: Text("停止当前定时器",
                style: TextStyle(
                color: Colors.white,
                ),
              ),
              fillColor: Colors.red,
              onPressed: () {
                stopTimerTask();
              },
            ),
          ],
        ),
      ),
    );
  }

  getTaskDetail() async {
    print('kaishi');
    var response = await dio.post(
      "https://3645-61-157-13-48.ap.ngrok.io/bot/get_task_info",
      data: {"task_id": widget.id,'task_name':widget.id},
      options: Options(headers: {
        'Content-Type': "application/json;charset=utf-8",
        "authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVSUQiOjMsIlVzZXJOYW1lIjoid2FuZ2xpIiwiZXhwIjoxNjk1ODgxNDQyLCJpc3MiOiJncWJvdCIsIm5iZiI6MTY2NDM0NDQ0Mn0.kDhg8x3GPMDqsEZVY6hNU3r6x0HUEFoov_zDQ3EITew",
      }),
    );

    var result = response.data;
    print(result);

    //对私有数据赋值,必须用set，否则数据不会更新
    setState(() {
      //通过dio返回的数据，都需要把复制的操作放到setState中
      //此处的变量需要在_TaskListState 开始时候声明
      taskDetail = result['data']['taskInfo'];
    });
  }

  stopTimerTask() async {
    var response = await dio.post(
      "https://3645-61-157-13-48.ap.ngrok.io/bot/stop_task",
      data: {"task_id": widget.id},
      options: Options(headers: {
        'Content-Type': "application/json;charset=utf-8",
        "authorization":
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVSUQiOjMsIlVzZXJOYW1lIjoid2FuZ2xpIiwiZXhwIjoxNjk1ODgxNDQyLCJpc3MiOiJncWJvdCIsIm5iZiI6MTY2NDM0NDQ0Mn0.kDhg8x3GPMDqsEZVY6hNU3r6x0HUEFoov_zDQ3EITew",
      }),
    );
    print(response.data);
  }
}
