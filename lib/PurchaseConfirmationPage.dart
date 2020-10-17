import 'package:flutter/material.dart';

class PurchaseConfirmationPage extends StatelessWidget {

  static const routeName = '/purchase';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Obrigado'),
      ),
      body: Center(
        child: Container(
          child: Text('Sua compra foi confirmada!'),
        ),
      )
    );
  }
}