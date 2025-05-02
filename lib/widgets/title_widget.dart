import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key, this.title, this.subtitle, this.citation})
      : super(key: key);
  final String? title;
  final String? subtitle;
  final String? citation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 42, bottom: 40),
          alignment: Alignment.center,
          width: double.infinity,
          child: Column(
            children: [
              title == null
                  ? const SizedBox()
                  : Text(
                      title!,
                      style: context.titleMedium,
                    ),
              subtitle == null
                  ? const SizedBox()
                  : SizedBox(
                      width: double.infinity,
                      child: Text(
                        subtitle!,
                        style: context.bodyMedium,
                      )),
              SizedBox(height: (citation != null && subtitle != null) ? 15 : 0),
              citation == null
                  ? const SizedBox()
                  : SizedBox(
                      width: double.infinity,
                      child: Text(
                        citation!,
                        style: context.bodyMedium,
                        textAlign: TextAlign.left,
                      )),
            ],
          ),
        ),
      ],
    );
  }
}
