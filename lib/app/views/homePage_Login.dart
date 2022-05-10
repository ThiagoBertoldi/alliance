import 'package:alliance/app/HomePage_Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../googleLogin/google.sign_in.dart';

// ignore: camel_case_types
class HomePage_Login extends StatefulWidget {
  HomePage_Login({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState_Login createState() => _MyHomePageState_Login();
}

// ignore: camel_case_types
class _MyHomePageState_Login extends State<HomePage_Login> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var appBar = AppBar(
      backgroundColor: Colors.orange,
      elevation: 0,
      automaticallyImplyLeading: false,
    );

    var screenHeight = (height - appBar.preferredSize.height) -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: Center(
          child: Container(
        width: width,
        height: screenHeight,
        child: Column(
          children: [
            Container(
              width: width,
              height: screenHeight * 0.29,
              child: Material(
                child: Container(
                    width: width,
                    height: screenHeight * 0.29,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: 20, left: 20, right: 100, bottom: 10),
                          child: Text("Panificadora",
                              style: TextStyle(
                                fontSize: 43,
                                color: Colors.white,
                              )),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            right: 50,
                          ),
                          child: Text("Aliança",
                              style: TextStyle(
                                fontSize: 43,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0, color: Colors.orange),
                      color: Colors.orange,
                      borderRadius: BorderRadius.only(
                          bottomLeft: const Radius.circular(85),
                          bottomRight: const Radius.circular(85)),
                    )),
              ),
            ),
            Container(
              width: width,
              height: screenHeight * .66,
              child: Container(
                width: width * .9,
                height: screenHeight * .66,
                child: Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: width * .55,
                    height: screenHeight * .08,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            primary: Colors.orange,
                            onPrimary: Colors.white),
                        onPressed: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.googleLogin().then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      HomePage_Home(title: "ALLIANCE"))));
                        },
                        child: Text(
                          "Entrar com Google",
                        )),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Container(
                  width: width,
                  height: screenHeight * 0.05,
                  decoration: new BoxDecoration(
                    border: Border.all(width: 0, color: Colors.orange),
                    color: Colors.orange,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(25),
                        topRight: const Radius.circular(25)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.copyright,
                        size: 15,
                        color: Colors.white,
                      ),
                      Text("2022 Panificadora e Confeitaria Aliança LTDA",
                          style: TextStyle(
                            color: Colors.white,
                          ))
                    ],
                  )),
            ),
          ],
        ),
      )),
    );
  }
}
