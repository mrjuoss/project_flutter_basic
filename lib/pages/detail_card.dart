import 'package:flutter/material.dart';
import 'package:tugas_akhir_osg04028/models/my_card.dart';

class DetailCard extends StatelessWidget {
  final MyCard myCard;
  DetailCard(this.myCard);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(myCard.cardImages[0].imageUrl),
                  fit: BoxFit.cover)),
        ),
        Positioned(
          left: 8.0,
          top: 65.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              25.0, MediaQuery.of(context).size.height * 0.6, 0.0, 0.0),
          height: MediaQuery.of(context).size.height * 0.09,
          padding: EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Text(
            "Race : ${myCard.race} \nArchetype : ${myCard.archetype}",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.white),
          ),
        ),
      ]),
    );
  }
}
