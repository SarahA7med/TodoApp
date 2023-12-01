import 'package:flutter/material.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/layout/Home_layout.dart';
import 'package:todoapp/shared/Cubit/cubit.dart';
bool isChecked = false;
Widget defaultFormField(
    @required TextEditingController Controller,
    @required TextInputType type,
    @required String ? validate(String),
    @required IconData prefix,
    @required String label,
    String? onSubmit(String? value)  ,
    String? onChanged(String? value)  ,
    void Function()? ontap  ,
    )=>
    Container(
      child: TextFormField(
  controller: Controller,
  keyboardType: type,
  decoration: InputDecoration(
      labelText: label ,
      enabledBorder:OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: primary
        )
      ),
      focusedBorder:OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
            color: primary
        )
      ),
      prefixIcon:  Icon(prefix,color: primary),
      ),
  onFieldSubmitted:onSubmit ,
  onChanged:onChanged ,
  validator: validate,
        onTap: ontap,

),
    );
Widget buildTaskItem(Map model,context)
=>Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
           CircleAvatar(
            radius: 35.0,
            backgroundColor: Colors.orange[300],
            child: Text(
                '${model['time']}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold),
            ),
          ),

        SizedBox(
          width: 20.0,
        ),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            children: [
              Text(
                '${model['title']}',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple
                ),
              ),
              Text(
                '${model['date']}',
                style: TextStyle(
                  color: Colors.purple
                ),
              ),
            ],
          ),
        ),

        SizedBox(

          width: 20.0,

        ),

        IconButton(
          onPressed: (){
            Appcubit.get(context).UpdateDatabase(
                 'done',
              model['id'],
            );
          },
            icon: Icon(
              Icons.check_box_outlined,
              color: Colors.cyan,
            )),
        IconButton(
          onPressed: (){
            Appcubit.get(context).UpdateDatabase(
               'archive',
               model['id'],
            );
          },
            icon: Icon(
              Icons.archive_outlined,
              color: Colors.cyan,
            )),
      ],
    ),
  ),
  onDismissed: (direction)
  {
    Appcubit.get(context).DeleteDatabase(model['id']);
  }
);