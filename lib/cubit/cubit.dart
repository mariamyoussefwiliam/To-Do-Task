
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/cubit/states.dart';
import 'package:to_do_app/modules/archived%20tasks/archived.dart';
import 'package:to_do_app/modules/done%20tasks/done.dart';
import 'package:to_do_app/modules/new%20tasks/new.dart';

class MainCubit extends Cubit<States>
{
  MainCubit():super(InitState());

  static MainCubit get(context)=>BlocProvider.of(context);
  int index=0;

  bool clickFloating=false;


  void changeCurrentIndex(bool clickfloating,int current_index)
  {

    clickFloating=clickfloating;
    index=current_index;
    emit(changeIndex());

  }


  List<Map> newtasks =[];
  List<Map> donetasks =[];
  List<Map> archivedtasks =[];
  Database database;



  void CreateDatabase()async
  {
    openDatabase(
        "todo.db",
        version: 1,
        onCreate: (database,version)
        {
          print("database created");
          database.execute(
              "CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT ,status TEXT)"
          ).then((value) {
            print("table created");

          }).catchError((error){
            print("error ${error.toString()}");
          });
        },
        onOpen: (database)
        {
          getDateFromDatabase(database);
          print("database opened");
        }
    ).then((value) {
      database =value;
      emit(CreateDatabaseState());
    });
  }


  void getDateFromDatabase(Database database) async
  {
    newtasks=[];
    donetasks=[];
    archivedtasks=[];

    emit(LoadingState());
     await database.rawQuery("SELECT * FROM tasks").then((value) {

      value.forEach((element) {
       if(element['status']=="new")
         {
           newtasks.add(element);
         }
       else if(element['status']=="done")
         {
           donetasks.add(element);
         }
       else
         {
           archivedtasks.add(element);
         }

      });
      emit(GetDataFromDatabaseState());
      emit(UpdateState());
    }

     );}

  Future<int>  Update ({
  @required int id,
    @required String status,
}) async
  {
  database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
          print("update done");
          getDateFromDatabase(database);
          emit(UpdateState());

  });

  }




  Future InsertDatabase({
    @required String title,
    @required String date,
    @required String time,
  })async
  {
    return await database.transaction((txn) {
      txn.rawInsert(
          "INSERT INTO tasks ('title','date','time','status') VALUES ('$title','$date','$time','new')"
      ).then((value) {
        print("insert successfully");
        emit(InsertdataIntoDatabaseState());
        getDateFromDatabase(database);


      }
      ).catchError((error){
        print("${error.toString()}");
      });

      return null;
    });
  }


void Delete({
    @required int id,
  }) async
{
   await database
      .rawDelete('DELETE FROM tasks WHERE id = $id').then((value) {
     print("delete done");
     getDateFromDatabase(database);
     emit(DeleteState());

   });

}


}