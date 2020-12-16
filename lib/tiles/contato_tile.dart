import 'package:agenda_flutter/models/contato_model.dart';
import 'package:agenda_flutter/screens/detalhes_contato.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContatoTile extends StatelessWidget {
  final Contato contato;

  ContatoTile(this.contato);

  @override
  Widget build(BuildContext context) {
    String converterTimestamp(int timestamp) {
      var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
      var formattedDate = DateFormat("dd/MM/yyyy").format(date); // 16/07/2020
      var time = formattedDate;

      return time;
    }

    return Card(
      elevation: 2.0,
      shadowColor: Colors.black,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DetalhesContato(contato)));
            },
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            leading: Container(
              padding: EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(contato.foto),
                radius: 30,
              ),
            ),
            title: Column(
              children: <Widget>[
                Text(
                  contato.nome,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  contato.telefone,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            subtitle: Text(
              "Data de inclusão: " +
                  converterTimestamp(contato.dataInclusao),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
