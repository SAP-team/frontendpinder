import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinder/detail_bloc/detail_bloc.dart';
import 'package:pinder/detail_bloc/detail_events.dart';
import 'package:pinder/halpers/models/detailmodel.dart';

import 'AutPages/AuthPagestate.dart';
import 'blocs/auth_bloc/auth_bloc.dart';
import 'blocs/auth_bloc/auth_events.dart';
import 'blocs/feed_bloc/feed_bloc.dart';
import 'blocs/feed_bloc/feed_events.dart';
import 'blocs/main_bloc/main_bloc.dart';
import 'blocs/main_bloc/main_events.dart';
import 'blocs/siginup_bloc/signup_bloc.dart';
import 'blocs/siginup_bloc/signup_events.dart';
import 'blocs/signin_bloc/signin_bloc.dart';
import 'blocs/signin_bloc/signin_events.dart';

void main() async {
  await GetStorage.init();

  HttpOverrides.global = new DevHttpOverrides();

  runApp(BlocProvider(
    create: (_) => DetailBloc()..add(StatrupfotDetail()),
    child: BlocProvider(
      create: (_) => FeedBloc()..add(GetFeed()),
      child: BlocProvider(
        create: (_) => SigninBloc()..add(Startup()),
        child: BlocProvider(
          create: (_) => SignUpBloc()..add(StartupforIn()),
          child: BlocProvider(
              create: (_) => AuthBloc()..add(GetSigninStatus()),
              child: BlocProvider(
                  create: (_) => MainBloc()..add(GoToHomPage()),
                  child: MyApp())),
        ),
      ),
    ),
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
