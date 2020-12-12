import 'package:agenda_flutter/models/contato_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetalhesContato extends StatelessWidget {
  Contato contato;

  DetalhesContato(this.contato);

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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 100.0,
              child: CircleAvatar(
                backgroundImage: NetworkImage(contato.foto),radius: 50,
              ),
            ),
            MainInfoTab(
              fieldTitle: "Nome do contato",
              fieldInfo: contato.nome,
            ),
            SizedBox(
              height: 15,
            ),
            MainInfoTab(
              fieldTitle: "Telefone",
              fieldInfo: contato.telefone,
            ),
            SizedBox(
              height: 15,
            ),
            MainInfoTab(
              fieldTitle: "Data de inclusão",
              fieldInfo: converterTimestamp(contato.dataInclusao),
            ),
            SizedBox(
              height: 15,
            ),
            MainInfoTab(
              fieldTitle: "E-mail",
              fieldInfo: contato.email,
            ),
          ],
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
