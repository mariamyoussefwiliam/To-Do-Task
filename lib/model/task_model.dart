import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
@HiveType(typeId: 1)
class TaskModel
{
  TaskModel(

  {
@required this.title,
    @required this.date,
    @required this.time,
    @required this.status,


});

  @HiveField(0)
  String title;
  @HiveField(1)
  String date;
  @HiveField(2)
  String time;
  @HiveField(3)
  String status;



  Map<String, dynamic> toJson(
      @required String title,
      @required String date,
      @required String time,
      @required String status,

      ) {
    final Map data = Map();

    data["title"] = title;
    data["date"] = date;
    data["time"] = time;
    data["status"] = status;

    return data;
  }
}
class TodoModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final typeId = 0;

  @override
  TaskModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModel(

      title: fields[0] as String,
      date: fields[1] as String,
      time: fields[2] as String,
      status: fields[3] as String,


    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.status)

    ;
  }
}

