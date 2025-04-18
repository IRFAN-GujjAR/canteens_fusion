part of '../pages/canteen_address/add_canteen_address_page.dart';

class AddCanteenAddressWidget extends StatelessWidget {
  const AddCanteenAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddCanteenAddressProvider>(builder: (context, pro, _) {
      return BlocConsumer<GeocodingBloc, GeocodingState>(
        listener: (context, state) {
          pro.handleGeocodingBlocState(state);
        },
        builder: (context, state) {
          final isLoading = pro.isAddressDetailsReFetching ||
              state is GeocodingStateReloading;
          return Form(
              key: pro.formKey,
              child: Column(
                children: [
                  CustomTextFormFieldWidget(
                    enabled: !isLoading,
                    controller: pro.canteenAddressTxtController,
                    labelText: 'Canteen Address',
                    headingText: 'Enter canteen address',
                    maxLines: 3,
                    autofillHint: AutofillHints.streetAddressLine1,
                    validator: FormValidationUtils.nameValidator,
                  ),
                  SizedBox(
                    height: 20.v,
                  ),
                  CustomTextFormFieldWidget(
                    enabled: !isLoading,
                    controller: pro.cityTxtController,
                    labelText: 'City',
                    headingText: 'Enter City',
                    autofillHint: AutofillHints.streetAddressLine1,
                    validator: FormValidationUtils.nameValidator,
                  ),
                  SizedBox(
                    height: 20.v,
                  ),
                  CustomTextFormFieldWidget(
                    enabled: !isLoading,
                    controller: pro.stateTxtController,
                    labelText: 'State/Province',
                    headingText: 'Enter State/Province',
                    autofillHint: AutofillHints.streetAddressLine1,
                    validator: FormValidationUtils.nameValidator,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.v),
                    child: Column(
                      children: [
                        CustomTextButtonWidget(
                          onPressed: () {
                            pro.reFetchAddressDetails(
                                context, context.read<GeocodingBloc>());
                          },
                          isLoading: isLoading,
                          text: 'Refetch Address Details',
                        ),
                        SizedBox(
                          height: 10.v,
                        ),
                        CustomFilledButtonWidget(
                            isLoading: isLoading,
                            enableJumpingDotAnimation: false,
                            onPressed: () {
                              pro.onNextPressed(context);
                            },
                            child: const Text('Next')),
                        if (isLoading)
                          Column(
                            children: [
                              SizedBox(
                                height: 50.v,
                              ),
                              const JumpingDotsAnimationWidget()
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ));
        },
      );
    });
  }
}
