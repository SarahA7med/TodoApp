import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/shared/component/component.dart';
import 'package:todoapp/shared/constants/constants.dart';

Widget taskBuilder(
    @required List<Map> tasks,
    )=>ConditionalBuilder(
  condition:tasks.length>0,
  builder: (context)=>ListView.separated(itemBuilder:(context,index)=>buildTaskItem(tasks[index],context),
    separatorBuilder: (context,index)=>Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    ),
    itemCount: tasks.length,
  ),
  fallback:(context)=>Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          color: Colors.cyan,
          size: 100.0,
        ),
        Text(
          'No tasks yet, Please add some tasks',
          style: TextStyle(
              color: Colors.cyan,
              fontWeight: FontWeight.w600 ,
              fontSize: 20
          ),
        )
      ],
    ),
  ) ,
);