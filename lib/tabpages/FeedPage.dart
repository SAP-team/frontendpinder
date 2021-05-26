import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinder/blocs/detail_bloc/detail_bloc.dart';
import 'package:pinder/blocs/detail_bloc/detail_events.dart';
import 'package:pinder/blocs/feed_bloc/feed_bloc.dart';
import 'package:pinder/blocs/feed_bloc/feed_events.dart';
import 'package:pinder/blocs/feed_bloc/feed_states.dart';

import 'package:pinder/halpers/models/feedmodel.dart';
import 'package:pinder/halpers/loading.dart';
import 'package:provider/provider.dart';

import '../blocs/main_bloc/main_bloc.dart';
import '../blocs/main_bloc/main_events.dart';

class FeedPage extends StatefulWidget {
  FeedPage({Key key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  Widget feed(List<FeedModel> feed) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .9,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowGlow();
        },
        child: ListView.builder(
          itemBuilder: (context, index) {
            Uint8List iamge = base64Decode(feed[index].image.toString());

            return GestureDetector(
              onTap: () {
                context.read<MainBloc>().add(GoToDetailPage());
                context.read<DetailBloc>().add(GetDetail(id: feed[index].id));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * .7,
                height: MediaQuery.of(context).size.height * .4,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .3,
                            padding: EdgeInsets.all(10),
                            child: Image.memory(
                              iamge,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .07,
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: AutoSizeText(
                                feed[index].postname,
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                minFontSize: 1,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .4,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10)),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: feed.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedStates>(
      builder: (BuildContext context, FeedStates state) {
        if (state is Succses) {
          return feed(state.feed);
        } else if (state is Loading) {
          return LoadinPage();
        }
      },
    );
  }
}
