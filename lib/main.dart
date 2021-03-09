import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(home: new HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "https://raw.githubusercontent.com/randycarrero/gunplajson/main/model.json"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    print(data[1]["name"]);

    return "Success!";
  }

  @override
  // ignore: must_call_super
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Gunpla Database"), backgroundColor: Colors.blue),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            elevation: 8.0,
            margin:
                EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
            color: Colors.white,
            child: new Container(
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Icon(Icons.accessibility,
                              color: const Color(0xFF666565)),
                          new Container(
                              margin: EdgeInsets.only(left: 5.0),
                              constraints:
                                  BoxConstraints(minWidth: 100, maxWidth: 300),
                              child: Text(
                                data[index]["name"],
                                maxLines: 1,
                              ))
                        ]),
                    new Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 15.0),
                        constraints:
                            BoxConstraints(minWidth: 100, maxWidth: 300),
                        child: Text(
                          data[index]["series"],
                          maxLines: 4,
                        ))
                  ]),
              padding: const EdgeInsets.only(
                  left: 5.0, right: 5.0, top: 15.0, bottom: 15.0),
              alignment: Alignment.center,
            ),
          );
        },
      ),
    );
  }
}
