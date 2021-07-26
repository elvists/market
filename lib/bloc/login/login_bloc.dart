import 'package:market/bloc/authentication/authentication_bloc.dart';
import 'package:market/bloc/authentication/authentication_event.dart';
import 'package:market/service/user_service.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserService userService;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    UserService userService,
    @required this.authenticationBloc,
  })  : userService = userService ?? UserService(),
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginRequested) {
      yield LoginLoading();

      try {
        final token = await userService.authenticate(
          username: event.username,
          password: event.password,
        );

        authenticationBloc.add(LoggedIn(token: token));
        yield LoginSuccess();
      } catch (error) {
        yield LoginFailure(error: error.message);
      }
    }
  }
}
