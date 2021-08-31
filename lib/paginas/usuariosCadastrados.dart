import 'package:alliance/views/userList.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(UsuariosCadastrados());
}

// ignore: camel_case_types
class UsuariosCadastrados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterApp',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: UserList(),
    );
  }
}
