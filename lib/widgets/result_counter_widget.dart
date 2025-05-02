import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../constants/app_colors.dart';

class ResultCounterWidget extends StatelessWidget {
  const ResultCounterWidget({Key? key, required this.count}) : super(key: key);
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.ceramic,
      padding: const EdgeInsets.only(left: 24, bottom: 24),
      child: Text("resultFound".plural(count),
          style: context.titleSmall?.copyWith(fontSize: 14)),
    );
  }
}
