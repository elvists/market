import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/bloc/authentication/authentication_bloc.dart';
import 'package:market/bloc/login/login_bloc.dart';
import 'package:market/bloc/login/login_event.dart';
import 'package:market/bloc/login/login_state.dart';
import 'package:market/core/app_colors.dart';
import 'package:market/core/app_styles.dart';

class LoginFormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (BuildContext buildContext) =>
          LoginBloc(authenticationBloc: context.read<AuthenticationBloc>()),
      child: _LoginForm(),
    );
  }
}

class _LoginForm extends StatefulWidget {
  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (BuildContext context, LoginState state) {
        return Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildUsernameInput(),
              _buildPasswordInput(),
              _buildLoginButton(state),
              Container(
                child:
                    state is LoginLoading ? CircularProgressIndicator() : null,
              ),
            ],
          ),
        );
      },
    );
  }

  _buildLoginButton(LoginState state) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: state is! LoginLoading ? _onLoginButtonPressed : null,
            child: Text(AppLocalizations.of(context).loginLabel),
          ),
        )
      ],
    );
  }

  _buildUsernameInput() => Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                cursorColor: AppColors.blue,
                controller: _usernameController,
                decoration: AppStyles.inputDecoration(
                  hint: AppLocalizations.of(context).usernameHint,
                  icon: Icons.people,
                ),
              ),
            ),
          ),
        ],
      );

  _buildPasswordInput() => Row(
        children: [
          Expanded(
            child: TextFormField(
              cursorColor: AppColors.blue,
              controller: _passwordController,
              obscureText: true,
              decoration: AppStyles.inputDecoration(
                hint: AppLocalizations.of(context).passwordHint,
                icon: Icons.password,
              ),
            ),
          ),
        ],
      );

  _onLoginButtonPressed() {
    context.read<LoginBloc>().add(LoginRequested(
          username: _usernameController.text,
          password: _passwordController.text,
        ));
  }
}
