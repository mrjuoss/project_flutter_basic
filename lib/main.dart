import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Tugas OSG 04',
      home: Home(title: 'Users'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  final String title;

  Home({Key key, this.title}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<User>> _getUsers() async {
    var data = await http
        .get("http://www.json-generator.com/api/json/get/cfwZmvEBbC?index=2");
    var jsonData = json.decode(data.body);

    List<User> users = [];

    for (var u in jsonData) {
      User user =
          User(u["index"], u["about"], u["name"], u["email"], u["picture"]);
      users.add(user);
    }
    return users;
    print(users.length);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        child: FutureBuilder(
          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text('Loading...'),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(snapshot.data[index].picture),
                    ),
                    title: Text(snapshot.data[index].name),
                    subtitle: Text(snapshot.data[index].email),
                    onTap: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                DetailUser(snapshot.data[index])),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class User {
  int index;
  String about;
  String name;
  String email;
  String picture;

  User(
    this.index,
    this.about,
    this.name,
    this.email,
    this.picture,
  );
}

class DetailUser extends StatelessWidget {
  final User user;
  DetailUser(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(user.picture),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter),
              ),
              child: Text(user.about),
            ),
          ),
        ],
      ),
    );
  }
}
