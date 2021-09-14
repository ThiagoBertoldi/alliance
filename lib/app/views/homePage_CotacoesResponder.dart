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
      body: ListView(),
    );
  }
}
