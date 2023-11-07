import 'package:flutter/material.dart';
import 'package:hop_maldives_admin/configs/space.dart';
import 'package:hop_maldives_admin/configs/ui_props.dart';
import 'package:hop_maldives_admin/configs/app_typography.dart';
import 'package:hop_maldives_admin/configs/app_dimensions.dart';
import 'package:hop_maldives_admin/animations/entrance_fader.dart';
import 'package:community_material_icon/community_material_icon.dart';

class OverlaySnackbar extends StatefulWidget {
  final bool success;
  final String message;
  const OverlaySnackbar({
    Key? key,
    required this.message,
    required this.success,
  }) : super(key: key);

  @override
  State<OverlaySnackbar> createState() => _OverlaySnackbarState();
}

class _OverlaySnackbarState extends State<OverlaySnackbar> {
  bool hasExit = false;

  void exit() {
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        hasExit = true;
      });
    });
  }

  @override
  void initState() {
    exit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: AppDimensions.normalize(10),
      right:
          hasExit ? -AppDimensions.normalize(150) : AppDimensions.normalize(5),
      child: EntranceFader(
        offset: Offset(AppDimensions.normalize(100), 0),
        duration: const Duration(milliseconds: 100),
        child: Material(
          child: Container(
            width: AppDimensions.normalize(100),
            padding: Space.all(),
            decoration: BoxDecoration(
              color: widget.success ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(
                UIProps.radius,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.success ? 'Success!' : 'Failure!',
                      style: AppText.b1b!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          hasExit = true;
                        });
                      },
                      icon: const Icon(
                        CommunityMaterialIcons.arrow_right,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Text(
                  widget.message,
                  style: AppText.l1!.copyWith(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
