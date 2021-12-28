import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/cubit/cubit.dart';

import 'HomeLayout/homelayout.dart';
import 'model/task_model.dart';

const String todoBoxName = "todo";

void main()  {



  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<MainProvider>(
      create: (_)=>MainProvider()..CreateDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeLayout(),

      ),
    );
  }
}