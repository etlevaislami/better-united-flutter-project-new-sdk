import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton(
      {Key? key,
      required this.text,
      this.onPressed,
      this.withBorders = true,
      this.backgroundColor = const Color(0xff9AE343),
      this.withUnderline = false,
      this.drawShadow = true})
      : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final bool withBorders;
  final Color? backgroundColor;
  final bool withUnderline;
  final bool drawShadow;

  const SecondaryButton.labelText(String text,
      {Key? key, VoidCallback? onPressed, bool withUnderline = false})
      : this(
            key: key,
            text: text,
            onPressed: onPressed,
            withBorders: false,
            backgroundColor: null,
            withUnderline: withUnderline,
            drawShadow: false);

  @override
  Widget build(BuildContext context) {
    final opacity = onPressed == null ? 0.23 : 1.0;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(4),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          boxShadow: drawShadow
              ? [
                  const BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    offset: Offset(0, 2),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(8.0),
          gradient: withBorders
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF7B7B7B).withOpacity(opacity),
                    const Color(0xFF454545).withOpacity(opacity)
                  ],
                )
              : null,
        ),
        child: SizedBox(
          height: 48,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:
                  onPressed != null ? backgroundColor : const Color(0xff353535),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              text.toUpperCase(),
              style: TextStyle(
                  fontSize: 14,
                  color: onPressed == null
                      ? const Color(0xff282828)
                      : Colors.white,
                  decorationThickness: 3,
                  height: 1.5,
                  fontStyle: FontStyle.italic,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 2),
                      blurRadius: 16,
                    ),
                  ],
                  decoration: withUnderline
                      ? TextDecoration.underline
                      : TextDecoration.none,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        width: double.infinity,
      ),
    );
  }
}
