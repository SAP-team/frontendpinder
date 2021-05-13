import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class LoadinPage extends StatefulWidget {
  LoadinPage({Key key}) : super(key: key);

  @override
  _LoadinPageState createState() => _LoadinPageState();
}

class _LoadinPageState extends State<LoadinPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: LoadingBouncingGrid.square(
      size: MediaQuery.of(context).size.width * .5,
      backgroundColor: Color.fromRGBO(216, 146, 22, 100),
    )));
  }
}
