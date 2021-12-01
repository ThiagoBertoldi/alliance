import 'package:flutter/material.dart';
import 'homePage_RespondeCotacao.dart';

class PaginaVendedor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterApp',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage_CotacoesResponder(title: 'Flutter App'),
    );
  }
}

// ignore: camel_case_types
class HomePage_CotacoesResponder extends StatefulWidget {
  HomePage_CotacoesResponder({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage_CotacoesResponder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title, style: TextStyle(color: Colors.white)),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                  margin: new EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.13,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomePageState_ResponderCotacao(
                                      title: "ALLIANCE")));
                    },
                    child: Card(
                      child: Container(
                        padding: new EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text("Cotação Semanal",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Colors.black.withOpacity(0.8))),
                                ),
                                Container(
                                  child: Text("02/10/2021",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Colors.black.withOpacity(0.8))),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text("Expira em",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Colors.black.withOpacity(0.5))),
                                ),
                                Container(
                                  child: Text("--/--",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Colors.black.withOpacity(0.5))),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    padding: new EdgeInsets.all(20),
                    child: Text("Cotações Passadas",
                        style: TextStyle(fontSize: 25, color: Colors.orange))),
                for (int i = 0; i < 10; i++)
                  Container(
                    margin: new EdgeInsets.only(top: 5),
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.13,
                    child: Card(
                      child: Container(
                        padding: new EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text("Cotação Semanal",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Colors.black.withOpacity(0.8))),
                                ),
                                Container(
                                  child: Text("02/10/2021",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Colors.black.withOpacity(0.8))),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text("Expira em",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Colors.black.withOpacity(0.5))),
                                ),
                                Container(
                                  child: Text("--/--",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Colors.black.withOpacity(0.5))),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            )
          ],
        ));
  }
}
