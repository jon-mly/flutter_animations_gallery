import 'package:flutter/material.dart';

class BackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: RaisedButton(
          onPressed: Navigator.of(context).pop,
          child: Text("Pop page"),
        ),
      ),
    );
  }
}
