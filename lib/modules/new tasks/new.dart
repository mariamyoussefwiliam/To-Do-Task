import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Provider/provider.dart';
import 'package:to_do_app/component/component.dart';
class NewTasks extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition:MainProvider.get(context).newtasks.length>0 ,
      builder: (context)=>

          GridView.count(
            shrinkWrap: true,

            crossAxisCount: 1,
           childAspectRatio: 1 /0.28,
            children: List.generate(
              MainProvider.get(context).newtasks.length,
                  (index) =>   buildTaskItem(MainProvider.get(context).newtasks[index], context,MainProvider.get(context).index)
            ),
          ),

      fallback: (context)=>Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.list,size: 100,),
          Text("No New Tasks Yet"),
        ],
      ) ,
      ),
    );
  }
}

