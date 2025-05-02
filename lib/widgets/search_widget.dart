import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../util/common_ui.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget(
      {Key? key,
      this.hintText,
      this.onChanged,
      this.textEditingController,
      this.isEnabled = true})
      : super(key: key);
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final bool isEnabled;

  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18, top: 15, bottom: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: appBoxShadow,
        borderRadius: BorderRadius.all(
          Radius.circular(7),
        ),
      ),
      child: Row(children: [
        SvgPicture.asset("assets/images/ic_search.svg"),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: TextField(
            enabled: isEnabled,
            controller: textEditingController,
            textInputAction: TextInputAction.next,
            style: context.bodyMedium,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusColor: Colors.black,
              hintText: hintText,
            ),
            onChanged: onChanged,
          ),
        )
      ]),
    );
  }
}
