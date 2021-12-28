import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'HomeLayout/homelayout.dart';
import 'Provider/provider.dart';

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