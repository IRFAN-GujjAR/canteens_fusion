import 'package:canteens_fusion/core/constants/images_constants.dart';
import 'package:canteens_fusion/core/utils/common_utils.dart';
import 'package:canteens_fusion/core/utils/form_validation/form_validation_utils.dart';
import 'package:canteens_fusion/core/utils/provider_utils.dart';
import 'package:canteens_fusion/core/utils/size_utils.dart';
import 'package:canteens_fusion/core/widgets/custom_filled_button_widget.dart';
import 'package:canteens_fusion/core/widgets/custom_text_button_widget.dart';
import 'package:canteens_fusion/core/widgets/custom_text_form_field.dart';
import 'package:canteens_fusion/core/widgets/jumping_dots_animation_widget.dart';
import 'package:canteens_fusion/features/common/geocoding/presentation/blocs/geocoding_bloc.dart';
import 'package:canteens_fusion/features/common/geocoding/presentation/blocs/geocoding_states.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/presentation/providers/add_canteen_address_provider.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/presentation/providers/add_canteen_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

part '../../widgets/add_canteen_address_widget.dart';
part '../../widgets/canteen_address_placeholder_widget.dart';

class AddCanteenAddressPage extends StatelessWidget {
  const AddCanteenAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final canteenDetailsProvider = ProviderUtils<AddCanteenDetailsProvider>()
        .getProvider(context: context);
    return Scaffold(
      appBar: AppBar(title: const Text('Address Details')),
      body: SingleChildScrollView(
        padding: getScreenPadding(),
        child: BlocConsumer<GeocodingBloc, GeocodingState>(
          listener: (context, state) {
            canteenDetailsProvider.handleGeocodingBlocState(context, state);
          },
          builder: (context, state) {
            if (state is GeocodingStateLoaded ||
                (!canteenDetailsProvider.isCurrentLocationFetching &&
                    canteenDetailsProvider.addressEntity != null)) {
              return const AddCanteenAddressWidget();
            } else {
              return const CanteenAddressPlaceholderWidget();
            }
          },
        ),
      ),
    );
  }
}
