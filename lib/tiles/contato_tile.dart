import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContatoTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  ContatoTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // SizedBox(
          //   height: 100.0,
          //   child: Image.network(
          //     snapshot.data["imagem"],
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  snapshot.data["nome"],
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6.0),
                Text(
                  snapshot.data["telefone"],
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 6.0),
                Text(
                  snapshot.data["email"],
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
