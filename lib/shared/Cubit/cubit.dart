import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/modules/Archived_tasks/Archived_tasks.dart';
import 'package:todoapp/modules/Done_tasks/Done_tasks.dart';
import 'package:todoapp/modules/New_tasks/New_tasks.dart';
import 'package:todoapp/shared/Cubit/States.dart';
import 'package:todoapp/shared/constants/constants.dart';


class Appcubit extends Cubit<Appstates>
{
  Appcubit():super(AppInitialState());
  static Appcubit get(Context)=>BlocProvider.of(Context);
  int currentIndex=0;
  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archiveTasks=[];
  late Database database;
  List<Widget> screens=
  [
    New_tasks(),
    Done_tasks(),
    Archived_tasks(),
  ];
  List<String> titles=
  [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  void channgeIndex(int index)
  {
    currentIndex=index;
    emit(AppChangeNavBarState());
  }
  void createDatabase()
  {
     openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database,version)
        {
          print('database created');
          database.execute('CREATE TABLE Tasks(id INTEGER PRIMARY KEY,title TEXT,time TEXT, date TEXT, status TEXT)').then((value)
          {
            print('table created');
          }
          ).catchError((error)
          {
            print('Erorr when create table${error.toString()}');
          }
          );
        },
        onOpen: (database)
        {
          getDataFromDatabase(database);
          print('Databaseopened');
          }).then((value) {
      database=value;
      emit(CreateDataBaseState());
     });
  }
   insertToDatabase(
      @required String title,
      @required String time,
      @required String date,
      )
  async {
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO Tasks(title, time, date,status) VALUES("$title","$time","$date","new")')
          .then((value)
      {
        print('Inserted successfully');
        emit(InsertDataBaseState());
        getDataFromDatabase(database);
      }
      ).catchError((error)
      {
        print('Error${error.toString()}');
      }
      );
    });



  }
  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    emit(GetDataBaseloadingState());
    database.rawQuery('SELECT * FROM Tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archiveTasks.add(element);
        }

      });
      emit(GetDataBaseState());
    });
  }
  void UpdateDatabase(
    @required String status,
    @required int id,
) async {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      [status, id],
    ).then((value) {
       getDataFromDatabase(database);
      emit(UpdateDataBaseState());
    });
  }
  void DeleteDatabase(
      @required int id,
      ) async {
    database.rawDelete(
      'DELETE FROM tasks  WHERE id = ?',
      [id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(DeleteDataBaseState());
    });
  }
    bool isBottomsheetShown = false;
    IconData fabIcon = Icons.edit;
    void ChangeBottomSheetState(@required bool isShow,
        @required IconData icon) {
      isBottomsheetShown = isShow;
      fabIcon = icon;
      emit(AppChangeBottomSheetState());
    }
  }
