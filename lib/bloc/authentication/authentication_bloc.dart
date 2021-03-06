import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:market/service/cart_service.dart';
import 'package:market/service/user_service.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserService userService;
  final CartService cartService;

  AuthenticationBloc({UserService userService, CartService cartService})
      : userService = userService ?? UserService(),
        cartService = cartService ?? CartService(),
        super(AuthenticationUninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await userService.hasToken();

      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userService.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userService.deleteToken();
      await cartService.clearCart();
      yield AuthenticationUnauthenticated();
    }
  }
}
