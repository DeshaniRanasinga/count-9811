import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  String data = '';
  var item_length;

  @override
  void initState() {
    super.initState();
    getData();
  }
  void getData() async {
    http.Response response =
    await http.get(Uri.parse('https://vpic.nhtsa.dot.gov/api/vehicles/getallmakes?format=json'));
    if (response.statusCode == 200) {
      data = response.body;
      setState(() {
        item_length = jsonDecode(data)['Results'];
      });
    } else {
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: item_length == null ? 0 : item_length.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(jsonDecode(data)['Results'][index]['Make_ID'].toString()),
              subtitle: Text(jsonDecode(data)['Results'][index]['Make_Name'].toString()),
            ),
          );
        },
      ),
    );
  }
}

