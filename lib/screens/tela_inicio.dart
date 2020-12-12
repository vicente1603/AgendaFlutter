import 'package:agenda_flutter/screens/novo_contato.dart';
import 'package:agenda_flutter/tiles/contato_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TelaInicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bem-vindo a sua agenda!"),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance
              .collection("contatos")
              .orderBy("nome")
              .getDocuments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) =>
                    ContatoTile(snapshot.data.documents[index]),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NovoContato()));
        },
        tooltip: "Adicionar um novo contato",
        child: Icon(Icons.add),
      ),
    );
  }
}
