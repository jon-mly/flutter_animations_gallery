import 'package:flutter/material.dart';

class HeroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.amberAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: Hero(
                      tag: "cirlce_hero",
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.cyan)))),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
              ),
              RaisedButton(
                onPressed: Navigator.of(context).pop,
                child: Text("Pop page"),
              ),
            ],
          ),
        ));
  }
}
