import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

Dio dio = Dio();

class TaskFuncList extends StatefulWidget{

  @override
  _TaskFuncListState createState(){
    return _TaskFuncListState();
  }
}

class _TaskFuncListState extends  State<TaskFuncList>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("定时器类型列表"),
        centerTitle: true,
      ),
      body: Text('暂未开放'),
    );
  }
}