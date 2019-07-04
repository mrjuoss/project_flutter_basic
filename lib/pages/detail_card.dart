import 'package:flutter/material.dart';
import 'package:tugas_akhir_osg04028/models/my_card.dart';

class DetailCard extends StatelessWidget {
  final MyCard myCard;
  DetailCard(this.myCard);

  @override
  Widget build(BuildContext context) {
    final topContentText = Container(
        margin: EdgeInsets.fromLTRB(30.0, 250.0, 0.0, 0.0),
        child: Text(myCard.name,
            style: TextStyle(fontSize: 20.0, color: Colors.white)));

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: NetworkImage(myCard.cardImages[0].imageUrl),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .5)),
          child: topContentText,
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      myCard.desc,
      style: TextStyle(fontSize: 14.0),
    );

    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText],
        ),
      ),
    );

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
