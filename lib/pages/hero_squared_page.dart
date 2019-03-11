import 'package:flutter/material.dart';

class HeroSquaredPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.amberAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                  width: 300.0,
                  height: 100.0,
                  child: Hero(
                      tag: "cirlce_hero_to_rectangle",
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.cyan)))),
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
