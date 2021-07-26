import 'package:market/model/token.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent() : super();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final Token token;

  LoggedIn({@required this.token});

  @override
  List<Object> get props => [token];
}

class LoggedOut extends AuthenticationEvent {}
