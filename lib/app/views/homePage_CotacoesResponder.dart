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
        primarySwatch: Colors.green,
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
        title: Text(widget.title),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          child: Container(
            margin: new EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.22),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    "Olá, \"%User%\"",
                    style: TextStyle(color: Colors.green, fontSize: 40.0),
                  ),
                ),

                // ignore: deprecated_member_use
                Container(
                  padding: const EdgeInsets.only(top: 30),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    height: MediaQuery.of(context).size.height * 0.08,
                    minWidth: MediaQuery.of(context).size.width * 0.75,
                    child: Text('Pedidos de Cotação',
                        style: TextStyle(color: Colors.white, fontSize: 17)),
                    color: Colors.green,
                    onPressed: () {},
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 10),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    height: MediaQuery.of(context).size.height * 0.08,
                    minWidth: MediaQuery.of(context).size.width * 0.75,
                    child: Text("Dados de '%Empresa%'",
                        style: TextStyle(color: Colors.white, fontSize: 17)),
                    color: Colors.green,
                    onPressed: () {},
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 10),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    height: MediaQuery.of(context).size.height * 0.08,
                    minWidth: MediaQuery.of(context).size.width * 0.75,
                    child: Text('Minhas Informações Cadastrais',
                        style: TextStyle(color: Colors.white, fontSize: 17)),
                    color: Colors.green,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
