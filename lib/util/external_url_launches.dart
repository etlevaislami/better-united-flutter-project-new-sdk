import 'package:url_launcher/url_launcher.dart';

import '../flavors.dart';
import '../run.dart';

Future<void> _launchUrl(Uri uri) async {
  if (!await launchUrl(uri)) {
    logger.e("cannot launch url");
  }
}

Future<void> launchTermsAndConditionUrl() async {
  await _launchUrl(Uri.parse(F.termsAndConditionUrl));
}

Future<void> launchPrivacyPolicyUrl() async {
  await _launchUrl(Uri.parse(F.privacyPolicyUrl));
}

Future<void> launchBookmakersUrl() async {
  await _launchUrl(Uri.parse(F.bookmakersUrl));
}
