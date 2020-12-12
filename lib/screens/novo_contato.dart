import 'dart:io';

import 'package:agenda_flutter/screens/tela_inicio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class NovoContato extends StatefulWidget {
  @override
  _NovoContatoState createState() => _NovoContatoState();
}

class _NovoContatoState extends State<NovoContato> {
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var maskTelefone = MaskTextInputFormatter(
      mask: "(##) #####-####", filter: {"#": RegExp(r'[0-9]')});

  String imgContato;
  String imgPadrao =
      "https://ipc.digital/wp-content/uploads/2016/07/icon-user-default.png";

  @override
  Widget build(BuildContext context) {
    uploadImagemContato() async {
      final _picker = ImagePicker();
      PickedFile image;

      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null) {
        var snapshot = await FirebaseStorage.instance
            .ref()
            .child("img_contato/" +
                DateTime.now().millisecondsSinceEpoch.toString())
            .putFile(file)
            .onComplete;

        imgPadrao = await snapshot.ref.getDownloadURL();

        setState(() {
          imgContato = imgPadrao;
        });
      } else {
        print("erro");
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Adicionar um novo contato"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            (imgContato != null)
                ? Container(
                    margin: EdgeInsets.all(10),
                    child: CircleAvatar(
                      radius: 100,
                      child: ClipOval(
                        child: Image.network(
                          imgContato,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.all(10),
                    child: CircleAvatar(
                      radius: 100,
                      child: ClipOval(
                        child: Image.network(
                          imgPadrao,
                        ),
                      ),
                    ),
                  ),
            SizedBox(height: 16.0),
            RaisedButton(
              child: Text(
                "Adicionar foto",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
                uploadImagemContato();
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _nomeController,
              validator: (text) {
                if (text.isEmpty) return "Nome inválido";
              },
              decoration: InputDecoration(hintText: "Nome"),
            ),
            SizedBox(height: 16.0),
            TextFormField(
                controller: _telefoneController,
                inputFormatters: [maskTelefone],
                decoration: InputDecoration(hintText: "Telefone"),
                keyboardType: TextInputType.number,
                validator: (text) {
                  if (text.isEmpty) return "Telefone inválido";
                }),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              validator: (text) {
                if (text.isEmpty || !text.contains("@"))
                  return "E-mail inválido";
              },
              decoration: InputDecoration(hintText: "E-mail"),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            // Card(
            //     color: Colors.blue,
            //     child: ListTile(
            //       onTap: () {
            //         // Navigator.of(context).pushReplacement(
            //         //     MaterialPageRoute(
            //         //         builder: (context) =>
            //         //             NovoObjetoOcorrencia()));
            //       },
            //       contentPadding:
            //           EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            //       leading: Container(
            //         padding: EdgeInsets.only(right: 12.0),
            //         decoration: new BoxDecoration(
            //             border: new Border(
            //                 right: new BorderSide(
            //                     width: 1.0, color: Colors.white))),
            //         child: Icon(
            //           Icons.pin_drop,
            //           color: Colors.white,
            //           size: 50,
            //         ),
            //       ),
            //       title: Align(
            //         alignment: Alignment.center,
            //         child: Text(
            //           "Adicionar Endereço",
            //           style: TextStyle(
            //               color: Colors.white, fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //       trailing: Icon(
            //         Icons.keyboard_arrow_right,
            //         color: Colors.white,
            //         size: 30.0,
            //       ),
            //     )),
            // listaEnderecos(),
            SizedBox(height: 16.0),
            SizedBox(
              height: 44.0,
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Firestore.instance
                        .collection("contatos")
                        .document()
                        .setData({
                      // "id": FieldPath.documentId,
                      "nome": _nomeController.text.trim(),
                      "telefone": _telefoneController.text.trim(),
                      "email": _emailController.text.trim(),
                      "dataInclusao": DateTime.now().toUtc().millisecondsSinceEpoch,
                      "foto": imgPadrao
                    });

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => TelaInicio()));
                  }
                },
                child: Text(
                  "Salvar Contato",
                  style: TextStyle(fontSize: 18.0),
                ),
                textColor: Colors.white,
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
