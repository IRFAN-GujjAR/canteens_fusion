part of '../pages/canteen_address/add_canteen_address_page.dart';

class CanteenAddressPlaceholderWidget extends StatelessWidget {
  const CanteenAddressPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20.v,
        ),
        Image.asset(ImageConstants.canteenAddress),
        SizedBox(
          height: 30.v,
        ),
        const Text(
          'Please stay inside your canteen center to get automatic location of your canteen',
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 25.v,
        ),
        Consumer<AddCanteenDetailsProvider>(builder: (context, pro, _) {
          return BlocBuilder<GeocodingBloc, GeocodingState>(
            builder: (context, state) {
              final isLoading = pro.isCurrentLocationFetching ||
                  state is GeocodingStateLoading;
              return Padding(
                padding: EdgeInsets.only(top: isLoading ? 20.v : 0),
                child: CustomFilledButtonWidget(
                  onPressed: () {
                    pro.getAddressDetails(
                        context, context.read<GeocodingBloc>());
                  },
                  isLoading: isLoading,
                  defaultButtonStyle: true,
                  expandWidth: false,
                  child: const Text('Ger Address Details'),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}
