import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinder/FeedPage.dart';
import 'package:pinder/MyFeeds.dart';
import 'package:pinder/ProfilePage.dart';
import 'package:pinder/main_bloc/main_bloc.dart';
import 'package:pinder/main_bloc/main_states.dart';

import 'DetailPostPage.dart';
import 'main_bloc/main_events.dart';

class TabsPage extends StatefulWidget {
  TabsPage({Key key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> with TickerProviderStateMixin {
  TabController _controller;
  AnimationController animationController;
  double _scale;

  @override
  void initState() {
    _controller = TabController(initialIndex: 0, length: 3, vsync: this);
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 1,
    )..addListener(() {
        setState(() {});
      });
  }

  Widget homepage() {
    _scale = 1 - animationController.value;

    return AnimatedOpacity(
      opacity: _scale,
      duration: Duration(milliseconds: 200),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .93,
              child: Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [FeedPage(), AddPage(), ProfilePage()],
                  controller: _controller,
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * .93,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .07,
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(
                    color: Color.fromRGBO(34, 35, 43, 100), width: 0.5),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .2,
                    height: MediaQuery.of(context).size.height * .1,
                    child: IconButton(
                      icon: Icon(Icons.home_outlined, color: Colors.white),
                      onPressed: () {
                        _controller.animateTo(0);
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .2,
                    height: MediaQuery.of(context).size.height * .1,
                    child: IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        _controller.animateTo(1);
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .2,
                    height: MediaQuery.of(context).size.height * .1,
                    child: IconButton(
                      icon: Icon(Icons.person_outline, color: Colors.white),
                      onPressed: () {
                        _controller.animateTo(2);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(40, 41, 50, 100),
      body: BlocBuilder<MainBloc, MainStates>(
          builder: (BuildContext context, MainStates state) {
        if (state is ToDetilPage) {
          animationController.forward();

          return DetilOfPost(
            id: "deneme",
          );
        } else if (state is ToHomPage) {
          animationController.reverse();

          return homepage();
        }
      }),
    );
  }
}
