// ignore: camel_case_types

import 'package:alliance/app/views/homePage_Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaginaLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterApp',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage_Login(
        title: 'ALLIANCE',
      ),
    );
  }
}
