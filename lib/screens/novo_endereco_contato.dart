import 'package:agenda_flutter/screens/detalhes_contato.dart';
import 'package:agenda_flutter/screens/tela_inicio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:via_cep/via_cep.dart';

class NovoEnderecoContato extends StatelessWidget {
  final idContato;
  final _cepController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var maskCep = MaskTextInputFormatter(
      mask: "#####-###(", filter: {"#": RegExp(r'[0-9]')});

  NovoEnderecoContato(this.idContato);

  buscarCep() async {
    var CEP = new via_cep();

    var result = await CEP.searchCEP(_cepController.text.trim(), 'json', '');

    if (CEP.getResponse() == 200) {
      _enderecoController.text = CEP.getLogradouro().toString();
    } else {
      print('Código de Retorno: ' + CEP.getResponse().toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Endereço"),
        centerTitle: true,
      ),
      body: Container(
        child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                    inputFormatters: [maskCep],
                    controller: _cepController,
                    decoration: InputDecoration(
                        hintText: "CEP",
                        suffixIcon: IconButton(
                          onPressed: () {
                            buscarCep();
                          },
                          icon: Icon(Icons.search),
                        )),
                    keyboardType: TextInputType.number),
                SizedBox(height: 16.0),
                TextFormField(
                    controller: _enderecoController,
                    decoration: InputDecoration(hintText: "Endereço"),
                    keyboardType: TextInputType.text,
                    validator: (text) {
                      if (text.isEmpty) return "Endereço inválido";
                    }),
                SizedBox(height: 16.0),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    child: Text("Salvar", style: TextStyle(fontSize: 18.0)),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () {
                      Firestore.instance
                          .collection("contatos")
                          .document(idContato)
                          .collection("enderecos")
                          .document()
                          .setData({
                        "endereco": _enderecoController.text.trim(),
                        "CEP": _cepController.text.trim()
                      });

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TelaInicio()));
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
