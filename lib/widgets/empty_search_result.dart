import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptySearchResult extends StatelessWidget {
  const EmptySearchResult({Key? key, required this.query, required this.text})
      : super(key: key);
  final String query;
  final String text;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) {
        return SizedBox(
          width: p1.maxWidth * 0.75,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/bu_bubble.png",
                height: 90,
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "‘$query’",
                    style: context.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: " ",
                        style: context.titleSmall,
                      ),
                      TextSpan(
                        text: text,
                        style: context.titleSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
