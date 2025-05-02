import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  final String title;
  final String subTitle;

  const HeaderTitle({Key? key, required this.title, required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 16),
            child: Text(title,
                textAlign: TextAlign.center,
                style: context.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Text(
              subTitle,
              textAlign: TextAlign.center,
              style: context.titleSmall,
            ),
          )
        ],
      ),
    );
  }
}
