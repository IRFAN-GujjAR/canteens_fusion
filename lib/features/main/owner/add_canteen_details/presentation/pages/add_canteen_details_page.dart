import 'dart:io';

import 'package:canteens_fusion/core/utils/common_utils.dart';
import 'package:canteens_fusion/core/utils/form_validation/form_validation_utils.dart';
import 'package:canteens_fusion/core/utils/provider_utils.dart';
import 'package:canteens_fusion/core/utils/size_utils.dart';
import 'package:canteens_fusion/core/widgets/custom_filled_button_widget.dart';
import 'package:canteens_fusion/core/widgets/custom_text_form_field.dart';
import 'package:canteens_fusion/core/widgets/icon_edit_button_widget.dart';
import 'package:canteens_fusion/core/widgets/logout_button_widget.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/presentation/providers/add_canteen_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCanteenDetailsPage extends StatelessWidget {
  const AddCanteenDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = ProviderUtils<AddCanteenDetailsProvider>()
        .getProvider(context: context);
    return GestureDetector(
      onTap: () => hideKeyBoard(context),
      child: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 240,
                  child: Stack(
                    children: [
                      Consumer<AddCanteenDetailsProvider>(
                          builder: (context, provider, _) {
                        final imageFile = provider.imageFile;

                        return Container(
                          height: 220,
                          color: Colors.grey[400],
                          width: double.maxFinite,
                          child: imageFile != null
                              ? Image.file(
                                  File(imageFile.path),
                                  fit: BoxFit.fill,
                                )
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image,
                                      size: 36,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Upload Picture of your canteen')
                                  ],
                                ),
                        );
                      }),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconEditButtonWidget(
                          onPressed: () {
                            provider.pickImage(context);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: getScreenPadding(),
                  child: Form(
                    key: provider.formKey,
                    child: Column(
                      children: [
                        CustomTextFormFieldWidget(
                          controller: provider.canteenNameTextController,
                          labelText: 'Canteen Name',
                          headingText: 'Enter Canteen Name',
                          autofillHint: AutofillHints.name,
                          validator: FormValidationUtils.nameValidator,
                        ),
                        SizedBox(
                          height: 30.v,
                        ),
                        CustomFilledButtonWidget(
                          onPressed: () {
                            provider.onNextPressed(context);
                          },
                          child: const Text('Next'),
                        ),
                        SizedBox(
                          height: 20.v,
                        ),
                        const LogoutButtonWidget()
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
