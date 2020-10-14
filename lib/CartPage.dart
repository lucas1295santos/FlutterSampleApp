import 'package:flutter/material.dart';
import 'package:hello/models/Product.dart';

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
        child: Text(product.name),
      ),
    );
  }
}