import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/widgets/crop_picture_page.dart';
import 'package:flutter_better_united/widgets/onboarding_buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../widgets/fixed_button.dart';
import '../../widgets/title_subtitle.dart';
import 'create_profile_provider.dart';

class SelectPicturePage extends StatelessWidget {
  SelectPicturePage({
    Key? key,
  }) : super(key: key);
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final ProfileProvider profileProvider = context.read();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              alignment: const FractionalOffset(0.5, 0.2),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Selector<ProfileProvider, MemoryImage?>(
                      selector: (p0, p1) => p1.profilePicture,
                      builder: (context, image, child) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          HeaderTitle(
                            title: "setProfilePictureTitle".tr(),
                            subTitle: "setProfilePictureSubtitle".tr(),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.height * 0.25,
                            height: MediaQuery.of(context).size.height * 0.25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xff353535),
                              image: image == null
                                  ? const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          "assets/images/profile_placeholder.png"),
                                    )
                                  : DecorationImage(
                                      fit: BoxFit.fill,
                                      image: image,
                                    ),
                            ),
                            child: Align(
                              alignment: const FractionalOffset(0.92, 0.95),
                              child: FixedButton(
                                drawGradient: false,
                                size: 18,
                                iconData: Icons.camera_alt,
                                onTap: () => _showImagePickerSheet(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Selector<ProfileProvider, bool>(
            selector: (p0, p1) => p1.profilePicture != null,
            builder: (context, isProfilePictureAdded, child) =>
                OnboardingButtons(
              onBackPressed: () {
                profileProvider.onBackClicked();
              },
              primaryButtonText:
                  isProfilePictureAdded ? "next".tr() : "skip".tr(),
              onPressed: () {
                profileProvider.onPictureStep();
              },
            ),
          ),
        ],
      ),
    );
  }

  _showImagePickerSheet(BuildContext context) {
    showAdaptiveActionSheet(
      bottomSheetColor: const Color(0xff2E2E2E),
      barrierColor: const Color(0xff2E2E2E),
      isDismissible: true,
      context: context,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Text(
          "profilePicture".tr(),
          style: const TextStyle(
              color: Color(0xff8f8f8f), fontWeight: FontWeight.bold),
        ),
      ),
      actions: <BottomSheetAction>[
        BottomSheetAction(
          title: Text(
            "takePhoto".tr(),
            style: const TextStyle(
                color: AppColors.blue, fontWeight: FontWeight.w500),
          ),
          onPressed: (_) => _onPhotoChosen(context, ImageSource.camera),
        ),
        BottomSheetAction(
          title: Text(
            "choosePhoto".tr(),
            style: const TextStyle(
                color: AppColors.blue, fontWeight: FontWeight.w500),
          ),
          onPressed: (_) => _onPhotoChosen(context, ImageSource.gallery),
        ),
      ],
      cancelAction: CancelAction(
        title: Text(
          "cancel".tr(),
          style: const TextStyle(
              color: AppColors.blue, fontWeight: FontWeight.w500),
        ),
      ), // onPressed parameter is optional by default will dismiss the ActionSheet
    );
  }

  _onPhotoChosen(BuildContext context, ImageSource imageSource) async {
    context.pop();
    final XFile? image = await _picker.pickImage(
        source: imageSource, maxWidth: 1280, maxHeight: 720);
    if (image == null) {
      return;
    }
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => CropPicturePage(image.path),
        fullscreenDialog: true,
      ),
    );
    context.read<ProfileProvider>().setProfileImage(result);
  }
}
