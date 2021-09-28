
import 'package:flutter/material.dart';
import 'package:to_do_app/cubit/cubit.dart';

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

    )
=>

    Dismissible(
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
        IconButton(icon: Icon(Icons.check_box,color: Colors.blue,)
          ,
          onPressed: ()
          {
            MainCubit.get(context).Update(id: task['id'], status: "done");

          },

        ),
            IconButton(icon: Icon(Icons.archive,color: Colors.black38,)
              ,
              onPressed: ()
              {
                MainCubit.get(context).Update(id: task['id'], status: "archived");
              },

            ),
          ],
        ),
      ),
      onDismissed: (direction)
      {
        MainCubit.get(context).Delete(id: task['id']);
      },
    );