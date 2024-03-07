import 'package:flutter/material.dart';

class DialogWrapper extends StatelessWidget {
  final Widget child;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  ///Make dialog wrap content,usually use on showDialog
  const DialogWrapper({
    super.key,
    required this.child,
    this.radius,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: padding ?? const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 6),
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  offset: const Offset(1, 1),
                  spreadRadius: 1,
                  color: Colors.white.withOpacity(0.2))
            ],
          ),
          child: child,
        )
      ],
    );
  }
}
