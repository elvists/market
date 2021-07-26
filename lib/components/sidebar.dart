import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:market/bloc/authentication/authentication_event.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(Icons.logout),
                  ),
                  Text(AppLocalizations.of(context).logoutLabel),
                ],
              ),
            ),
            onTap: () {
              context.read<AuthenticationBloc>().add(LoggedOut());
            },
          ),
        ],
      ),
    );
  }
}
