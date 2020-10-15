import 'package:flutter/material.dart';
import 'package:hello/models/Product.dart';

class ProductCell extends StatelessWidget {

  ProductCell(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
      child: Row(
        children: <Widget>[
          FittedBox(child: const FlutterLogo(), fit: BoxFit.contain),
          Text(product.name),
        ],
      ),
    );
  }
}