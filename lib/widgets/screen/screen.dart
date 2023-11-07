import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  final Widget child;
  final bool? success;
  final String? message;
  final List<Widget>? overlaySnackbar;
  const Screen({
    Key? key,
    required this.child,
    this.message,
    this.success,
    this.overlaySnackbar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          child,
          ...overlaySnackbar ?? [],
        ],
      ),
    );
  }
}
