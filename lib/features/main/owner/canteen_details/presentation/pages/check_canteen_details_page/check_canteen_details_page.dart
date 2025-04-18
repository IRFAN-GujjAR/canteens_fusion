import 'package:canteens_fusion/core/constants/icons_constants.dart';
import 'package:canteens_fusion/core/providers/user_session_provider.dart';
import 'package:canteens_fusion/core/utils/common_utils.dart';
import 'package:canteens_fusion/core/utils/navigation/navigation_utils.dart';
import 'package:canteens_fusion/core/utils/navigation/owner/constants.dart';
import 'package:canteens_fusion/core/utils/print_utils.dart';
import 'package:canteens_fusion/core/utils/size_utils.dart';
import 'package:canteens_fusion/core/widgets/custom_filled_button_widget.dart';
import 'package:canteens_fusion/features/main/owner/canteen_details/presentation/blocs/canteen_details_bloc.dart';
import 'package:canteens_fusion/features/main/owner/canteen_details/presentation/providers/canteen_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CheckCanteenDetailsPage extends StatelessWidget {
  const CheckCanteenDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CanteenDetailsBloc, CanteenDetailsState>(
        listener: (context, state) {
          context
              .read<CanteenDetailsProvider>()
              .handleCanteenDetailsBlocState(state);
          if (state is CanteenDetailsStateLoaded) {
            NavigationUtils.navigate(
                context: context,
                ownerNavigationPageType: OwnerNavigationPageType.main,
                removePreviousPages: true);
          } else if (state is CanteenDetailsStateNoCanteenFound) {
            NavigationUtils.navigate(
                context: context,
                ownerNavigationPageType:
                    OwnerNavigationPageType.addCanteenDetails,
                removePreviousPages: true);
          }
        },
        child: Center(
          child: Consumer<CanteenDetailsProvider>(
            builder: (context, provider, child) {
              final state = provider.state;
              printDebugMesg(
                  dartFileName: 'dartFileName', msg: state.toString());
              if (state == CanteenDetailsProviderStates.error) {
                return Padding(
                  padding: getScreenPadding(onlyHorizontal: true),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(IconsConstants.warning),
                      SizedBox(
                        height: 20.v,
                      ),
                      Text(
                        provider.errorMsg,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 20.v,
                      ),
                      CustomFilledButtonWidget(
                        onPressed: () {
                          context.read<CanteenDetailsBloc>().add(
                              CanteenDetailsEventFetch(context
                                  .read<UserSessionProvider>()
                                  .currentUser!
                                  .uid));
                        },
                        expandWidth: false,
                        defaultButtonStyle: true,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  SizedBox(
                    height: 25.v,
                  ),
                  const Text(
                    'Fetching Canteen Details...',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
