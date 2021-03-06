import 'package:alliance/app/views/viewsCliente/homePage_MenuCliente.dart';
import 'package:alliance/firebase_script/ordenadorDePrecos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var db = FirebaseFirestore.instance;

String nome = '';
String email = '';
String empresa = '';
String idToken = '';
String marca = '';
String preco = '';
String unidadeMedida = '';
String procuraProduto = '';
String cotacaoSelecionada = '';
String nomeProduto = '';
String senhaAcessoApp = '';
String novoNomeProduto = '';
String tipoUsuario = '';
String tipoProduto = '';
String compraAntigaSelecionada = '';
String quantidadeDeCompra = '';
String unidadeMedidaComprarDe = 'Outro';

final DateTime date = DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm');
final String dateFormatted = formatter.format(date);

Future<void> erroLogin(BuildContext context) async {
  AlertDialog widget = AlertDialog(
      content: Container(
    width: MediaQuery.of(context).size.width * .8,
    height: MediaQuery.of(context).size.height * .1,
    child: Column(
      children: [
        Center(
          child: Text(
            "Algo de errado!",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Text("Reinicie o app e tente novamente..."),
        )
      ],
    ),
  ));

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return widget;
      });
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void gravaNovoProduto(String nomeProduto, String tipoProduto) {
  if (nomeProduto != '' || tipoProduto != '') {
    db
        .collection("produtos_")
        .doc(nomeProduto)
        .set({
          "nomeProduto": nomeProduto,
          "precoMaisBaixo": "-/-",
          "precoMaisAlto": "-/-",
          "tipoProduto": tipoProduto,
          "empresaPrecoAlto": "-/-",
          "empresaPrecoBaixo": "-/-"
        })
        .then((value) => db.collection("bkpProdutos_").doc(nomeProduto).set({
              "nomeProduto": nomeProduto,
              "precoMaisBaixo": "-/-",
              "precoMaisAlto": "-/-",
              "tipoProduto": tipoProduto,
              "empresaPrecoAlto": "-/-",
              "empresaPrecoBaixo": "-/-"
            }))
        .onError((error, stackTrace) => print("Erro ao cadastrar produto: " +
            nomeProduto +
            " || " +
            error.toString()));
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void deletaProduto(String nomeProduto) async {
  try {
    var query = await db
        .collection("precoAtualProduto")
        .doc(nomeProduto)
        .collection("empresas")
        .get();

    for (var doc in query.docs) {
      await db
          .collection("precoAtualProduto")
          .doc(nomeProduto)
          .collection("empresas")
          .doc(doc['empresa'])
          .delete();
    }

    await db
        .collection("precoAtualProduto")
        .doc(nomeProduto)
        .delete()
        .then((value) => print("Produto deletado dos pre??os atuais"))
        .onError((error, stackTrace) => print(
            "Produto n??o deletado de \"precoAtualProduto\": " +
                nomeProduto +
                " || " +
                error.toString()));

    await db
        .collection("produtosEmCotacao")
        .doc(nomeProduto)
        .delete()
        .then((value) => print("Produto deletado da cota????o"))
        .onError((error, stackTrace) => print(
            "Erro ao deletar produto de \"produtosEmCotacao\": " +
                nomeProduto +
                " || " +
                error.toString()));

    await db
        .collection("produtosParaCotacao")
        .doc(nomeProduto)
        .delete()
        .then((value) => print("Produto deletado da pr??-cota????o"))
        .onError((error, stackTrace) => print(
            "Erro ao deletar produto de \"produtosParaCotacao\": " +
                nomeProduto +
                " || " +
                error.toString()));

    await db
        .collection("produtos_")
        .doc(nomeProduto)
        .delete()
        .then((value) => print("Produto Deletado"))
        .onError((error, stackTrace) => print(
            "Erro ao deletar produto de \"produtos_\": " +
                nomeProduto +
                " || " +
                error.toString()));
  } catch (error) {
    print("N??o foi poss??vel deletar -> " + error.toString());
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void editaNomeProduto(
    String nomeProduto,
    String novoNome,
    String precoMaisAlto,
    String precoMaisBaixo,
    String tipoProduto,
    String empresaPrecoAlto,
    String empresaPrecoBaixo,
    BuildContext context) async {
  if (novoNome == '' || novoNome == nomeProduto) {
    return;
  }

  await db.collection("produtos_").doc(novoNome).set({
    "nomeProduto": novoNome,
    "precoMaisAlto": precoMaisAlto,
    "precoMaisBaixo": precoMaisBaixo,
    "tipoProduto": tipoProduto,
    "empresaPrecoAlto": empresaPrecoAlto,
    "empresaPrecoBaixo": empresaPrecoBaixo
  }).then((value) async => await db
      .collection("produtos_")
      .doc(nomeProduto)
      .delete()
      .then((value) => print("Nome alterado"))
      .onError((error, stackTrace) => print("Nome n??o alterado")));

  print("Altera????o de nome realizada...");

  novoNome = '';
  novoNomeProduto = '';
}

Future<void> showDialogAlteraNomeProduto(
    String nomeProduto,
    String precoMaisAlto,
    String precoMaisBaixo,
    String tipoProduto,
    String empresaPrecoAlto,
    String empresaPrecoBaixo,
    BuildContext context) async {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.35,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text("Qual o novo nome?",
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      nomeProduto,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 25),
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: TextFormField(
                    initialValue: nomeProduto,
                    onChanged: (text) {
                      novoNomeProduto = text;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5))),
                        icon: Icon(Icons.fastfood),
                        hintText: 'Novo Nome'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5))),
                        primary: Colors.orange,
                        onPrimary: Colors.white),
                    onPressed: () {
                      editaNomeProduto(
                          nomeProduto,
                          novoNomeProduto,
                          precoMaisAlto,
                          precoMaisBaixo,
                          tipoProduto,
                          empresaPrecoAlto,
                          empresaPrecoBaixo,
                          context);

                      Navigator.of(context).pop();
                    },
                    child: Text("Salvar"),
                  ),
                )
              ],
            ),
          ),
        );
      });
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

insereNaCotacao(String nomeProduto, String tipoProduto) async {
  await db
      .collection("produtosEmCotacao")
      .doc(nomeProduto)
      .set({"nomeProduto": nomeProduto, "tipoProduto": tipoProduto})
      .then((value) => print(nomeProduto + " inserido na cota????o"))
      .onError((error, stackTrace) => print("Erro ao inserir " +
          nomeProduto +
          " na cota????o: " +
          error.toString()));
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void enviaParaPreCotacao(String nomeProduto, String tipoProduto) async {
  await db
      .collection("produtosParaCotacao")
      .doc(nomeProduto)
      .set({"nomeProduto": nomeProduto, "tipoProduto": tipoProduto})
      .then((value) => print("Colocado em pr??-cota????o"))
      .onError((error, stackTrace) => print(
          nomeProduto + " n??o inserido na pr??-cota????o: " + error.toString()));
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Future<int> enviaTudoParaPreCotacao() async {
  print("Iniciando envio de produtos para pre cotacao...");
  var query = await db.collection("produtos_").get();

  for (var doc in query.docs) {
    await db
        .collection("produtosParaCotacao")
        .doc(doc['nomeProduto'])
        .set({
          "nomeProduto": doc['nomeProduto'],
          "tipoProduto": doc['tipoProduto']
        })
        .then(
            (value) => print("Enviado para pr??-cota????o: " + doc['nomeProduto']))
        .onError((error, stackTrace) => print(doc['nomeProduto'] +
            " n??o enviado para pr??-cota????o: " +
            error.toString()));
  }
  print("Terminando envio de produtos para pre cotacao...");
  return 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Future<void> widgetEnviaTudoParaCotacao(BuildContext context) async {
  AlertDialog loadingEnviaParaPreCotacao = AlertDialog(
    content: Container(
        width: MediaQuery.of(context).size.width * .8,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(
              future: enviaTudoParaPreCotacao(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: Text("Produtos colocados em pr??-cota????o!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19))),
                      Center(
                          child: Text("Toque para fechar",
                              style: TextStyle(fontSize: 16))),
                      Container(
                        width: MediaQuery.of(context).size.width * .8,
                        height: MediaQuery.of(context).size.height * .08,
                        margin: EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "Fechar",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            )),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("Algo deu errado...");
                } else {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: Text("Enviando produtos...",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19))),
                      Center(
                        child: Container(
                            margin: EdgeInsets.only(bottom: 15),
                            child: Text("Aguarde")),
                      ),
                      Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          child: CircularProgressIndicator()),
                    ],
                  ));
                }
              },
            ),
          ],
        )),
  );

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return loadingEnviaParaPreCotacao;
    },
  );
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void deletaPrecosAtuaisProdutos() async {
  var deletaPrecoAtual = await db.collection("precoAtualProduto").get();
  for (var doc in deletaPrecoAtual.docs) {
    var recebeEmpresasPrecoAtualProduto = await db
        .collection("precoAtualProduto")
        .doc(doc['nomeProduto'])
        .collection("empresas")
        .get();
    for (var doc2 in recebeEmpresasPrecoAtualProduto.docs) {
      await db
          .collection("precoAtualProduto")
          .doc(doc['nomeProduto'])
          .collection("empresas")
          .doc(doc2['empresa'])
          .delete()
          .then((value) => db
              .collection("precoAtualProduto")
              .doc(doc['nomeProduto'])
              .delete());
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Future<int> enviaParaCotacao() async {
  var produtoEmPreCotacao = await db.collection("produtosParaCotacao").get();
  var produtoEmCotacaoAntiga = await db.collection("produtosEmCotacao").get();
  var produtosRespondidos = await db.collection("produtosRespondidos").get();
  var produtosRespondidosModal =
      await db.collection("produtosRespondidosModal").get();
  var deletaPrecosProdutos = await db.collection("produtos_").get();
  var comprarDe = await db.collection("comprarDe").get();
  var produtosRespondidoss = await db.collection("produtosRespondidoss").get();

  gravaCotacoesAntigas();

  deletaPrecosAtuaisProdutos();

  for (var doc2 in produtosRespondidos.docs) {
    var query = await db
        .collection("produtosRespondidos")
        .doc(doc2['empresa'])
        .collection("produtos")
        .get();
    for (var doc in query.docs) {
      await db
          .collection("produtosRespondidos")
          .doc(doc2['empresa'])
          .collection("produtos")
          .doc(doc['nomeProduto'])
          .delete()
          .then((value) =>
              print("Produto deletado da tabela \"produtosRespondidos\"!"));
    }
  }

  for (var doc in produtosRespondidos.docs) {
    await db.collection("produtosRespondidos").doc(doc['empresa']).delete();
  }

  for (var doc3 in produtosRespondidosModal.docs) {
    var query = await db
        .collection("produtosRespondidosModal")
        .doc(doc3['empresa'])
        .collection("produtos")
        .get();

    for (var doc in query.docs) {
      await db
          .collection("produtosRespondidosModal")
          .doc(doc3['empresa'])
          .collection("produtos")
          .doc(doc['nomeProduto'])
          .delete();
    }
  }

  for (var doc in produtosRespondidosModal.docs) {
    await db
        .collection("produtosRespondidosModal")
        .doc(doc['empresa'])
        .delete();
  }

  for (var doc4 in deletaPrecosProdutos.docs) {
    await db.collection("produtos_").doc(doc4['nomeProduto']).update({
      "precoMaisAlto": "0.00",
      "precoMaisBaixo": "0.00",
      "empresaPrecoAlto": "-/-",
      "empresaPrecoBaixo": "-/-"
    });
  }
  for (var doc in produtoEmCotacaoAntiga.docs) {
    await db.collection("produtosEmCotacao").doc(doc['nomeProduto']).delete();
  }
  for (var doc in produtoEmPreCotacao.docs) {
    await db.collection("produtosEmCotacao").doc(doc['nomeProduto']).set({
      "nomeProduto": doc['nomeProduto'],
      "tipoProduto": doc['tipoProduto']
    }).then((value) => print("Produto enviado para cota????o!!!"));

    await db.collection("produtosParaCotacao").doc(doc['nomeProduto']).delete();
  }

  for (var doc in comprarDe.docs) {
    await db
        .collection("comprasPassadas")
        .doc(dateFormatted)
        .set({"dataHora": dateFormatted});
    await db
        .collection("comprasPassadas")
        .doc(dateFormatted)
        .collection("empresas")
        .doc(doc['empresa'])
        .set({"empresa": doc['empresa']});

    var query2 = await db
        .collection("comprarDe")
        .doc(doc['empresa'])
        .collection("produtos")
        .get();
    for (var doc2 in query2.docs) {
      await db
          .collection("comprasPassadas")
          .doc(dateFormatted)
          .collection("empresas")
          .doc(doc['empresa'])
          .collection("produtos")
          .doc(doc2['nomeProduto'])
          .set({
        "nomeProduto": doc2['nomeProduto'],
        "empresa": doc2['empresa'],
        "pre??o": doc2['pre??o']
      });

      await db
          .collection("comprarDe")
          .doc(doc['empresa'])
          .collection("produtos")
          .doc(doc2['nomeProduto'])
          .delete()
          .then((value) async =>
              await db.collection("comprarDe").doc(doc['empresa']).delete());
    }
  }

  for (var doc in produtosRespondidoss.docs) {
    var query = await db
        .collection("produtosRespondidoss")
        .doc(doc['nomeProduto'])
        .collection("empresas")
        .get();
    for (var doc in query.docs) {
      await db
          .collection("bKPCotacoesPassadas")
          .doc(dateFormatted)
          .set({"data": dateFormatted}).then((value) async => await db
              .collection("bKPCotacoesPassadas")
              .doc(dateFormatted)
              .collection("bKPCotacoesPassadas")
              .doc(doc['nomeProduto'])
              .set({'nomeProduto': doc['nomeProduto']})
              .then((value) async => await db
                      .collection("bKPCotacoesPassadas")
                      .doc(dateFormatted)
                      .collection("bKPCotacoesPassadas")
                      .doc(doc['nomeProduto'])
                      .collection("empresas")
                      .doc(doc['empresa'])
                      .set({
                    "empresa": doc['empresa'],
                    "marca": doc['marca'],
                    "nomeProduto": doc['nomeProduto'],
                    "pre??o": doc['pre??o'],
                    "unidadeMedida": doc['unidadeMedida']
                  }))
              .then((value) async => await db
                  .collection("produtosRespondidoss")
                  .doc(doc['nomeProduto'])
                  .collection("empresas")
                  .doc(doc['empresa'])
                  .delete()
                  .then((value) async => await db
                      .collection("produtosRespondidoss")
                      .doc(doc['nomeProduto'])
                      .delete())));
    }
  }

  return 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Future<void> widgetEnviaParaCotacao(BuildContext context) async {
  AlertDialog widget = AlertDialog(
    content: Container(
      width: MediaQuery.of(context).size.width * .8,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
              future: enviaParaCotacao(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Center(
                        child: Text("Produtos enviados para cota????o!",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Center(
                        child: Text("Toque para fechar"),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .8,
                        height: MediaQuery.of(context).size.height * .08,
                        margin: EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "Fechar",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            )),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("Algo deu Errado");
                } else {
                  return Center(
                      child: Column(
                    children: [
                      Center(
                          child: Text("Enviando para cota????o...",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19))),
                      Center(
                        child: Container(
                            margin: EdgeInsets.only(bottom: 15),
                            child: Text("Aguarde")),
                      ),
                      Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          child: CircularProgressIndicator()),
                    ],
                  ));
                }
              })
        ],
      ),
    ),
  );

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return widget;
      });
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void gravaCotacoesAntigas() async {
  List lista = [];

  var produtosRespondidos = await db.collection("produtosRespondidos").get();

  for (var doc in produtosRespondidos.docs) {
    lista.add(doc['empresa']);
  }
  db
      .collection("cotacoesPassadas")
      .doc("$dateFormatted")
      .set({"dataHora": dateFormatted}).then(
          (value) => print("Documento criado no FireBase: " + dateFormatted));
  for (int i = 0; i < lista.length; i++) {
    var recebeDados = await db
        .collection("produtosRespondidos")
        .doc(lista[i])
        .collection("produtos")
        .get();

    for (var doc in recebeDados.docs) {
      db
          .collection("produtosRespondidos")
          .doc(lista[i])
          .collection("produtos")
          .doc(doc['nomeProduto'])
          .delete();
      db
          .collection("cotacoesPassadas")
          .doc("$dateFormatted")
          .collection("empresas")
          .doc(doc['empresa'])
          .set({"empresa": doc['empresa']});
      db
          .collection("cotacoesPassadas")
          .doc("$dateFormatted")
          .collection("empresas")
          .doc(doc['empresa'])
          .collection("produtos")
          .doc(doc['nomeProduto'])
          .set({
        "nomeProduto": doc['nomeProduto'],
        "empresa": doc['empresa'],
        "marca": doc['marca'],
        "pre??o": doc['pre??o'],
        "unidadeMedida": doc['unidadeMedida']
      });
    }
  }

  print("Pr??-cota????o grvada como: " + dateFormatted);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void removeDaPreCotacao(String nomeProduto) async {
  await db.collection("produtosParaCotacao").doc(nomeProduto).delete();
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
Future<void> respondeCotacao(String nomeProduto, String preco, String marca,
    String unidadeMedida, var empresa, BuildContext context) async {
  if (marca == '') {
    marca = '-/-';
  }
  if (preco == '' ||
      preco == "0.00" ||
      preco == "0,00" ||
      double.parse(preco) == 0.00) {
    AlertDialog alertPrecoInvalido = AlertDialog(
      title: Text("Aviso"),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text("Pre??o inv??lido,"),
                Text(
                  nomeProduto + " n??o gravado",
                ),
                Text("Tente novamente")
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text("Exemplo para formata????o de pre??o: "),
                  Text("1.23", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            )
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertPrecoInvalido;
      },
    );
    return;
  }
  if (unidadeMedida == '') {
    unidadeMedida = '-/-';
  }

  if (empresa == '') {
    return;
  }

  await db
      .collection("precoAtualProduto")
      .doc(nomeProduto)
      .set({"nomeProduto": nomeProduto});
  await db
      .collection("precoAtualProduto")
      .doc(nomeProduto)
      .collection("empresas")
      .doc(empresa)
      .set({"nomeProduto": nomeProduto, "pre??o": preco, "empresa": empresa})
      .then((value) => print("Pre??o Atual Criado!!!"))
      .onError((error, stackTrace) => db
          .collection("logErros")
          .doc("respondeCotacao")
          .collection("errors")
          .doc(dateFormatted)
          .set({"precoAtualProduto": error.toString(), "hora": dateFormatted}));

  await db
      .collection("produtosRespondidosModal")
      .doc(empresa)
      .set({"empresa": empresa});
  await db
      .collection("produtosRespondidosModal")
      .doc(empresa)
      .collection("produtos")
      .doc(nomeProduto)
      .set({
        "nomeProduto": nomeProduto,
        "marca": marca,
        "unidadeMedida": unidadeMedida,
        "pre??o": preco,
        "empresa": empresa
      })
      .then((value) => print("Informa????es Modal OK!!!"))
      .onError((error, stackTrace) => db
              .collection("logErros")
              .doc("respondeCotacao")
              .collection("errors")
              .doc(dateFormatted)
              .set({
            "produtosRespondidosModal": error.toString(),
            "hora": dateFormatted
          }));

  await db
      .collection("produtosRespondidoss")
      .doc(nomeProduto)
      .set({"nomeProduto": nomeProduto})
      .then((value) => db
              .collection("produtosRespondidoss")
              .doc(nomeProduto)
              .collection("empresas")
              .doc(empresa)
              .set({
            "nomeProduto": nomeProduto,
            "marca": marca,
            "unidadeMedida": unidadeMedida,
            "pre??o": preco,
            "empresa": empresa
          }))
      .onError((error, stackTrace) => db
          .collection("logErros")
          .doc("respondeCotacao")
          .collection("errors")
          .doc(error.toString())
          .set({"erro": error.toString(), "hora": dateFormatted}));

  await db
      .collection("produtosRespondidos")
      .doc(empresa)
      .set({"empresa": empresa});
  await db
      .collection("produtosRespondidos")
      .doc(empresa)
      .collection("produtos")
      .doc(nomeProduto)
      .set({
        "nomeProduto": nomeProduto,
        "marca": marca,
        "unidadeMedida": unidadeMedida,
        "pre??o": preco,
        "empresa": empresa
      })
      .then((value) => print("Enviada com Sucesso!!!"))
      .onError((error, stackTrace) => db
          .collection("logErros")
          .doc("respondeCotacao")
          .collection("errors")
          .doc(error.toString())
          .set({"erro": error.toString(), "hora": dateFormatted}));
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////

Future<int> calculaPrecos() async {
  print("Iniciando compara????o de pre??os dos produtos...");
  var produtos = await db.collection("precoAtualProduto").get();
  int countLog = 0;
  List<Ordenador> listaOrdenador = [];

  for (var doc1 in produtos.docs) {
    var produtos2 = await db
        .collection("precoAtualProduto")
        .doc(doc1['nomeProduto'])
        .collection("empresas")
        .get();
    for (var doc2 in produtos2.docs) {
      if (doc2['pre??o'] == '' || doc2['pre??o'] == 0) {
        print("Sem pre??o cadastrado");
        continue;
      } else {
        listaOrdenador
            .add(Ordenador(doc2['empresa'], double.parse(doc2['pre??o'])));
      }
    }

    listaOrdenador.sort((a, b) => a.getPreco().compareTo(b.getPreco()));

    if (listaOrdenador.isEmpty) {
      print("Lista vazia");
      continue;
    } else if (listaOrdenador.length < 2 && listaOrdenador.length > 0) {
      await db
          .collection('produtos_')
          .doc(doc1['nomeProduto'])
          .update({
            'precoMaisBaixo': listaOrdenador.first.getPreco().toString(),
            'empresaPrecoBaixo': listaOrdenador.first.getEmpresa(),
            'empresaPrecoAlto': "-/-"
          })
          .then((value) =>
              print("Pre??o ??nico setado para: " + doc1['nomeProduto']))
          .onError((error, stackTrace) => db
              .collection("logErros")
              .doc("calculaPrecos")
              .collection("errors")
              .doc(dateFormatted)
              .set(
                  {"setaPrecoUnico": error.toString(), "hora": dateFormatted}));
      countLog++;
    } else if (listaOrdenador.length >= 2) {
      await db
          .collection('produtos_')
          .doc(doc1['nomeProduto'])
          .update({
            'precoMaisAlto': listaOrdenador.last.getPreco().toString(),
            'empresaPrecoAlto': listaOrdenador.last.getEmpresa()
          })
          .then((value) =>
              print("Maior pre??o setado para: " + doc1['nomeProduto']))
          .onError((error, stackTrace) => db
              .collection("logErros")
              .doc("calculaPrecos")
              .collection("errors")
              .doc(dateFormatted)
              .set(
                  {"setaMaiorPreco": error.toString(), "hora": dateFormatted}));
      await db
          .collection('produtos_')
          .doc(doc1['nomeProduto'])
          .update({
            'precoMaisBaixo': listaOrdenador.first.getPreco().toString(),
            'empresaPrecoBaixo': listaOrdenador.first.getEmpresa()
          })
          .then((value) =>
              print("Menor pre??o setado para: " + doc1['nomeProduto']))
          .onError((error, stackTrace) => db
              .collection("logErros")
              .doc("calculaPrecos")
              .collection("errors")
              .doc(dateFormatted)
              .set(
                  {"setaMenorPreco": error.toString(), "hora": dateFormatted}));
      countLog += 2;
    } else {
      continue;
    }

    listaOrdenador.clear();
  }
  await db
      .collection("logBD")
      .doc("setaPrecos")
      .set({"nome": "setaPrecos"}).then((value) => db
          .collection("logBD")
          .doc("setaPrecos")
          .collection("contadores")
          .doc(dateFormatted)
          .set({"hora": dateFormatted, "produtosVerificados": countLog})
          .then((value) => print("logDB gerado para \"calculaPrecos()\""))
          .onError((error, stackTrace) => db
              .collection("logErros")
              .doc("calculaPrecos")
              .collection("errors")
              .doc(dateFormatted)
              .set({"logDB": error.toString(), "hora": dateFormatted})));

  print("Compara????o de pre??os de produtos terminada...");
  return 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

Future<void> widgetCalculaPrecos(BuildContext context) async {
  AlertDialog loadingCalculaPrecos = AlertDialog(
    content: Container(
        width: MediaQuery.of(context).size.width * .8,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(
              future: calculaPrecos(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: Text("Pre??os Comparados!!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19))),
                      Center(
                          child: Text("Clique para entrar",
                              style: TextStyle(fontSize: 16))),
                      Container(
                        width: MediaQuery.of(context).size.width * .8,
                        height: MediaQuery.of(context).size.height * .08,
                        margin: EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MenuCliente_State(title: "ALLIANCE"))),
                            child: Text(
                              "Entrar",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            )),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("Algo deu errado...");
                } else {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: Text("Calculando Pre??os...",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19))),
                      Center(
                        child: Container(
                            margin: EdgeInsets.only(bottom: 15),
                            child: Text("Aguarde")),
                      ),
                      Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          child: CircularProgressIndicator()),
                    ],
                  ));
                }
              },
            ),
          ],
        )),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return loadingCalculaPrecos;
    },
  );
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Future<void> enviarTodosOsProdutos(BuildContext context) async {
  return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            child: Container(
                width: MediaQuery.of(context).size.width * .8,
                height: MediaQuery.of(context).size.height * .35,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Aten????o, voc?? enviar?? todos ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                      Text(
                        "os produtos para pr??-cota????o!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          "Prosseguir?",
                          style: TextStyle(fontSize: 19),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * .20,
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      await widgetEnviaTudoParaCotacao(context);
                                      Navigator.pop(context);
                                    },
                                    child: Text("Sim",
                                        style:
                                            TextStyle(color: Colors.white)))),
                            Container(
                                width: MediaQuery.of(context).size.width * .20,
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("N??o",
                                        style:
                                            TextStyle(color: Colors.white)))),
                          ],
                        ),
                      )
                    ])));
      });
}
