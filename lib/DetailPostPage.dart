import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinder/halpers/api.dart';

import 'package:pinder/halpers/models/detailmodel.dart';
import 'package:pinder/halpers/models/newcommentmode.dart';
import 'package:url_launcher/url_launcher.dart';

import 'blocs/detail_bloc/detail_bloc.dart';
import 'blocs/detail_bloc/detail_events.dart';
import 'blocs/detail_bloc/detail_states.dart';
import 'blocs/main_bloc/main_bloc.dart';
import 'blocs/main_bloc/main_events.dart';
import 'halpers/loading.dart';

class DetilOfPost extends StatefulWidget {
  @override
  _DetilOfPostState createState() => _DetilOfPostState();
}

class _DetilOfPostState extends State<DetilOfPost>
    with TickerProviderStateMixin {
  bool newinput = false;
  TextEditingController yorum = new TextEditingController();
  AnimationController animationController;
  double _scale;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 1,
    )..addListener(() {
        setState(() {});
      });
    animationController.forward();
  }

  Widget loaded(DetailModel model) {
    _scale = animationController.value;

    return AnimatedOpacity(
      opacity: _scale,
      duration: Duration(milliseconds: 200),
      child: WillPopScope(
        onWillPop: () {
          if (!newinput)
            context.read<MainBloc>().add(GoToHomPage());
          else
            setState(() {
              newinput = false;
            });
        },
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  newinput = false;
                });
              },
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .4,
                    child: Image.memory(
                      model.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .07,
                    margin: EdgeInsets.all(10),
                    child: AutoSizeText(
                      model.disc,
                      textAlign: TextAlign.center,
                      minFontSize: 1,
                      maxLines: 2,
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .07,
                    child: AutoSizeText(
                      model.price ?? "Ödül bulunmuyor",
                      textAlign: TextAlign.center,
                      minFontSize: 1,
                      maxLines: 1,
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .025,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.25,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Color.fromRGBO(101, 94, 94, 100))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: model.userimage != null
                                  ? Image.memory(
                                      model.userimage,
                                      fit: BoxFit.fill,
                                    )
                                  : Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: MediaQuery.of(context).size.width *
                                          0.2,
                                    )),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.width * 0.2,
                          child: Center(
                            child: AutoSizeText(
                              model.username,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              minFontSize: 1,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: model.telno != null,
                          child: GestureDetector(
                            onTap: () {
                              launch("tel://${model.telno}");
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.width * 0.15,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(101, 94, 94, 100),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: AutoSizeText(
                                  "ARA",
                                  maxLines: 1,
                                  minFontSize: 1,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification:
                          (OverscrollIndicatorNotification overscroll) {
                        overscroll.disallowGlow();
                      },
                      child: ListView.builder(
                        itemCount: model.comment.length,
                        itemBuilder: (context, index) {
                          return index <= model.comment.length
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.width * 0.26,
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      border: index == 0
                                          ? Border(
                                              top: BorderSide(
                                                color: Color.fromRGBO(
                                                    101, 94, 94, 100),
                                              ),
                                              left: BorderSide(
                                                  color: Color.fromRGBO(
                                                      101, 94, 94, 100)),
                                              right: BorderSide(
                                                  color: Color.fromRGBO(
                                                      101, 94, 94, 100)))
                                          : index == model.comment.length - 1
                                              ? Border(
                                                  bottom: BorderSide(
                                                      color: Color.fromRGBO(
                                                          101, 94, 94, 100)),
                                                  left: BorderSide(
                                                      color: Color.fromRGBO(
                                                          101, 94, 94, 100)),
                                                  right: BorderSide(
                                                      color: Color.fromRGBO(
                                                          101, 94, 94, 100)))
                                              : Border(
                                                  left: BorderSide(
                                                      color:
                                                          Color.fromRGBO(101, 94, 94, 100)),
                                                  right: BorderSide(color: Color.fromRGBO(101, 94, 94, 100)))),
                                  child: Column(
                                    children: [
                                      index != 0 ||
                                              index != model.comment.length
                                          ? SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05)
                                          : SizedBox(
                                              height: 0,
                                            ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                              child: model.comment[index]
                                                          .image !=
                                                      null
                                                  ? Image.memory(
                                                      model
                                                          .comment[index].image,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.15,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.15,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Icon(
                                                      Icons.person,
                                                      size:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.15,
                                                      color: Colors.white,
                                                    )),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            child: Center(
                                              child: AutoSizeText(
                                                model
                                                    .comment[index].postcomment,
                                                textAlign: TextAlign.center,
                                                minFontSize: 1,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  height: 40,
                                );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    newinput = true;
                  });
                },
                backgroundColor: Colors.transparent,
                child: Icon(Icons.message),
              ),
            ),
            Positioned(
              bottom: 0,
              child: AnimatedContainer(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 200),
                width: MediaQuery.of(context).size.width,
                height: newinput ? MediaQuery.of(context).size.height * .2 : 0,
                color: Colors.black,
                child: CupertinoTextField(
                  controller: yorum,
                  onSubmitted: (value) {
                    setState(() {
                      final box = GetStorage();
                      if (yorum.text.trim() != "") {
                        NewCommentModel newcomment = new NewCommentModel(
                            box.read("uid"),
                            yorum.text.trim(),
                            model.id,
                            "deneme");
                        context
                            .read<DetailBloc>()
                            .add(AddComment(model: newcomment));
                      }

                      newinput = false;
                      yorum.text = "";
                    });
                  },
                  placeholder: "Yorumunuz",
                  style: TextStyle(color: Colors.white),
                  placeholderStyle:
                      TextStyle(color: Colors.white.withAlpha(60)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(47, 48, 60, 100)),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: GestureDetector(
                onTap: () {
                  context.read<MainBloc>().add(GoToHomPage());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .1,
                  height: MediaQuery.of(context).size.height * .1,
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailStates>(
        builder: (BuildContext context, DetailStates state) {
      if (state is Loading) {
        return LoadinPage();
      } else if (state is Succses) {
        return loaded(state.model);
      }
    });
  }
}
