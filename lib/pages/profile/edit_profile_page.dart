import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_better_united/constants/extended_theme.dart';
import 'package:flutter_better_united/widgets/input_field.dart';
import 'package:flutter_better_united/widgets/primary_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../figma/colors.dart';
import '../../util/betterUnited_icons.dart';
import '../../widgets/crop_picture_page.dart';
import '../../widgets/fixed_button.dart';
import '../../widgets/regular_app_bar.dart';
import '../shop/user_provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();

  static Route route() {
    return CupertinoPageRoute(
      fullscreenDialog: true,
      builder: (_) => const EditProfilePage(),
    );
  }
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = context.read<UserProvider>();
    _textEditingController.text = provider.user?.nickname ?? "";
    provider.isNicknameInUse = false;
    provider.profilePicture = null;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: PrimaryButton(
          text: "save_changes_profile".tr(),
          onPressed: () {
            _onSaveChangesTap();
          },
        ),
      ),
      appBar: RegularAppBar(
        suffixIcon: FixedButton(
          iconData: BetterUnited.remove,
          onTap: () {
            context.pop();
          },
        ),
        prefixIcon: Row(
          children: [
            const Icon(
              BetterUnited.profile,
              color: AppColors.primary,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              "edit_profile".tr().toUpperCase() ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  shadows: [
                    Shadow(
                      offset: Offset(0, 2),
                      blurRadius: 16,
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                    ),
                  ],
                  fontSize: 18,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 32,
            ),
            Align(
              child: _ImagePicker(
                size: 136,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              "enterUniqueName".tr(),
              style: context.labelSemiBold,
            ),
            const SizedBox(
              height: 32,
            ),
            _InputField(textEditingController: _textEditingController),
          ],
        ),
      ),
    );
  }

  _onSaveChangesTap() async {
    await context
        .read<UserProvider>()
        .updateProfile(_textEditingController.text);

    context.pop();
  }
}

class _ImagePicker extends StatelessWidget {
  final double size;

  _ImagePicker({Key? key, required this.size}) : super(key: key);
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final image = context.watch<UserProvider>().profilePicture;
    final url = context.read<UserProvider>().user?.profilePictureUrl;
    return SizedBox(
      width: size,
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            _Avatar(
              url: url,
              image: image,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Transform.translate(
                offset: const Offset(0, 4),
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
                color: Colors.blue, fontWeight: FontWeight.w500),
          ),
          onPressed: (_) => _onPhotoChosen(context, ImageSource.camera),
        ),
        BottomSheetAction(
          title: Text(
            "choosePhoto".tr(),
            style: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w500),
          ),
          onPressed: (_) => _onPhotoChosen(context, ImageSource.gallery),
        ),
      ],
      cancelAction: CancelAction(
        title: Text(
          "cancel".tr(),
          style:
              const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
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
    context.read<UserProvider>().setProfileImage(result);
  }
}

class _Avatar extends StatelessWidget {
  final String? url;
  final ImageProvider? image;

  const _Avatar({
    this.url,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return image != null
        ? PlaceHolder(
            imageProvider: image,
          )
        : url == null
            ? PlaceHolder(
                imageProvider: image,
              )
            : CachedNetworkImage(
                imageUrl: url!,
                imageBuilder: (context, imageProvider) => PlaceHolder(
                  imageProvider: imageProvider,
                ),
                placeholder: (context, url) => const PlaceHolder(),
                errorWidget: (context, url, error) => const PlaceHolder(),
              );
  }
}

class PlaceHolder extends StatelessWidget {
  const PlaceHolder({Key? key, this.imageProvider}) : super(key: key);
  final ImageProvider? imageProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: imageProvider != null
          ? BoxDecoration(
              border: Border.all(color: const Color(0xffD8D8D8), width: 2),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imageProvider!,
                fit: BoxFit.cover,
              ),
            )
          : const BoxDecoration(
              color: AppColors.secondary,
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/profile_placeholder.png"),
              ),
            ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required TextEditingController textEditingController,
  }) : _textEditingController = textEditingController;

  final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    final isNicknameInUse = context.watch<UserProvider>().isNicknameInUse;
    return InputField(
      labelText: "nickname_profile".tr(),
      controller: _textEditingController,
      errorText: isNicknameInUse ? "nicknameAlreadyTaken".tr() : null,
    );
  }
}
