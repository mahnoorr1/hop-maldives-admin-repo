import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hop_maldives_admin/configs/configs.dart';

class CustomTextField extends StatefulWidget {
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final String name;
  final bool? enabled;
  final FocusNode? node;
  final String? hint;
  final double? width;
  final bool? isPass;
  final Widget? prefixIcon;
  final bool? isSuffixIcon;
  final String? initialValue;

  final String? Function(String?)? validatorFtn;
  final String? Function(String?)? onChangeFtn;

  const CustomTextField({
    Key? key,
    this.enabled,
    this.initialValue,
    this.validatorFtn,
    this.onChangeFtn,
    this.prefixIcon,
    this.isSuffixIcon = false,
    this.isPass = false,
    this.width = double.infinity,
    this.textInputAction = TextInputAction.done,
    this.node,
    required this.name,
    required this.hint,
    required this.textInputType,
  }) : super(key: key);

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool _showPass = false;

  @override
  void initState() {
    _showPass = widget.isPass!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.normalize(250),
      child: FormBuilderTextField(
        enabled: widget.enabled ?? true,
        initialValue: widget.initialValue,
        name: widget.name,
        autofocus: false,
        textInputAction: widget.textInputAction,
        keyboardType: widget.textInputType,
        focusNode: widget.node,
        obscureText: _showPass,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isPass!
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _showPass = !_showPass;
                    });
                  },
                  icon: Icon(
                    !_showPass
                        ? CommunityMaterialIcons.eye
                        : CommunityMaterialIcons.eye_off,
                  ),
                )
              : null,
          filled: true,
          contentPadding: Space.all(0.75, 0.9),
          hintText: widget.hint,
          hintStyle: AppText.l1!.copyWith(
            color: AppTheme.c!.textSub2,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: AppTheme.c!.primary!,
              width: AppDimensions.normalize(0.75),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.red.withAlpha(200),
              width: AppDimensions.normalize(0.75),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.red.withAlpha(200),
              width: AppDimensions.normalize(0.75),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              width: AppDimensions.normalize(0.75),
              color: AppTheme.c!.textSub!.withAlpha(100),
            ),
          ),
        ),
        validator: widget.validatorFtn,
        onChanged: widget.onChangeFtn,
      ),
    );
  }
}
