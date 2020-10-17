import 'package:flutter/material.dart';
import 'package:hello/CartPage.dart';
import 'package:hello/DetailsPage.dart';
import 'package:hello/PurchaseConfirmationPage.dart';
import './HomePage.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Buscar'),
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext context) => MyHomePage(),
        '/details': (BuildContext context) => DetailsPage(),
        '/cart': (BuildContext context) => CartPage(),
        '/purchase': (BuildContext context) => PurchaseConfirmationPage(),
      },
    );
  }
}