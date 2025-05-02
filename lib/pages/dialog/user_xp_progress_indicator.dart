import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../widgets/progress_indicator.dart';
import '../shop/user_provider.dart';

class UserXpProgressIndicator extends StatelessWidget {
  const UserXpProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return ProgressPercentIndicator(
      percent: user == null
          ? 0
          : user.nextLevelExpAmount == 0
              ? 1
              : user.expAmount / user.nextLevelExpAmount,
    );
  }
}
