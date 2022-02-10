import 'package:alliance/app/views/homePage_Login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'googleLogin/google.sign_in.dart';

class PaginaLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),
          home: HomePage_Login(
            title: "Alliance",
          )));
}
