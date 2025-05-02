import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class InputField extends StatefulWidget {
  const InputField(
      {Key? key,
      this.labelText,
      this.errorText,
      this.onChanged,
      this.keyboardType,
      this.obscureText = false,
      this.controller,
      this.enabled,
      this.hintText,
      this.isCompact = true,
      this.drawErrorText = true,
      this.isErrorTextVisible = true,
      this.textInputAction = TextInputAction.next,
      this.inputFormatters,
      this.prefixIcon,
      this.focusNode,
      this.allocateSpaceForTextError = true})
      : super(key: key);
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextEditingController? controller;
  final bool? enabled;
  final bool isCompact;
  final bool isErrorTextVisible;
  final bool drawErrorText;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final bool allocateSpaceForTextError;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool? _obscureText = widget.obscureText ? true : null;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !(_obscureText ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    const errorBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(
          color: Color(0xffF13E3E),
          width: 1,
        ));
    const defaultBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(
          color: Color(0xff353535),
          width: 1,
        ));

    return TextField(
      autocorrect: false,
      enableSuggestions: false,
      inputFormatters: widget.inputFormatters,
      textInputAction: widget.textInputAction,
      enabled: widget.enabled,
      controller: widget.controller,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText ?? false,
      clipBehavior: Clip.none,
      style: context.bodyMedium?.copyWith(color: Colors.white),
      decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xff161616),
          isDense: widget.isCompact,
          floatingLabelStyle: MaterialStateTextStyle.resolveWith(
            (Set<MaterialState> states) {
              final Color color = states.contains(MaterialState.error)
                  ? const Color(0xffF13E3E)
                  : Colors.white;
              return TextStyle(
                  color: color, fontSize: 14, fontWeight: FontWeight.bold);
            },
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          suffixIcon: _obscureText != null
              ? IconButton(
                  splashRadius: 22,
                  icon: SvgPicture.asset(
                    _obscureText!
                        ? 'assets/icons/ic_eye_off.svg'
                        : 'assets/icons/ic_eye_on.svg',
                    color: Colors.white,
                  ),
                  onPressed: _toggle,
                )
              : null,
          hintText: widget.hintText ?? " ",
          prefixIconColor: MaterialStateColor.resolveWith(
              (states) => const Color(0xff9A9A9A)),
          prefixIcon: widget.prefixIcon,
          helperText: widget.allocateSpaceForTextError
              ? widget.isErrorTextVisible
                  ? ""
                  : null
              : null,
          errorText: widget.isErrorTextVisible
              ? widget.errorText
              : widget.errorText != null
                  ? ""
                  : null,
          labelText: widget.labelText,
          labelStyle: context.bodyMedium
              ?.copyWith(color: const Color(0xff989898), fontSize: 14),
          hintStyle: context.bodyMedium
              ?.copyWith(color: const Color(0xff989898), fontSize: 14),
          enabledBorder: defaultBorder,
          border: defaultBorder,
          disabledBorder: defaultBorder,
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(
                color: Color(0xff9AE343),
                width: 1,
              )),
          errorBorder: errorBorder,
          focusedErrorBorder: errorBorder,
          errorStyle: widget.isErrorTextVisible
              ? context.bodyMedium
                  ?.copyWith(color: const Color(0xffF13E3E), fontSize: 14)
              : context.bodyMedium?.copyWith(height: 0, fontSize: 0),
          helperStyle: context.bodyMedium
              ?.copyWith(color: const Color(0xff989898), fontSize: 14)),
    );
  }
}
