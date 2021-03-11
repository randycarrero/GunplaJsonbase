import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AppStateNotifier.dart';
import 'dart:async';
import 'dart:convert';
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

    print(data[1]["title"]);

    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Gunpla Database"),
        leading: Icon(Icons.menu),
        actions: <Widget>[
          Switch(
            value: Provider.of<AppStateNotifier>(context).isDarkMode,
            onChanged: (boolVal) {
              Provider.of<AppStateNotifier>(context).updateTheme(boolVal);
            },
          )
        ],
      ),
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
                                data[index]["title"],
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

    body:
    Container(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, pos) {
          return Card(
            elevation: 0,
            child: ListTile(
              title: Text(
                'Title $pos',
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Text(
                'Subtitle $pos',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              leading: Icon(
                Icons.alarm,
                color: Theme.of(context).iconTheme.color,
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          );
        },
      ),
    );
  }
}
