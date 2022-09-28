
import 'package:flutter/material.dart';

class TaskDetail extends StatefulWidget {
  final int id;
  final String title;
  const TaskDetail({Key? key, required this.id,required this.title}):super(key: key);

  @override
  _TaskDetailState createState(){
    return _TaskDetailState();
  }
}

class _TaskDetailState extends State<TaskDetail>{
  @override
  Widget build(BuildContext context){
    return Text("${widget.id}");
  }
}