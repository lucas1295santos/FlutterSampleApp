import 'package:flutter/material.dart';

class AddressCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
      child: Row(
        children: <Widget>[
          Column(children: <Widget>[
          Text('Entrega em', style: TextStyle(fontWeight: FontWeight.bold),),
          Text('Avenida Brasil, 51 - Campinas, SP'),
          Text('CEP: 13853-592'),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
          )
        ],
      ),
    );
  }
}