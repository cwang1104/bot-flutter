import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
Dio dio = Dio();
class AddTaskWidget extends StatefulWidget {
  @override
  _AddTaskState createState() {
    return _AddTaskState();
  }
}

class _AddTaskState extends State<AddTaskWidget> {
  //任务名
  final nameController = TextEditingController();
  String taskName = "";

  //是否定时开始
  int isTimeStart = 1;

  //定时开始时间
  late final startTime = TextEditingController();
  int startTimeUnix = 0;

  //是否定时结束
  int isTimeEnd = 1;

  //定时结束时间
  final endTime = TextEditingController();
  int endTimeUnix = 0;

  //时间间隔
  int sendInterval = 15;

  //开始小时
  final startTimeLimit = TextEditingController();
  int startTimeLimitInt = 0;

  //停止小时
  final endTimeLimit = TextEditingController();
  int endTimeLimitInt = 0;

  //定时任务说明
  final taskExplain = TextEditingController();
  //消息内容
  final sendContent = TextEditingController();
  //接收方QQ号或群号
  int sendToId = 0;

  //定时器类型id
  int timeType = 1;

  //消息接收者类型 群组或者私聊
  String sendToType = "group";

  // var acceptValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("添加定时任务"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: '定时器名称'),
            controller: nameController,

          ),
          //是否定时开始
          Row(
            children: <Widget>[
              const Text("是否定时开始"),
              Radio(
                value: 1,
                groupValue: isTimeStart,
                activeColor: Colors.blue,
                onChanged: (data) {
                  setState(() {
                    isTimeStart = data!;
                    if (isTimeStart == 2) {
                      setState(() {
                        startTime.text = "";
                        startTimeUnix = 0;
                      });
                    }
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              const Text(
                '是',
                style: TextStyle(fontSize: 18.0),
              ),
              Radio(
                value: 2,
                groupValue: isTimeStart,
                activeColor: Colors.blue,
                onChanged: (data) {
                  setState(() {
                    isTimeStart = data!;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              const Text(
                '否',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),

          TextField(
            decoration: const InputDecoration(
                labelText: '定时开始时间', icon: Icon(Icons.date_range_sharp)),
            readOnly: true,
            controller: startTime,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101));
              if (pickedDate != null && isTimeStart == 1) {
                setState(() {
                  startTime.text = pickedDate.toString();
                  //转换成时间工具
                  startTimeUnix = pickedDate.millisecondsSinceEpoch ~/ 1000;
                });
              }
            },
          ),
          Row(
            children: <Widget>[
              const Text("是否定时停止"),
              Radio(
                value: 1,
                groupValue: isTimeEnd,
                activeColor: Colors.blue,
                onChanged: (data) {
                  setState(() {
                    isTimeEnd = data!;
                    if (isTimeEnd == 2) {
                      setState(() {
                        endTime.text = "";
                        endTimeUnix = 0;
                      });
                    }
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              const Text(
                '是',
                style: TextStyle(fontSize: 18.0),
              ),
              Radio(
                value: 2,
                groupValue: isTimeEnd,
                activeColor: Colors.blue,
                onChanged: (data) {
                  setState(() {
                    isTimeEnd = data!;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              const Text(
                '否',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          TextField(
            decoration: const InputDecoration(
                labelText: '定时停止时间', icon: Icon(Icons.date_range_sharp)),
            readOnly: true,
            controller: endTime,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101));
              if (pickedDate != null && isTimeEnd == 1) {
                setState(() {
                  endTime.text = pickedDate.toString();
                  endTimeUnix = pickedDate.millisecondsSinceEpoch ~/ 1000;
                });
              }
            },
          ),
          TextField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
            ],
            decoration: const InputDecoration(labelText: '当日几时开始(0-23)'),
            controller: startTimeLimit,
            onChanged: (value) {
              if (value != "") {
                startTimeLimitInt = int.parse(value);
              }
            },
          ),
          TextField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
            ],
            decoration: const InputDecoration(labelText: '当日几时停止(0-23)'),
            controller: endTimeLimit,
            onChanged: (value) {
              if (value != "") {
                endTimeLimitInt = int.parse(value);
              }
            },
          ),

          Column(
            children: [
              Row(
                children: const [
                  Text(
                    '发送时间间隔:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Radio(
                    value: 15,
                    groupValue: sendInterval,
                    activeColor: Colors.blue,
                    onChanged: (data) {
                      setState(() {
                        sendInterval = data!;
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  const Text(
                    '15min',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  Radio(
                    value: 30,
                    groupValue: sendInterval,
                    activeColor: Colors.blue,
                    onChanged: (data) {
                      setState(() {
                        sendInterval = data!;
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  const Text(
                    '30min',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 60,
                    groupValue: sendInterval,
                    activeColor: Colors.blue,
                    onChanged: (data) {
                      setState(() {
                        sendInterval = data!;
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  const Text(
                    '60min',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  Radio(
                    value: 120,
                    groupValue: sendInterval,
                    activeColor: Colors.blue,
                    onChanged: (data) {
                      setState(() {
                        sendInterval = data!;
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  const Text(
                    '120min',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: <Widget>[
              const Text("定时器类型"),
              Radio(
                value: 1,
                groupValue: timeType,
                activeColor: Colors.blue,
                onChanged: (data) {
                  setState(() {
                    timeType = data!;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              const Text(
                '天气播报',
                style: TextStyle(fontSize: 18.0),
              ),
              Radio(
                value: 2,
                groupValue: timeType,
                activeColor: Colors.blue,
                onChanged: (data) {
                  setState(() {
                    timeType = data!;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              const Text(
                '消息播报',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              const Text("接收者类型"),
              Radio(
                value: "group",
                groupValue: sendToType,
                activeColor: Colors.blue,
                onChanged: (data) {
                  setState(() {
                    sendToType = data!;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              const Text(
                'QQ群',
                style: TextStyle(fontSize: 18.0),
              ),
              Radio(
                value: "private",
                groupValue: sendToType,
                activeColor: Colors.blue,
                onChanged: (data) {
                  setState(() {
                    sendToType = data!;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              const Text(
                '私聊',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          TextField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
            ],
            decoration: const InputDecoration(
              labelText: '接收者QQ号或者群号',
              hintText: "只能输入数字",
            ),
            // controller: sendTo,
            onChanged: (value) {
              setState(() {
                if (value != "") {
                  sendToId = int.parse(value);
                }
              });
            },
          ),
          TextField(
            minLines: 1,
            maxLines: null,
            decoration: const InputDecoration(labelText: '消息内容'),
            controller: sendContent,
          ),
          TextField(
            minLines: 1,
            maxLines: null,
            decoration: const InputDecoration(labelText: '定时任务说明'),
            controller: taskExplain,
          ),
          TextButton(
            onPressed: () {
              if (isTimeStart == 2) {
                startTimeUnix = 0;
              }
              if (isTimeEnd == 2) {
                endTimeUnix = 0;
              }

              if (isTimeStart == 1 &&
                  isTimeEnd == 1 &&
                  startTimeUnix > endTimeUnix) {
                showDialog(
                    context: context,
                    builder: (ctx) => const AlertDialog(
                          title: Text('提示'),
                          content: Text("定时开始之间必须小于定时停止时间"),
                        ));
                return;
              }
              if (startTimeLimitInt > endTimeLimitInt) {
                showDialog(
                    context: context,
                    builder: (ctx) => const AlertDialog(
                          title: Text('提示'),
                          content: Text("当日开始之间必须小于当日停止时间"),
                        ));
                return;
              }
              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: const Text('请确认后提交'),
                        content:  Text("定时器名称：${nameController.text}\n"
                            "是否定时开始：${isTimeStart == 1? "是":"否"}\n"
                            "定时开始时间:${startTime.text}\n"
                            "是否定时停止：${isTimeEnd == 1?"是":"否"}\n"
                            "定时停止时间:${endTime.text}\n"
                            "当日几时开始:$startTimeLimitInt时\n"
                            "当日几时结束:$endTimeLimitInt时\n"
                            "时间发送间隔：${sendInterval}min\n"
                            "定时器类型：${timeType == 1? "天气播报":"消息播报"}\n"
                            "接收方类型:${sendToType == "group"? "QQ群":"私聊"}\n"
                            "接收方QQ号:$sendToId\n"
                            "消息内容：${sendContent.text}\n"
                            "定时任务说明：${taskExplain.text}"
                            ""),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("取消"),
                          ),
                          TextButton(
                            onPressed: () {
                              addTask();
                            },
                            child: const Text("提交"),
                          ),
                        ],
                      ));
            },
            child: const Text('确定'),
          )
        ],
      ),
    );
  }
  addTask() async {
    print('kaishi');
    try{
      Response response = await dio.post(
        "https://4c37-240e-398-7189-e5b0-71cf-9476-e9f7-e7da.ap.ngrok.io/bot/add_task",
        data: {
          "task_name": nameController.text,
          'timed_start': isTimeStart,
          'start_time':startTimeUnix,
          'timed_end':isTimeEnd,
          'end_time':endTimeUnix,
          'timing_strategy':{
            'interval':sendInterval,
            'time_limit_start':startTimeLimitInt,
            'time_limit_end':endTimeLimitInt,
          },
          'timer_type_id':timeType,
          'send_type':sendToType,
          'send_to':sendToId,
          'task_explain':taskExplain.text,
          'sent_content':sendContent.text,
        },
        options: Options(headers: {
          'Content-Type': "application/json;charset=utf-8",
          "authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVSUQiOjMsIlVzZXJOYW1lIjoid2FuZ2xpIiwiZXhwIjoxNjk1ODgxNDQyLCJpc3MiOiJncWJvdCIsIm5iZiI6MTY2NDM0NDQ0Mn0.kDhg8x3GPMDqsEZVY6hNU3r6x0HUEFoov_zDQ3EITew",
        }),
      );
      if (response.data['code'] == 0){
        showDialog(
            context: context,
            builder: (ctx)=>AlertDialog(
              title: const Text("提示"),
              content: const Text("添加成功"),
              actions: [
                TextButton(onPressed: (){
                  Navigator.popUntil(context, (route){
                    return route.isFirst;
                  });
                },
                    child: const Text("确定"),
                )
              ],
            ));
      } else {
        showDialog(
            context: context,
            builder: (ctx)=>AlertDialog(
              title: const Text("提示"),
              content: const Text("添加失败，请重试（内部错误）"),
              actions: [
                TextButton(onPressed: (){
                  Navigator.of(context).pop();
                },
                  child: const Text("确定"),
                )
              ],
            ));
      }
    } on DioError catch (e){
      showDialog(
          context: context,
          builder: (ctx)=>AlertDialog(
            title: const Text("提示"),
            content: const Text("添加失败请重试"),
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              },
                child: const Text("确定"),
              )
            ],
          ));

      throw (e);
    }


  }
}
