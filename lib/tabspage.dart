import 'package:flutter/material.dart';
import 'package:pinder/FeedPage.dart';
import 'package:pinder/MyFeeds.dart';
import 'package:pinder/ProfilePage.dart';

class TabsPage extends StatefulWidget {
  TabsPage({Key key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    _controller = TabController(initialIndex: 1, length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
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
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .07,
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(color: Color.fromRGBO(34, 35, 43, 100), width: 0.5),
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
      ],
    );
  }
}
