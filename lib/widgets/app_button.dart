import 'package:flutter/material.dart';
import 'package:hop_maldives_admin/configs/app_theme.dart';
import 'package:hop_maldives_admin/configs/app_dimensions.dart';

class AppButton extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;
  final Color? color;
  const AppButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        height: AppDimensions.normalize(19),
        width: double.infinity,
        decoration: BoxDecoration(
          color: color ?? AppTheme.c!.primary,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
