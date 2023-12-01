import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/shared/Cubit/States.dart';
import 'package:todoapp/shared/Cubit/cubit.dart';
import 'package:todoapp/shared/component/component.dart';
import 'package:todoapp/shared/constants/constants.dart';

 class HomeLayout extends StatelessWidget {


   var scaffoldkey=GlobalKey<ScaffoldState>();
   var formkey=GlobalKey<FormState>();

   var titleController=TextEditingController();
   var timeController=TextEditingController();
   var dateController=TextEditingController();



   @override
   Widget build(BuildContext context) {
   return  BlocProvider(
     create: (BuildContext context )=>Appcubit()..createDatabase(),
     child: BlocConsumer<Appcubit,Appstates>(
       listener: (BuildContext context,Appstates state){
         if(state is InsertDataBaseState)
           {
             Navigator.pop(context);
           }
       },
       builder:(BuildContext context,Appstates state) {
         Appcubit cubit = Appcubit.get(context);
         return  Scaffold(
           key: scaffoldkey,
           appBar:AppBar(
             backgroundColor: Colors.orange[100],
             elevation: 0,
             title: Text(
              cubit.titles[cubit.currentIndex],
              ),
           ),
           body:Container(
             height: double.infinity,
             decoration: BoxDecoration(
              // image: DecorationImage(
                 //image: AssetImage('assets/images/background.jpg'), // Replace with your image path
                  // Adjust the fit property to control how the image is displayed
              // ),
             ),
             child: ConditionalBuilder(
               condition:state is! GetDataBaseloadingState  ,
               builder: (context)=>cubit.screens[cubit.currentIndex ],
               fallback: (context) =>Center(child: CircularProgressIndicator()),
             ),
           ),
           floatingActionButton: FloatingActionButton(
             backgroundColor: Colors.white,
             onPressed: () {
               if(cubit.isBottomsheetShown) {
                 if (formkey.currentState!.validate()) {
                   cubit.insertToDatabase(titleController.text, timeController.text, dateController.text);
                   // insertToDatabase(titleController.text,timeController.text,dateController.text)
                   //     .then((value)
                   // {
                   //   getDataFromDatabase(database).then((value) {
                   //     Navigator.pop(context);
                   //     // setState(() {
                   //     // isBottomsheetShown = false;
                   //     // fabIcon = Icons.edit;
                   //     // tasks=value;
                   //     // });
                   //   });
                   // });

                 }
               }
               else
               {
                 scaffoldkey.currentState!.showBottomSheet(
                       (context) =>Container(
                     color: Colors.white,
                     padding: const EdgeInsets.all(20.0),
                     child: Form(
                       key: formkey,
                       child: Column(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           defaultFormField(
                               titleController,
                               TextInputType.text,
                                   ( value)
                               {
                                 if(value.toString().isEmpty)
                                 {
                                   return 'Title must not be empty';
                                 }
                                 return null;
                               },
                               Icons.title,
                               'Task title',
                                   (value) => null,
                                   (value) => null,
                                   ()
                               {
                               }
                           ),
                           SizedBox(
                             height: 20,
                           ),
                           defaultFormField(
                               timeController,
                               TextInputType.datetime,
                                   ( value)
                               {
                                 if(value.toString().isEmpty)
                                 {
                                   return 'Time must not be empty';
                                 }
                                 return null;
                               },
                               Icons.access_time_outlined,
                               'Task time',
                                   (value) => null,
                                   (value) => null,
                                   (){
                                 showTimePicker(
                                     context: context,
                                     initialTime:TimeOfDay.now()
                                 ).then((value)
                                 {
                                   timeController.text=  value!.format(context);
                                 }
                                 );
                               }
                           ),
                           SizedBox(
                             height: 20,
                           ),
                           defaultFormField(
                               dateController,
                               TextInputType.datetime,
                                   ( value)
                               {
                                 if(value.toString().isEmpty)
                                 {
                                   return 'Data must not be empty';
                                 }
                                 return null;
                               },
                               Icons.date_range,
                               'Task date',
                                   (value) => null,
                                   (value) => null,
                                   () async{
                                 await showDatePicker(
                                     context: context,
                                     initialDate: DateTime.now(),
                                     firstDate: DateTime.now(),
                                     lastDate: DateTime.parse('2023-12-01')
                                 ).then((value)
                                 {
                                   dateController.text=DateFormat.yMMMd().format(value!);
                                 });
                               }
                           )
                         ],
                       ),
                     ),
                   ),

                 ).closed.then((value) {

                   cubit.ChangeBottomSheetState(
                       false,
                       Icons.edit,
                   );
                 });
                 cubit.ChangeBottomSheetState(
                     true,
                     Icons.add);
               }
             },
             child: Icon(
               cubit.fabIcon,
               color: Colors.orange,
             ),
           ),
           bottomNavigationBar:
           BottomNavigationBar(
             backgroundColor: Colors.orange[100],
             unselectedItemColor:Colors.white,
             selectedItemColor:Colors.orange,
               type:BottomNavigationBarType.fixed ,
               currentIndex: Appcubit.get(context).currentIndex,
               onTap: (index)
               {
                 Appcubit.get(context).channgeIndex(index);

               }
               ,
               items: [
                 BottomNavigationBarItem(
                   icon: Icon(
                       Icons.menu
                   ),
                   label: 'Tasks',
                 ),
                 BottomNavigationBarItem(
                   icon: Icon(
                       Icons.check_circle_outline
                   ),
                   label: 'Done',
                 ),
                 BottomNavigationBarItem(
                   icon: Icon(
                       Icons.archive_outlined
                   ),
                   label: 'Archive',
                 ),

               ],
             ),

         );
       },
     ),
   );
   }



 }


