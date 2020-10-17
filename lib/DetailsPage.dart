import 'package:flutter/material.dart';
import 'package:hello/models/Product.dart';
import 'package:hello/CartPage.dart';
import 'package:hello/widgets/ImageFactory.dart';

class DetailsPage extends StatelessWidget {

  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {

    final Product product = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: FittedBox(
              fit: BoxFit.contain,
              child: image(ImageType.cell),
            ),
          ),
          Text(product.description),
          Text('Preço: R\$ ${product.price - product.price * product.discount / 100.0}'),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                CartPage.routeName,
                arguments: product,
              );
            },
            child: Text('Adicionar ao carrinho')
          )
        ]
      )
    );
  }
}