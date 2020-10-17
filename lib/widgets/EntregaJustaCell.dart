import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hello/PurchaseConfirmationPage.dart';
import 'package:hello/models/Auction.dart';
import 'package:hello/models/Bid.dart';
import 'package:hello/models/Product.dart';
import 'package:hello/models/Seller.dart';
import 'package:hello/models/StubModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:async';

class EntregaJustaCell extends StatefulWidget {

  Product product;
  EntregaJustaCell(this.product);

  @override
  _EntregaJustaCellState createState() => _EntregaJustaCellState(product);
}

enum ButtomState {
  cta,
  waitingDate,
  loading,
}

class _EntregaJustaCellState extends State<EntregaJustaCell> {

  _EntregaJustaCellState(this.product);

  ButtomState state = ButtomState.cta;
  DateTime _dateTime;
  Future<Seller> futureSeller;
  Product product;
  int auctionId;
  double deliveryFee;

  void _changeState() {
    setState(() {
      if (state == ButtomState.cta) {
        state = ButtomState.waitingDate;
      } else if(state == ButtomState.waitingDate && _dateTime != null) {
        state = ButtomState.loading;
        postAuction();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
      child: Row(
        children: <Widget> [
        Expanded(child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            datePicker(),
            ctaButton(),
            data(),
          ],
        ))
      ]) 

    );
  }

  Widget datePicker() {
    return Visibility(
            visible: state == ButtomState.waitingDate,
            child: RaisedButton(
              color: Colors.blue,
              child: Text('Escolha a data'),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2021)
                ).then((value) {
                  _dateTime = value;
                  _changeState();
                });
              },
            )
          );
  }

  Widget ctaButton() {
    return Visibility(
            visible: state == ButtomState.cta,
            child: RaisedButton
            (
              color: Colors.blue,
              onPressed: () {
                _changeState();
              },
              child: Text('Procurar Entrega Justa'),
            ),
          );
  }

  Widget data() {
    return Visibility(
            visible: state == ButtomState.loading,
            child:
            FutureBuilder(
              future: futureSeller,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                    return finishedState(snapshot.data);
                } else {
                  return Column(
                    children: <Widget> [
                      Text('Transportadores estão avaliando sua entrega...'),
                      Text('Você receberá o melhor preço em breve'),
                      RaisedButton(
                        color: Colors.blue,
                        onPressed: () {},
                        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                      )
                    ],
                  ); 
                }
              },
            )
          );
  }

  Widget finishedState(Seller model) {
    return Row(children: [ Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
        Text('Subtotal', style: TextStyle(fontWeight: FontWeight.bold),),
        Text('R\$ ${product.price}'),
        Text('Frete', style: TextStyle(fontWeight: FontWeight.bold),),
        Text('$deliveryFee'),
        Text('Total', style: TextStyle(fontWeight: FontWeight.bold),),
        Text('R\$ ${product.price + deliveryFee}'),
        Text('Previsão de entrega: ${_dateTime.toString()}'),
        Text('Entrega realizada por: ${model.name}'), 
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('                                        '),
            Center(child:
              RaisedButton(
                color: Colors.blue,
                onPressed: () {
                    Navigator.pushNamed(
                      context,
                      PurchaseConfirmationPage.routeName,
                    );
                },
                child: Text('Comprar')
              )),
          ],
        ),
      ]
    )]);
  }

  Future<StubModel> fetch() async {
    final response = await http.get('https://habit-flask-rest-api.herokuapp.com/hello');
    if(response.statusCode == 200) {
      return StubModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  postAuction() async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(_dateTime);

    final auction = Auction(
      null,
      10,
      product.id,
      100,
      200,
      formattedDate,
      null
    );
    final json = auction.toJson();
    final response = await http.post(
      'https://radiant-woodland-47818.herokuapp.com/auctions',
       body: jsonEncode(json),
       headers: {"Content-Type": "application/json"},
    );
    if(response.statusCode == 201) {
      final auction = Auction.fromJson(jsonDecode(response.body));
      auctionId = auction.id;
      poolAuction();
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<Seller> foo(Seller a) async {
    return a;
  }

  poolAuction() async {
    final response = await http.get('https://radiant-woodland-47818.herokuapp.com/auctions/$auctionId');
    if(response.statusCode == 200) {
      final auction = Auction.fromJson(jsonDecode(response.body));
      if (auction.status == 'Finalizado') {
        fetchWinningBid();
      } else {
        Timer(Duration(seconds: 5), () {
          poolAuction();
        });
      }
    } else {
      throw Exception('Failed to load');
    }
  }

  fetchWinningBid() async {
    final response = await http.get('https://radiant-woodland-47818.herokuapp.com/auctions/$auctionId/bids/results');
    if(response.statusCode == 200) {
      final bid = Bid.fromJson(jsonDecode(response.body));
      deliveryFee = bid.price;
      fetchSeller(bid.sellerId);
    } else {
      throw Exception('Failed to load');
    }
  }

  fetchSeller(int selerID) async {
    final response = await http.get('https://radiant-woodland-47818.herokuapp.com/sellers/$selerID');
    if(response.statusCode == 200) {
      final seller = Seller.fromJson(jsonDecode(response.body));
      futureSeller = foo(seller);
      _changeState();
    } else {
      throw Exception('Failed to load');
    }
  }
}