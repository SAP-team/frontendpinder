import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinder/main_bloc/main_bloc.dart';
import 'package:pinder/main_bloc/main_events.dart';

import 'AutPages/AuthPagestate.dart';

void main() async {
  await GetStorage.init();
  runApp(BlocProvider(
      create: (_) => MainBloc()..add(GetSigninStatus()), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pinder',
      initialRoute: '/',
      routes: {
        '/': (context) => MainAuthState(),
      },
    );
  }
}
