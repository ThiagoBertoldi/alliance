import 'package:flutter/material.dart';

main() {
  runApp(PaginaVendedor());
}

class PaginaVendedor extends StatelessWidget {
  // This widget is the root of your application.
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
          Container(
            padding: new EdgeInsets.all(30),
            child: Center(
              child: Text("Cotações para Responder",
                  style: TextStyle(fontSize: 30, color: Colors.orange[300])),
            ),
          ),
          Container(
            child: new InkWell(
              onTap: () {},
              child: Card(
                color: Colors.white,
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                    right: MediaQuery.of(context).size.width * 0.04,
                    left: MediaQuery.of(context).size.width * 0.04,
                    bottom: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                              child: Text("Produto ",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold))),
                          Text('Enviado em',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: new EdgeInsets.only(left: 5, top: 7),
                              child: Text("35 Produtos para responder",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Container(
                            child: Container(
                                padding: new EdgeInsets.only(top: 5),
                                child: Text('14/09/2021',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red))),
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
            padding: new EdgeInsets.all(30),
            child: Center(
              child: Text("Cotações Respondidas",
                  style: TextStyle(fontSize: 30, color: Colors.orange[300])),
            ),
          ),
          for (int i = 0; i < 10; i++)
            Container(
              child: new InkWell(
                onTap: () {},
                child: Card(
                  color: Colors.white,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.width * 0.04,
                      left: MediaQuery.of(context).size.width * 0.04,
                      bottom: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                                child: Text("Produto ",
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold))),
                            Text('Enviado em',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: new EdgeInsets.only(left: 5, top: 7),
                                child: Text("35 Produtos para responder",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Container(
                              child: Container(
                                  padding: new EdgeInsets.only(top: 5),
                                  child: Text('14/09/2021',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
