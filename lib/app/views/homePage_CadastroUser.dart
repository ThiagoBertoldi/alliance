// ignore: unused_import
import 'package:alliance/app/views/homePage_Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../paginaLogin.dart';

// ignore: camel_case_types
class HomePage_Cadastro extends StatefulWidget {
  HomePage_Cadastro({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage_Cadastro> {
  String nome = '';
  String email = '';
  String empresa = '';
  String cnpj = '';
  String tel = '';
  int telefone = 0;
  String senha = '';
  String senhaNovamente = '';
  int permissao = 0;

  void gravaDados(String nome, String email, String empresa, String cnpj,
      int telefone, String senha, String senhaNovamente, int permissao) {
    if (nome == '' ||
        email == '' ||
        empresa == '' ||
        telefone == 0 ||
        senha == '' ||
        cnpj == '') {
      print("Precisa Preencher Todos os Campos!!");
    } else if (senhaNovamente != senha) {
      print("Senhas não são iguais!!!");
    } else {
      FirebaseFirestore.instance.collection("users_").doc("$nome").set({
        "nome": "$nome",
        "email": "$email",
        "empresa": "$empresa",
        "telefone": "$telefone",
        "cnpj": "$cnpj",
        "senha": "$senha",
        "senhaNovamente": "$senhaNovamente",
        "permissao": "$permissao"
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: new EdgeInsets.only(
              left: 50.0,
              right: 50.0,
              top: MediaQuery.of(context).size.height * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: new EdgeInsets.all(15),
                child: Text(
                  "Cadastro de Usuário",
                  style: TextStyle(fontSize: 30, color: Colors.orange),
                ),
              ),
              TextFormField(
                onChanged: (text) {
                  nome = text;
                },
                decoration: InputDecoration(
                  labelText: 'Nome Completo',
                  icon: Icon(Icons.person),
                ),
              ),
              TextFormField(
                onChanged: (text) {
                  email = text;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  icon: Icon(Icons.email),
                ),
              ),
              TextFormField(
                onChanged: (text) {
                  empresa = text;
                },
                decoration: InputDecoration(
                  labelText: 'Empresa',
                  icon: Icon(Icons.business),
                ),
              ),
              TextFormField(
                onChanged: (text) {
                  cnpj = text;
                },
                decoration: InputDecoration(
                  labelText: 'CNPJ',
                  icon: Icon(Icons.document_scanner),
                ),
              ),
              TextFormField(
                onChanged: (text) {
                  tel = text;
                  telefone = int.parse(tel);
                },
                decoration: InputDecoration(
                  labelText: 'Telefone',
                  icon: Icon(Icons.phone_android),
                ),
              ),
              TextFormField(
                onChanged: (text) {
                  senha = text;
                },
                autofocus: true,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  icon: Icon(Icons.password),
                ),
              ),
              TextFormField(
                onChanged: (text) {
                  senhaNovamente = text;
                },
                autofocus: true,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha Novamente',
                  icon: Icon(Icons.password),
                ),
              ),
              Container(
                margin: new EdgeInsets.only(top: 30),
                // ignore: deprecated_member_use
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  height: MediaQuery.of(context).size.height * 0.07,
                  minWidth: MediaQuery.of(context).size.width * 0.6,
                  child:
                      Text('Cadastrar', style: TextStyle(color: Colors.white)),
                  color: Colors.orange,
                  onPressed: () {
                    gravaDados(nome, email, empresa, cnpj, telefone, senha,
                        senhaNovamente, 2);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => PaginaLogin()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
