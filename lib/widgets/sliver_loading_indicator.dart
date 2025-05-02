import 'package:flutter/cupertino.dart';

import 'loading_indicator.dart';

class SliverLoadingIndicator extends StatelessWidget {
  const SliverLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      child: LoadingIndicator(),
    );
  }
}
