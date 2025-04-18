import 'package:canteens_fusion/core/providers/user_session_provider.dart';
import 'package:canteens_fusion/core/utils/bottom_sheets/bottom_sheet_utils.dart';
import 'package:canteens_fusion/core/utils/dialogs/dialogs_utils.dart';
import 'package:canteens_fusion/core/utils/navigation/navigation_pages_constants.dart';
import 'package:canteens_fusion/core/utils/navigation/navigation_utils.dart';
import 'package:canteens_fusion/core/utils/print_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../domain/use_cases/params/complete_profile_params.dart';
import '../bloc/complete_profile_bloc.dart';
import '../bloc/complete_profile_events.dart';
import '../bloc/complete_profile_states.dart';

class CompleteProfileProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;
  final _displayNameTextController = TextEditingController();
  TextEditingController get displayNameTextController =>
      _displayNameTextController;
  XFile? _imageFile;
  XFile? get imageFile => _imageFile;
  set _setImageFile(XFile file) {
    _imageFile = file;
    notifyListeners();
  }

  void pickImage(BuildContext context) {
    BottomSheetUtils.showPickImage(context, (file) async {
      _setImageFile = file;
    },
        cropStyle: CropStyle.circle,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
  }

  void completeProfile(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<CompleteProfileBloc>().add(CompleteProfileEvent(
          CompleteProfileParams(
              name: _displayNameTextController.text.trim().toString(),
              profileImage: imageFile,
              userType: context.read<UserSessionProvider>().userType)));
    }
  }

  void handleBlocStates(BuildContext context, CompleteProfileState state) {
    switch (state) {
      case CompleteProfileInitialState():
      case CompleteProfileLoadingState():
        printDebugMesg(
            dartFileName: runtimeType.toString(), msg: state.toString());
        break;
      case CompleteProfileLoadedState():
        context.read<UserSessionProvider>().setCurrentUser = state.user;
        NavigationUtils.navigate(
            context: context,
            commonNavigationPageType: CommonNavigationPageType.main,
            removePreviousPages: true);
        break;
      case CompleteProfileErrorState():
        DialogUtils.showErrorDialog(context, message: state.errorMsg);
        break;
    }
  }
}
