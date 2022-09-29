



import 'package:flutter/material.dart';

class AddTask extends StatelessWidget {
  final nameController = TextEditingController();
  final timeStart = TextEditingController();
  final startTime = TextEditingController();
  final timeEnd = TextEditingController();
  final endTime = TextEditingController();
  final startTimeLimit = TextEditingController();
  final endTimeLimit = TextEditingController();
  final interval = TextEditingController();
  final timerTypeId = TextEditingController();
  final sendType = TextEditingController();
  final taskExplain = TextEditingController();
  final sendContent = TextEditingController();
  final sendTo = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("添加定时任务"),
        centerTitle: true,
      ),
      body: ListView(
        children:  [
          TextField(
            decoration: const InputDecoration(labelText: '定时器名称'),
            controller: nameController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: '是否定时开始'),
            controller: timeStart,
          ),
          TextField(
            decoration: const InputDecoration(
                labelText: '定时开始时间',
              icon: Icon(Icons.date_range_sharp)
            ),
            readOnly: true,
            controller: startTime,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101)
              );
              if (pickedDate != null){
                    print(pickedDate);
              }
              print('---------------');
            },
          ),
          TextField(
            decoration: const InputDecoration(labelText: '是否定时停止'),
            controller: timeEnd,
          ),
          TextField(
            decoration: const InputDecoration(labelText: '定时停止时间'),
            controller: endTime,
          ),
          TextField(
            decoration: const InputDecoration(labelText: '当日几时开始'),
            controller: startTimeLimit,
          ),
          TextField(
            decoration: const InputDecoration(labelText: '当日几时停止'),
            controller: endTimeLimit,
          ),
          TextField(
            decoration: const InputDecoration(labelText: '发送间隔（分钟）'),
            controller: interval,
          ),
          TextField(
            decoration: const InputDecoration(labelText: '定时器类型id'),
            controller: timerTypeId,
          ),
          TextField(
            decoration: const InputDecoration(labelText: '接收者类型'),
            controller: sendType,
          ),
          TextField(
            decoration: const InputDecoration(labelText: '定时任务说明'),
            controller: taskExplain,
          ),
          TextField(
            decoration: const InputDecoration(labelText: '消息内容'),
            controller: sendContent,
          ),
          TextField(
            decoration: const InputDecoration(labelText: '接收者号'),
            controller: sendTo,
          ),
          TextButton(
            onPressed: (){
              print(nameController.text);
            },
            child: Text('butto'),
          )
        ],
      ),
    );
  }



}