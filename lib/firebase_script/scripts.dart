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
        .then((value) => print("Produto deletado dos preços atuais"))
        .onError((error, stackTrace) => print(
            "Produto não deletado de \"precoAtualProduto\": " +
                nomeProduto +
                " || " +
                error.toString()));

    await db
        .collection("produtosEmCotacao")
        .doc(nomeProduto)
        .delete()
        .then((value) => print("Produto deletado da cotação"))
        .onError((error, stackTrace) => print(
            "Erro ao deletar produto de \"produtosEmCotacao\": " +
                nomeProduto +
                " || " +
                error.toString()));

    await db
        .collection("produtosParaCotacao")
        .doc(nomeProduto)
        .delete()
        .then((value) => print("Produto deletado da pré-cotação"))
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
    print("Não foi possível deletar -> " + error.toString());
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void editaNomeProduto(
    String nomeProduto,
    String novoNome,
    String marca,
    String precoMaisAlto,
    String precoMaisBaixo,
    String unidadeMedida,
    String tipoProduto,
    String empresaPrecoAlto,
    String empresaPrecoBaixo) async {
  if (novoNome == '' || novoNome == nomeProduto) {
    return;
  }

  await db
      .collection("produtos_")
      .doc(novoNome)
      .set({
        "nomeProduto": novoNome,
        "precoMaisAlto": precoMaisAlto,
        "precoMaisBaixo": precoMaisBaixo,
        "tipoProduto": tipoProduto,
        "empresaPrecoAlto": empresaPrecoAlto,
        "empresaPrecoBaixo": empresaPrecoBaixo
      })
      .then((value) => db.collection("produtos_").doc(nomeProduto).delete())
      .onError((error, stackTrace) => print(
          "Produto não alterado em \"produtos_\":" +
              nomeProduto +
              " || " +
              error.toString()));

  await db
      .collection("produtosEmCotacao")
      .doc(novoNome)
      .set({"nomeProduto": novoNome, "tipoProduto": tipoProduto}).then(
          (value) => db
              .collection("produtosEmCotacao")
              .doc(nomeProduto)
              .delete()
              .onError((error, stackTrace) => print(
                  "Erro ao modificar em \"produtosEmCotacao\": " +
                      nomeProduto +
                      " || " +
                      error.toString())));

  await db
      .collection("precoAtualProduto")
      .doc(novoNome)
      .set({"nomeProduto": novoNome});

  var query = await db
      .collection("precoAtualProduto")
      .doc(nomeProduto)
      .collection("empresas")
      .get();

  for (var doc in query.docs) {
    await db
        .collection("precoAtualProduto")
        .doc(novoNome)
        .collection("empresas")
        .doc(doc['empresa'])
        .set({
          "nomeProduto": novoNome,
          "empresa": doc['empresa'],
          "preço": doc['preço']
        })
        .then((value) => db
            .collection("precoAtualProduto")
            .doc(nomeProduto)
            .collection("empresas")
            .doc(doc['empresa'])
            .delete())
        .onError((error, stackTrace) =>
            print("Erro ao modificar em \"precoAtualProduto\""));
  }

  await db.collection("precoAtualProduto").doc(nomeProduto).delete();

  var query2 = await db.collection("produtosRespondidos").get();
  for (var doc2 in query2.docs) {
    var recebeValores = await db
        .collection("produtosRespondidos")
        .doc(doc2['empresa'])
        .collection("produtos")
        .get();

    for (var doc3 in recebeValores.docs) {
      await db
          .collection("produtosRespondidos")
          .doc(doc2['empresa'])
          .collection("produtos")
          .doc(novoNome)
          .set({
        "nomeProduto": novoNome,
        "empresa": doc2['empresa'],
        "marca": doc3['marca'],
        "preço": doc3['preço'],
        "unidadeMedida": doc3['unidadeMedida']
      }).then((value) => db
              .collection("produtosRespondidos")
              .doc(doc2['empresa'])
              .collection("produtos")
              .doc(nomeProduto)
              .delete());
      break;
    }
  }

  var query3 = await db.collection("produtosRespondidosModal").get();

  for (var doc3 in query3.docs) {
    var query4 = await db
        .collection("produtosRespondidosModal")
        .doc(doc3['empresa'])
        .collection("produtos")
        .get();
    for (var doc4 in query4.docs) {
      await db
          .collection("produtosRespondidosModal")
          .doc(doc3['empresa'])
          .collection("produtos")
          .doc(novoNome)
          .set({
        "nomeProduto": novoNome,
        "marca": doc4['marca'],
        "empresa": doc4['empresa'],
        "preço": doc4['preço'],
        "unidadeMedida": doc4['unidadeMedida']
      }).then((value) => db
              .collection("produtosRespondidosModal")
              .doc(doc3['empresa'])
              .collection("produtos")
              .doc(nomeProduto)
              .delete());
      break;
    }
  }

  await db.collection("produtosParaCotacao").doc(nomeProduto).delete();

  print("Alteração de nome realizada...");

  novoNome = '';
  novoNomeProduto = '';
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

insereNaCotacao(String nomeProduto, String tipoProduto) async {
  await db
      .collection("produtosEmCotacao")
      .doc(nomeProduto)
      .set({"nomeProduto": nomeProduto, "tipoProduto": tipoProduto})
      .then((value) => print(nomeProduto + " inserido na cotação"))
      .onError((error, stackTrace) => print("Erro ao inserir " +
          nomeProduto +
          " na cotação: " +
          error.toString()));
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void enviaParaPreCotacao(String nomeProduto, String tipoProduto) async {
  await db
      .collection("produtosParaCotacao")
      .doc(nomeProduto)
      .set({"nomeProduto": nomeProduto, "tipoProduto": tipoProduto})
      .then((value) => print("Colocado em pré-cotação"))
      .onError((error, stackTrace) => print(
          nomeProduto + " não inserido na pré-cotação: " + error.toString()));
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
            (value) => print("Enviado para pré-cotação: " + doc['nomeProduto']))
        .onError((error, stackTrace) => print(doc['nomeProduto'] +
            " não enviado para pré-cotação: " +
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
                          child: Text("Produtos colocados em pré-cotação!",
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
    }).then((value) => print("Produto enviado para cotação!!!"));

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
        "preço": doc2['preço']
      });

      await db
          .collection("comprarDe")
          .doc(doc['empresa'])
          .collection("produtos")
          .doc(doc2['nomeProduto'])
          .delete();
    }
    await db.collection("comprarDe").doc(doc['empresa']).delete();
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
                        child: Text("Produtos enviados para cotação!",
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
                          child: Text("Enviando para cotação...",
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
        "preço": doc['preço'],
        "unidadeMedida": doc['unidadeMedida']
      });
    }
  }

  print("Pré-cotação grvada como: " + dateFormatted);
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
                Text("Preço inválido,"),
                Text(
                  nomeProduto + " não gravado",
                ),
                Text("Tente novamente")
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text("Exemplo para formatação de preço: "),
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
      .set({"nomeProduto": nomeProduto, "preço": preco, "empresa": empresa})
      .then((value) => print("Preço Atual Criado!!!"))
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
        "preço": preco,
        "empresa": empresa
      })
      .then((value) => print("Informações Modal OK!!!"))
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
            "preço": preco,
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
        "preço": preco,
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
  print("Iniciando comparação de preços dos produtos...");
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
      if (doc2['preço'] == '' || doc2['preço'] == 0) {
        print("Sem preço cadastrado");
        continue;
      } else {
        listaOrdenador
            .add(Ordenador(doc2['empresa'], double.parse(doc2['preço'])));
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
              print("Preço único setado para: " + doc1['nomeProduto']))
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
              print("Maior preço setado para: " + doc1['nomeProduto']))
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
              print("Menor preço setado para: " + doc1['nomeProduto']))
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

  print("Comparação de preços de produtos terminada...");
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
                          child: Text("Preços Comparados!!",
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
                          child: Text("Calculando Preços...",
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
                        "Atenção, você enviará todos ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                      Text(
                        "os produtos para pré-cotação!",
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
                                    child: Text("Não",
                                        style:
                                            TextStyle(color: Colors.white)))),
                          ],
                        ),
                      )
                    ])));
      });
}
