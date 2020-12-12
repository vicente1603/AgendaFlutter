import 'package:cloud_firestore/cloud_firestore.dart';

class Endereco {
  String documentID;
  String endereco;
  String CEP;

  Endereco(this.documentID, this.endereco, this.CEP);

  Endereco.fromDocument(DocumentSnapshot snapshot) {
    documentID = snapshot.data["id"];
    endereco = snapshot.data["endereco"];
    CEP = snapshot.data["CEP"];
  }
}
