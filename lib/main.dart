import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinder/main_bloc/main_bloc.dart';
import 'package:pinder/tabspage.dart';

import 'AutPages/AuthPagestate.dart';
import 'auth_bloc/auth_bloc.dart';
import 'auth_bloc/auth_events.dart';
import 'main_bloc/main_events.dart';

void main() async {
  await GetStorage.init();
  runApp(BlocProvider(
      create: (_) => AuthBloc()..add(GetSigninStatus()),
      child: BlocProvider(
          create: (_) => MainBloc()..add(GoToHomPage()), child: MyApp())));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pinder',
      initialRoute: '/',
      routes: {
        '/': (context) => MainAuthState(),
        '/home': (context) => TabsPage(),
      },
    );
  }
}
