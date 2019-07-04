import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:tugas_akhir_osg04028/models/my_card.dart';
import 'package:tugas_akhir_osg04028/pages/detail_card.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Final Project - OSG04028'),
      ),
      body: Container(
        child: FutureBuilder(
          future: getData(http.Client()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text('Loading...'),
                ),
              );
            } else {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 8.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      decoration:
                          //BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                          BoxDecoration(color: Color.fromRGBO(178, 89, 26, .9)),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              snapshot.data[index].cardImages[0].imageUrl),
                        ),
                        title: Text(
                          snapshot.data[index].name,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          snapshot.data[index].type,
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    DetailCard(snapshot.data[index])),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Confirmation'),
                  content: Text('Are you sure want to Exit ?'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('No'),
                    ),
                    FlatButton(
                      onPressed: () {
                        exit(0);
                      },
                      child: Text('Yes'),
                    ),
                  ],
                );
              });
        },
        child: Icon(Icons.exit_to_app),
      ),
    );
  }
}

List<MyCard> parseCard(String responBody) {
  final parsed = json.decode(responBody).cast<Map<String, dynamic>>();
  return parsed.map<MyCard>((json) => MyCard.fromJson(json)).toList();
}

Future<List<MyCard>> getData(http.Client client) async {
  final response =
      await client.get('https://db.ygoprodeck.com/api/v5/cardinfo.php?num=20');
  return compute(parseCard, response.body);
}
