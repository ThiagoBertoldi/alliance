import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var db = FirebaseFirestore.instance;

String nome = '';
String email = '';
String empresa = '';
String cnpj = '';
String telefone = '';
String senha = '';
String senhaNovamente = '';
String permissao = '';
String marca = '';
String preco = '';
String unidadeMedida = '';
int count = 0;
String procuraProduto = '';
var userCredential;
String userName = '';
String userEmail = '';
int i = 0;

String emailRedefinicao = '';
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void gravaNovoUsuario(
  String nome,
  String email,
  String empresa,
  String cnpj,
  String telefone,
  String senha,
  String senhaNovamente,
) async {
  if (nome == '' ||
      email == '' ||
      empresa == '' ||
      telefone == '' ||
      senha == '' ||
      cnpj == '') {
    print("Precisa Preencher Todos os Campos!!");
  } else if (senhaNovamente != senha) {
    print("Senhas não são iguais!!!");
  } else {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: senha);

      var currentUser = FirebaseAuth.instance.currentUser;

      currentUser!.updateDisplayName(nome);
      currentUser.updateEmail(email);

      FirebaseFirestore.instance.collection("vendedor_").doc(nome).set({
        "nome": nome,
        "email": email,
        "empresa": empresa,
        "telefone": telefone,
        "cnpj": cnpj,
        "permissao": "2"
      }).then((value) => "Cadastrado com sucesso");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Senha muito fraca!!!');
      } else if (e.code == 'email-already-in-use') {
        print('Este email já está cadastrado!!!');
      }
    } catch (e) {
      print(e);
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void gravaNovoProduto(String nomeProduto, String marca, String unidadeMedida) {
  if (nomeProduto != '') {
    if (marca == '') {
      marca = '-/-';
    }
    if (unidadeMedida == '') {
      unidadeMedida = '-/-';
    }
    db
        .collection("produtos_")
        .doc(nomeProduto)
        .set({
          "nomeProduto": nomeProduto,
          "marca": marca,
          "precoMaisBaixo": "-/-",
          "precoMaisAlto": "-/-",
          "unidadeMedida": unidadeMedida,
        })
        .then((value) => print("Cadastrado!!!"))
        .catchError((error) => print("Produto não cadastrado: $error"));
  } else {
    print("Algo deu errado, você pode tentar de novo...");
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void deletaProduto(String nomeProduto) {
  db.collection("produtos_").doc(nomeProduto).delete();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void atualizaProduto(String nomeProduto, String unidadeMedida, String marca,
    String precoMaisAlto, String precoMaisBaixo) {
  if (unidadeMedida != '') {
    db
        .collection("produtos_")
        .doc(nomeProduto)
        .update({"unidadeMedida": unidadeMedida}).then(
            (value) => "Alterado com sucesso!");
  }
  if (marca != '') {
    db
        .collection("produtos_")
        .doc(nomeProduto)
        .update({"marca": marca}).then((value) => "Alterado com sucesso!");
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void enviaParaPreCotacao(String nomeProduto) {
  db
      .collection("produtosParaCotacao")
      .doc(nomeProduto)
      .set({"nomeProduto": nomeProduto});
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void enviaParaCotacao() async {
  var prod = await db.collection("produtosParaCotacao").get();

  for (var doc in prod.docs) {
    db
        .collection("produtosEmCotacao")
        .doc(doc['nomeProduto'])
        .set({"nomeProduto": doc['nomeProduto']});
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void reomoveDaPreCotacao(String nomeProduto) {
  db.collection("produtosParaCotacao").doc(nomeProduto).delete();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void resetaCotacao() async {
  var prod = await db.collection("produtosEmCotacao").get();

  for (var doc in prod.docs) {
    db.collection("produtosEmCotacao").doc(doc["nomeProduto"]).delete();
  }

  var prod2 = await db.collection("produtosParaCotacao").get();

  for (var doc in prod2.docs) {
    db.collection("produtosParaCotacao").doc(doc["nomeProduto"]).delete();
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void atualizaDadosRepresentante(
    String empresa, String cnpj, String telefone, String nome) {
  if (empresa != '') {
    db
        .collection("vendedor_")
        .doc(nome)
        .update({"empresa": empresa}).then((value) => "Alterado com sucesso!");
  }

  if (cnpj != '') {
    db
        .collection("vendedor_")
        .doc(nome)
        .update({"cnpj": cnpj}).then((value) => "Alterado com sucesso!");
  }

  if (telefone != '') {
    db.collection("vendedor_").doc(nome).update({"telefone": telefone}).then(
        (value) => "Alterado com sucesso!");
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void deletaUsuario(String nome) {
  db.collection("vendedor_").doc(nome).delete();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void respondeCotacao(String nomeProduto, String preco, String marca,
    String unidadeMedida, var empresa) {
  db.collection("produtosRespondidos").doc(empresa).set({"empresa": empresa});
  if (marca == '') {
    marca = '-/-';
  }
  if (preco == '') {
    preco = '-/-';
  }
  if (unidadeMedida == '') {
    unidadeMedida = '-/-';
  }

  db
      .collection("produtosRespondidos")
      .doc(empresa) //Nome no Vendedor
      .collection("produtos")
      .doc(nomeProduto)
      .set({
    "nomeProduto": nomeProduto,
    "marca": marca,
    "unidadeMedida": unidadeMedida,
    "preço": preco
  }).then((value) => print("Enviada com Sucesso!!!"));
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Future<List> recebeVendedores() async {
  var recebeDados = await db.collection("produtosRespondidos").get();
  List<String> lista = [];

  i = 0;
  for (var dados in recebeDados.docs) {
    lista.add(dados['empresa']);

    print(lista.length);
    print(lista[i]);
    i++;
  }

  return lista;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
