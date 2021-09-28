import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/component/component.dart';
import 'package:to_do_app/cubit/cubit.dart';
import 'package:to_do_app/cubit/states.dart';
import 'package:to_do_app/modules/archived%20tasks/archived.dart';
import 'package:to_do_app/modules/done%20tasks/done.dart';
import 'package:to_do_app/modules/new%20tasks/new.dart';

class HomeLayout extends StatelessWidget
{

  List<String> titles=["New Tasks","Done Tasks","Archived Tasks"];
  List<Widget> screens=[
    NewTasks(),
    DoneTasks(),
    ArchivedTasks()];

  var ScaffoldKey= GlobalKey<ScaffoldState>();
  var FormKey= GlobalKey<FormState>();


  var TitleController=TextEditingController();
  var DateController=TextEditingController();
  var TimeController=TextEditingController();





  @override
  Widget build(BuildContext context) {

    return BlocProvider(

      create: (BuildContext context)=> MainCubit()..CreateDatabase(),
      child: BlocConsumer<MainCubit,States>
        (
        listener:(BuildContext context,States state ) {

          print(state);
        },
        builder: (BuildContext context,States state ){

          MainCubit cubit = MainCubit.get(context);

         return    Scaffold(

          key: ScaffoldKey,

          appBar: AppBar(
            title: Text(titles[cubit.index],
              style: TextStyle(

                fontSize:25,

              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: ()
            {


              if(cubit.clickFloating)
              {
                if( FormKey.currentState.validate())
                {
                  cubit.InsertDatabase(title: TitleController.text, date: DateController.text, time: TimeController.text)
                      .then((value)
                  {
                    Navigator.pop(context);

                  });

                }
                else
                {
              /*    setState(() {
                    clickFloating=false;
                  });*/
                  cubit.changeCurrentIndex(false, cubit.index);
                }


              }
              else{




                ScaffoldKey.currentState.showBottomSheet((context) {
                  return Container(
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: FormKey,
                        child: Column(

                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              color: Colors.white,
                              child: defaultFormField(
                                  type: TextInputType.text,
                                  prefix: Icons.title,
                                  label: "Task Title",
                                  controller: TitleController,
                                  validate: (String value)
                                  {
                                    if(value.isEmpty)
                                    {
                                      return "Title must not be empty";
                                    }
                                  }
                              ),
                            ),
                            SizedBox(height: 15,),
                            Container(
                              color: Colors.white,
                              child: defaultFormField(
                                  type: TextInputType.text,
                                  prefix: Icons.watch_later,
                                  label: "Task Time",
                                  controller: TimeController,
                                  onTap: ()
                                  {
                                    showTimePicker(

                                        context: context,
                                        initialTime: TimeOfDay.now()).then((value) {
                                      TimeController.text=value.format(context);
                                    });
                                  },
                                  validate: (String value)
                                  {
                                    if(value.isEmpty)
                                    {
                                      return "Time must not be empty";
                                    }
                                  }
                              ),
                            ),
                            SizedBox(height: 15,),
                            Container(
                              color: Colors.white,
                              child: defaultFormField(
                                  type: TextInputType.text,
                                  prefix: Icons.calendar_today,
                                  label: "Task Date",
                                  controller: DateController,
                                  onTap: ()
                                  {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2022-05-03'),
                                    ).then((value) {
                                      DateController.text = (value.toString()).substring(0,10);
                                    });
                                  },
                                  validate: (String value)
                                  {
                                    if(value.isEmpty)
                                    {
                                      return "Date must not be empty";
                                    }
                                  }

                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                }).closed.then((value) {

                  /*setState(() {
                    clickFloating=false;
                  });*/
                  cubit.changeCurrentIndex(false, cubit.index);
                });
              }
           /*   setState(() {
                clickFloating=!clickFloating;
              });*/
              cubit.changeCurrentIndex(!(cubit.clickFloating), cubit.index);
            },
            child: IconButton(
              icon:Icon(
                cubit.clickFloating ? Icons.add:Icons.edit,
                color:Colors.white,),
            ),
          ),
          body: ConditionalBuilder(
            condition: state is! LoadingState,
            builder: (context) => screens[cubit.index],
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.index,
            onTap: (value){

                cubit.changeCurrentIndex(cubit.clickFloating, value);

            },


            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                title: Text("New Tasks"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline),
                title: Text("Done Tasks"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.archive),
                title: Text("Archived Tasks"),
              ),

            ],
          ),
        );
  }
      ),
    );
  }











}

