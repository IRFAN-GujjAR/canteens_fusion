import 'package:canteens_fusion/core/providers/user_session_provider.dart';
import 'package:canteens_fusion/core/utils/initialize_app_utils.dart';
import 'package:canteens_fusion/core/utils/navigation/navigation_utils.dart';
import 'package:canteens_fusion/core/utils/size_utils.dart';
import 'package:canteens_fusion/core/widgets/profile_photo_widget.dart';
import 'package:canteens_fusion/features/auth/presentation/provider/login_page_provider.dart';
import 'package:canteens_fusion/features/auth/presentation/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final class CustomerMainPage extends StatelessWidget {
  const CustomerMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Main Page'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.v,
            ),
            ProfilePhotoWidget(
              onEditPressed: () {},
              profilePhotoUrl:
                  context.read<UserSessionProvider>().currentUser!.photoUrl,
            ),
            SizedBox(
              height: 20.v,
            ),
            Text(context.read<UserSessionProvider>().currentUser!.displayName),
            SizedBox(
              height: 20.v,
            ),
            TextButton(
                onPressed: () {
                  locator.get<FirebaseAuth>().signOut().then((value) {
                    NavigationUtils.navigate(
                        context: context,
                        page: ChangeNotifierProvider<LoginPageProvider>(
                          create: (context) => LoginPageProvider(),
                          child: const LoginPage(),
                        ),
                        removePreviousPages: true);
                  });
                },
                child: const Text('Logout')),
          ],
        ),
      ),
    );
  }
}
