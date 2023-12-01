import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/shared/Cubit/States.dart';
import 'package:todoapp/shared/Cubit/cubit.dart';
import 'package:todoapp/shared/component/component.dart';
import 'package:todoapp/shared/component/resublecomponent.dart';
import 'package:todoapp/shared/constants/constants.dart';

class Archived_tasks extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit,Appstates>(
      listener: (context,state){},
      builder: (context,state){
        var tasks=Appcubit.get(context).archiveTasks;
        return taskBuilder(tasks);
      },



    );
  }
}
