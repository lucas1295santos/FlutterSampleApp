import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EntregaJustaCell extends StatefulWidget {
  @override
  _EntregaJustaCellState createState() => _EntregaJustaCellState();
}

enum ButtomState {
  cta,
  waitingDate,
  loading,
  ended,
}

class _EntregaJustaCellState extends State<EntregaJustaCell> {

  ButtomState state = ButtomState.cta;
  DateTime _dateTime;
  int _auctionTimeRemaining = 0;

  void _buttomTapped() {
    setState(() {
      if (state == ButtomState.cta) {
        state = ButtomState.waitingDate;
      } else if(state == ButtomState.waitingDate && _dateTime != null) {
        state = ButtomState.loading;
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
            loadingButton(),
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
                  _buttomTapped();
                });
              },
            )
          );
  }

  Widget ctaButton() {
    return Visibility(
            visible: state == ButtomState.cta || state == ButtomState.waitingDate,
            child: RaisedButton
            (
              color: Colors.blue,
              onPressed: () {
                _buttomTapped();
              },
              child: Text('Procurar Entrega Justa'),
            ),
          );
  }

  Widget loadingButton() {
    return Visibility(
            visible: state == ButtomState.loading,
            child:
            Column(
              children: <Widget> [
                Text('Transportadores estão avaliando sua entrega...'),
                Text('Você receberá o melhor preço em $_auctionTimeRemaining minutos'),
                RaisedButton(
                  color: Colors.blue,
                  onPressed: () {},
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                )
              ],
            ) 
          );
  }
}