import 'package:flutter/material.dart';
import 'package:hello/models/Product.dart';
import 'package:hello/widgets/AddressCell.dart';
import 'package:hello/widgets/EntregaJustaCell.dart';
import 'package:hello/widgets/ProductCell.dart';

class CartPage extends StatelessWidget {

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {

    final Product product = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Carrinho'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget> [
          ProductCell(product),
          AddressCell(),
          EntregaJustaCell(product),
          ],
        )
      ),
    );
  }
}