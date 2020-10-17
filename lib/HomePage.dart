import 'package:flutter/material.dart';
import 'package:hello/DetailsPage.dart';
import 'package:hello/models/Product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController editingController = TextEditingController();

  Future<List<Product>> duplicateItems;
  // var items = List<Product>();

  @override
  void initState() {
    duplicateItems = fetch();
    super.initState();
  }

  // void filterSearchResults(String query) {
  //   List<Product> dummySearchList = List<Product>();
  //   dummySearchList.addAll(duplicateItems);
  //   if(query.isNotEmpty) {
  //     List<Product> dummyListData = List<Product>();
  //     dummySearchList.forEach((item) {
  //       if(item.name.contains(query)) {
  //         dummyListData.add(item);
  //       }
  //     });
  //     setState(() {
  //       items.clear();
  //       items.addAll(dummyListData);
  //     });
  //     return;
  //   } else {
  //     setState(() {
  //       items.clear();
  //       items.addAll(duplicateItems);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  // filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Buscar",
                    hintText: "Buscar",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: duplicateItems,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return tableView(snapshot.data);
                  } else {
                    return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue));
                  }
                },
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget tableView(List<Product> items) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${items[index].name}'),
          onTap: () {
            Navigator.pushNamed(
              context,
              DetailsPage.routeName,
              arguments: items[index],
            );
          }
        );
      },
    );
  }

  Future<List<Product>> fetch() async {
    final response = await http.get('https://radiant-woodland-47818.herokuapp.com/products');
    if(response.statusCode == 200) {
      final List prs = json.decode(response.body);
      final List<Product> p = prs.map((item) => Product.fromJson(item)).toList();
      return p;
    } else {
      throw Exception('Failed to load');
    }
  }
}