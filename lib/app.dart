import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/bloc/authentication/authentication_event.dart';
import 'package:market/routes.dart';
import 'package:market/screens/login/login_page.dart';
import 'package:market/screens/splash/splash_page.dart';

import 'bloc/authentication/authentication_bloc.dart';
import 'bloc/authentication/authentication_state.dart';
import 'screens/home/home_page.dart';

class AppContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (BuildContext buildContext) => AuthenticationBloc(),
      child: _App(),
    );
  }
}

class _App extends StatefulWidget {
  @override
  State<_App> createState() => _AppState();
}

class _AppState extends State<_App> {
  @override
  void initState() {
    context.read<AuthenticationBloc>().add(AppStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateRoute: generateRoute,
      theme: ThemeData(primaryColor: Colors.black),
      home: loadPage(),
    );
  }

  BlocBuilder<AuthenticationBloc, AuthenticationState> loadPage() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (BuildContext context, AuthenticationState state) {
        if (state is AuthenticationUninitialized) {
          return SplashPage();
        } else if (state is AuthenticationAuthenticated) {
          return HomeContainer();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
