import 'package:agenda_flutter/models/endereco_model.dart';
import 'package:flutter/material.dart';

class EnderecoTile extends StatelessWidget {
  final Endereco endereco;

  EnderecoTile(this.endereco);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                endereco.endereco,
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                endereco.CEP,
                style: TextStyle(fontSize: 20.0),
              )
            ],
          ),
          SizedBox(height: 6.0),
        ],
      ),
    );
  }
}
