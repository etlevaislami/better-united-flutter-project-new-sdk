import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class OfferDescription extends StatelessWidget {
  const OfferDescription({
    super.key,
    required this.htmlContent,
  });

  final String htmlContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xff1D1D1D),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Html(
        data: htmlContent,
        style: {
          'body': Style(
            padding: HtmlPaddings.zero,
            margin: Margins.zero,
            fontSize: FontSize(14),
            color: Colors.white,
          ),
        },
      ),
    );
  }
}
