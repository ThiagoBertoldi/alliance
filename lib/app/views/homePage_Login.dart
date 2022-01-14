import 'package:alliance/app/HomePage_Home.dart';
import 'package:alliance/app/teste_login/google.sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            Material(
              elevation: 7,
              borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(125.0),
              ),
              child: Container(
                  width: width,
                  height: screenHeight * 0.29,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Text("ALLIANCE",
                            style: TextStyle(
                              fontSize: 45,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                  decoration: new BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(125.0),
                    ),
                  )),
            ),
            Container(
              width: width * 0.6,
              height: screenHeight * 0.07,
              margin: EdgeInsets.only(top: screenHeight * 0.25),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5))),
                      primary: Colors.orange,
                      onPrimary: Colors.white),
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
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
            Container(
                width: width,
                height: screenHeight * 0.05,
                color: Colors.orange,
                margin: EdgeInsets.only(top: screenHeight * 0.34),
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
                ))
          ],
        ),
      )),
    );
  }
}
