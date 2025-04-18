part of '../navigation_utils.dart';

Widget _loginPage(BuildContext context) {
  return ChangeNotifierProvider<LoginPageProvider>(
    create: (context) => LoginPageProvider(),
    child: const LoginPage(),
  );
}
