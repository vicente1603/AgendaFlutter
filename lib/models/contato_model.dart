import 'package:cloud_firestore/cloud_firestore.dart';

import 'endereco_model.dart';

class Contato {
  String documentID;
  String nome;
  String foto;
  String telefone;
  int dataInclusao;
  String email;
  List<Endereco> enderecos;

  Contato(this.documentID, this.nome, this.foto, this.telefone, this.dataInclusao,
      this.email, this.enderecos);

  Contato.fromDocument(DocumentSnapshot snapshot) {
    documentID = snapshot.data["id"];
    nome = snapshot.data["nome"];
    foto = snapshot.data["foto"];
    telefone = snapshot.data["telefone"];
    dataInclusao = snapshot.data["dataInclusao"];
    email = snapshot.data["email"];
  }
}
