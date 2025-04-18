import 'package:canteens_fusion/core/utils/common_utils.dart';
import 'package:canteens_fusion/core/utils/print_utils.dart';
import 'package:canteens_fusion/core/utils/provider_utils.dart';
import 'package:canteens_fusion/core/utils/size_utils.dart';
import 'package:canteens_fusion/core/widgets/custom_filled_button_widget.dart';
import 'package:canteens_fusion/core/widgets/jumping_dots_animation_widget.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/presentation/blocs/add_canteen_details_bloc.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/presentation/providers/add_canteen_address_provider.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/presentation/providers/add_canteen_details_provider.dart';
import 'package:canteens_fusion/features/main/owner/add_canteen_details/presentation/providers/canteen_polygon_area_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class CanteenPolygonAreaPage extends StatelessWidget {
  const CanteenPolygonAreaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Canteen Area'),
      ),
      body: BlocListener<AddCanteenDetailsBloc, AddCanteenDetailsState>(
        listener: (context, state) {
          context
              .read<CanteenPolygonAreaProvider>()
              .handleAddCanteenDetailsBlocState(context, state);
        },
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 10.v,
                ),
                Padding(
                  padding: getScreenPadding(includeTopPadding: false),
                  child: const Text(
                    'Please set boundaries of your canteen. Please carefully set canteen boundaries as users only inside these'
                    ' boundaries will be able to place order from your canteen. Long press on one of the red boundary icon to drag it to'
                    ' cover the area.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 10.v,
                ),
                Expanded(
                  child: Consumer<CanteenPolygonAreaProvider>(
                      builder: (context, pro, _) {
                    return GoogleMap(
                        onMapCreated: (controller) {
                          context
                              .read<CanteenPolygonAreaProvider>()
                              .onMapCreated(
                                  context,
                                  controller,
                                  context
                                      .read<AddCanteenAddressProvider>()
                                      .currentLocation);
                        },
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(33.6909914121585, 73.05658224572745),
                          zoom: 17,
                        ),
                        markers: pro.polygonUtils.markers,
                        polygons: pro.polygonUtils.polygon);
                  }),
                ),
                SizedBox(
                  height: 20.v,
                ),
                Consumer<CanteenPolygonAreaProvider>(
                    builder: (context, pro, _) {
                  if (pro.isMapLoading) {
                    return Container();
                  }
                  return BlocBuilder<AddCanteenDetailsBloc,
                      AddCanteenDetailsState>(
                    builder: (context, state) {
                      return CustomFilledButtonWidget(
                          bottomButton: true,
                          enableJumpingDotAnimation: false,
                          isLoading: state is AddCanteenDetailsStateAdding,
                          onPressed: () {
                            pro.onFinishPressed(context);
                          },
                          child: const Text('Finish'));
                    },
                  );
                })
              ],
            ),
            BlocBuilder<AddCanteenDetailsBloc, AddCanteenDetailsState>(
              builder: (context, state) {
                if (state is AddCanteenDetailsStateAdding) {
                  return Container(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    color: Colors.grey[100]?.withOpacity(0.5),
                    child: const Center(
                      child: JumpingDotsAnimationWidget(),
                    ),
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
