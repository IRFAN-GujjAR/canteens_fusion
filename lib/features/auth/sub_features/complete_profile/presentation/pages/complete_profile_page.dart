import 'package:canteens_fusion/core/constants/padding_constants.dart';
import 'package:canteens_fusion/core/utils/common_utils.dart';
import 'package:canteens_fusion/core/utils/form_validation/form_validation_utils.dart';
import 'package:canteens_fusion/core/utils/provider_utils.dart';
import 'package:canteens_fusion/core/utils/size_utils.dart';
import 'package:canteens_fusion/core/widgets/custom_filled_button_widget.dart';
import 'package:canteens_fusion/core/widgets/custom_text_form_field.dart';
import 'package:canteens_fusion/core/widgets/logout_button_widget.dart';
import 'package:canteens_fusion/core/widgets/profile_photo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/complete_profile_bloc.dart';
import '../bloc/complete_profile_states.dart';
import '../providers/complete_profile_provider.dart';

final class CompleteProfilePage extends StatelessWidget {
  const CompleteProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        ProviderUtils<CompleteProfileProvider>().getProvider(context: context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: PaddingConstants.screenBottomPadding.sB),
        child: Center(
          child: BlocConsumer<CompleteProfileBloc, CompleteProfileState>(
              listener: (context, state) {
            provider.handleBlocStates(context, state);
          }, builder: (context, state) {
            final isLoading = state is CompleteProfileLoadingState;
            return Column(
              children: [
                SizedBox(
                  height: 10.v,
                ),
                Consumer<CompleteProfileProvider>(
                    builder: (context, provider, _) {
                  return ProfilePhotoWidget(
                    isLoading: isLoading,
                    onEditPressed: () {
                      provider.pickImage(context);
                    },
                    profilePhotoFile: provider.imageFile,
                  );
                }),
                SizedBox(
                  height: 30.v,
                ),
                Padding(
                  padding: getScreenPadding(onlyHorizontal: true),
                  child: Column(
                    children: [
                      Form(
                        key: provider.formKey,
                        child: CustomTextFormFieldWidget(
                          controller: provider.displayNameTextController,
                          enabled: !isLoading,
                          labelText: 'Display Name',
                          autofillHint: AutofillHints.name,
                          headingText: 'Enter your name',
                          suffixIcon: Icons.person,
                          validator: FormValidationUtils.nameValidator,
                        ),
                      ),
                      SizedBox(
                        height: 30.v,
                      ),
                      CustomFilledButtonWidget(
                          isLoading: isLoading,
                          onPressed: () {
                            provider.completeProfile(context);
                          },
                          child: const Text('Finish')),
                      SizedBox(
                        height: 50.v,
                      ),
                      LogoutButtonWidget(
                        disable: isLoading,
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
