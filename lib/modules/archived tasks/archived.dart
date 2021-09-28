import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/component/component.dart';
import 'package:to_do_app/cubit/cubit.dart';
import 'package:to_do_app/cubit/states.dart';

class ArchivedTasks extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,States>(
      listener: (context,state){

      },
      builder: (context,state)=>
      ConditionalBuilder(
        condition: MainCubit.get(context).archivedtasks.length>0,
        builder:(context) => ListView.separated(
          //physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,

          itemBuilder: (BuildContext context, int index) =>

              buildTaskItem(MainCubit.get(context).archivedtasks[index], context)
          ,
          separatorBuilder: (BuildContext context, int index) => Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
          itemCount: MainCubit.get(context).archivedtasks.length,
        ),
        fallback:(context)=> Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.archive,size: 100,),
              Text("No Archived Tasks Yet"),
            ],
          ),
        )  ,
      ),
    );

  }

}