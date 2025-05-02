import 'package:flutter/material.dart';

class FeedCategory extends StatelessWidget {
  const FeedCategory({
    Key? key,
    required this.text,
    required this.child,
    required this.isActive,
  }) : super(key: key);
  final String text;
  final Widget child;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 180,
      width: 88,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        gradient: isActive
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFAAE15E),
                  Color(0xff535353),
                ],
              )
            : null,
        color: const Color(0xff535353),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff535353),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  clipBehavior: Clip.none,
                  decoration: BoxDecoration(
                      gradient: isActive
                          ? const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Color(0xFFAAE15E)],
                            )
                          : null,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: SizedBox(
                    child: child,
                  ),
                )),
            Expanded(
                flex: 3,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xff1D1D1D)
                          : const Color(0xff353535),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8))),
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 12),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
