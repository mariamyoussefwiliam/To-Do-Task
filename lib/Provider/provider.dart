
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class MainProvider  with  ChangeNotifier
{


  static MainProvider get(context)=>Provider.of<MainProvider>(context);
  int index=0;

  bool clickFloating=false;


  void changeCurrentIndex(bool clickfloating,int current_index)
  {

    clickFloating=clickfloating;
    index=current_index;

    notifyListeners();

  }


  List<Map> newtasks =[];
  List<Map> donetasks =[];
  List<Map> importanttasks =[];
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

      notifyListeners();
    });
  }


  Future getDateFromDatabase(Database database) async
  {
    newtasks=[];
    donetasks=[];
    importanttasks=[];


    notifyListeners();
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
           importanttasks.add(element);

         }

      });

      notifyListeners();
      print(importanttasks.toString());
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

          notifyListeners();

  });

  }




  Future InsertDatabase({
    @required String title,
    @required String date,
    @required String time,
    @required String state,
  })async
  {
    return await database.transaction((txn) {
      txn.rawInsert(
          "INSERT INTO tasks ('title','date','time','status') VALUES ('$title','$date','$time','$state')"
      ).then((value) {
        print("insert successfully");

        notifyListeners();
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
     notifyListeners();

   });

}


}