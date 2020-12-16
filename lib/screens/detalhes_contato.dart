import 'package:agenda_flutter/models/contato_model.dart';
import 'package:agenda_flutter/models/endereco_model.dart';
import 'package:agenda_flutter/screens/novo_endereco_contato.dart';
import 'package:agenda_flutter/tiles/contato_tile.dart';
import 'package:agenda_flutter/tiles/endereco_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetalhesContato extends StatefulWidget {
  Contato contato;

  DetalhesContato(this.contato);

  @override
  _DetalhesContatoState createState() => _DetalhesContatoState();
}

class _DetalhesContatoState extends State<DetalhesContato> {
  Contato contato;
  var enderecos;

  @override
  void initState() {
    contato = widget.contato;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String converterTimestamp(int timestamp) {
      var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
      var formattedDate = DateFormat("dd/MM/yyyy").format(date); // 16/07/2020
      var time = formattedDate;

      return time;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do contato"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 100.0,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(contato.foto),
                    radius: 50,
                  ),
                ),
                MainInfoTab(
                  fieldTitle: "Nome do contato",
                  fieldInfo: contato.nome,
                ),
                SizedBox(
                  height: 6,
                ),
                MainInfoTab(
                  fieldTitle: "Telefone",
                  fieldInfo: contato.telefone,
                ),
                SizedBox(
                  height: 6,
                ),
                MainInfoTab(
                  fieldTitle: "Data de inclusão",
                  fieldInfo: converterTimestamp(contato.dataInclusao),
                ),
                SizedBox(
                  height: 6,
                ),
                MainInfoTab(
                  fieldTitle: "E-mail",
                  fieldInfo: contato.email,
                ),
                Container(
                  height: 230,
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 3.0)),
                  child: FutureBuilder<QuerySnapshot>(
                    future: Firestore.instance
                        .collection("contatos")
                        .document(contato.id)
                        .collection("enderecos")
                        .getDocuments(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null ||
                          snapshot.data.documents.length == 0) {
                        return Column(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Center(
                                    child: Text(
                                  "Endereços Cadastrados",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                )),
                                SizedBox(height: 15),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Nenhum endereço cadastrado",
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ]),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: <Widget>[
                            Center(
                                child: Text(
                              "Endereços Cadastrados",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            )),
                            SizedBox(height: 15),
                            Expanded(
                              child: ListView.separated(
                                separatorBuilder: (context, index) {
                                  return Divider(
                                      height: 20, color: Colors.blue);
                                },
                                shrinkWrap: true,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) => EnderecoTile(
                                    Endereco.fromDocument(
                                        snapshot.data.documents[index])),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 6),
                SizedBox(
                  height: 44.0,
                  width: 200,
                  child: RaisedButton(
                    child: Text("Adicionar Endereço",
                        style: TextStyle(fontSize: 18.0)),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NovoEnderecoContato(contato.id)));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainInfoTab extends StatelessWidget {
  final String fieldTitle;
  final String fieldInfo;

  MainInfoTab({Key key, @required this.fieldTitle, @required this.fieldInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView(
        padding: EdgeInsets.only(top: 15),
        shrinkWrap: true,
        children: <Widget>[
          Text(
            fieldTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 17,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold),
          ),
          Text(
            fieldInfo,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
