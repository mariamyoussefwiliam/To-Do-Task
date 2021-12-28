
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/Provider/provider.dart';

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );


Widget buildTaskItem (  @required Map task,
    BuildContext context,
    int indexx
   )
=>
    ChangeNotifierProvider<MainProvider>(

create: (_)=>MainProvider(),
child:  Dismissible(
      key: Key(task["id"].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius:40,
              child: Text(task['time']),

            ),
            SizedBox(width: 20,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(task['title'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),

                  ),
                  Text(task['date'],
                    style: TextStyle(

                        color: Colors.grey

                    ),

                  ),

                ],
              ),
            ),

    SizedBox(width: 20,),
            indexx!=0? IconButton(icon: Icon(Icons.list,color: Colors.blue,size: 30,)
              ,
              onPressed: ()
              {
                Provider.of<MainProvider>(context,listen: false).Update(id: task['id'], status: "new");
              },

            ):Container(),
   indexx!=1?
   IconButton(icon: Icon(Icons.check_box,color: Colors.blue,)
          ,
          onPressed: ()
          {


            Provider.of<MainProvider>(context,listen: false).Update(id: task['id'], status: "done");
          },

        ):Container(),
            indexx!=2? IconButton(icon: Icon(Icons.archive,color: Colors.black38,)
              ,
              onPressed: ()
              {
                Provider.of<MainProvider>(context,listen: false).Update(id: task['id'], status: "not important");
              },

            ):Container(),

          ],
        ),
      ),
      onDismissed: (direction)
      {
        Provider.of<MainProvider>(context,listen: false).Delete(id: task['id']);
      },
    ));
