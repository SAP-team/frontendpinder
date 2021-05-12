import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'package:pinder/tabspage.dart';

import 'AutPages/AuthPagestate.dart';
import 'blocs/auth_bloc/auth_bloc.dart';
import 'blocs/auth_bloc/auth_events.dart';
import 'blocs/main_bloc/main_bloc.dart';
import 'blocs/main_bloc/main_events.dart';
import 'blocs/siginup_bloc/signup_bloc.dart';
import 'blocs/siginup_bloc/signup_events.dart';

void main() async {
  await GetStorage.init();
  HttpOverrides.global = new DevHttpOverrides();

  runApp(BlocProvider(
    create: (_) => SignUpBloc()..add(Startup()),
    child: BlocProvider(
        create: (_) => AuthBloc()..add(GetSigninStatus()),
        child: BlocProvider(
            create: (_) => MainBloc()..add(GoToHomPage()), child: MyApp())),
  ));
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

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
