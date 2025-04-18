import 'package:canteens_fusion/core/providers/user_session_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class LogoutButtonWidget extends StatelessWidget {
  final bool _disable;

  const LogoutButtonWidget({Key? key, bool disable = false})
      : _disable = disable,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: _disable
            ? null
            : () {
                context.read<UserSessionProvider>().signOut(context);
              },
        child: const Text('Logout'));
  }
}
