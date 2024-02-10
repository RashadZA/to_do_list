import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/core/utils/design_utils.dart';
import 'package:to_do_list/core/widgets/buttons/core_button.dart';

class CoreFlatButton extends StatelessWidget {
  final String text;
  final IconData? prefixIcon;
  final double? prefixIconSize;
  final Color? prefixIconColor;
  final double? width;
  final double height;
  final Color? bgColor;
  final double? fontSize;
  final Color? textColor;
  final BoxBorder? border;
  final Color? loaderColor;
  final bool isLoading;
  final IconData? suffixIcon;
  final double? suffixIconSize;
  final Color? suffixIconColor;
  final bool isGradientBg;
  final bool isDisabled;
  final EdgeInsets padding;
  final double borderRadius;
  final void Function()? onPressed;
  const CoreFlatButton({
    Key? key,
    this.prefixIcon,
    this.prefixIconSize,
    this.prefixIconColor,
    this.border,
    this.bgColor,
    this.textColor,
    this.onPressed,
    this.fontSize,
    this.suffixIcon,
    this.suffixIconSize,
    this.suffixIconColor,
    this.loaderColor,
    required this.text,
    this.isLoading = false,
    this.isDisabled = false,
    this.borderRadius = 16.0,
    this.isGradientBg = false,
    this.width = double.infinity,
    this.height = 56,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CoreButton(
      color: bgColor,
      onPressed: isLoading ? null : onPressed,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Opacity(
        opacity: isDisabled || onPressed == null ? 0.5 : 1,
        child: Container(
          width: width,
          height: height,
          padding: padding,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: border,
            gradient: isGradientBg
                ? const LinearGradient(
                    colors: [
                      AppColors.gradientStartColor,
                      AppColors.gradientEndColor
                    ],
                  )
                : null,
            color: bgColor ?? AppColors.primaryColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                defaultLoader(color: loaderColor ?? AppColors.white)
              else ...[
                if (prefixIcon != null)
                  Icon(
                    prefixIcon,
                    size: prefixIconSize,
                    color: prefixIconColor,
                  ).paddingOnly(right: 8),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: AppTextTheme.text18.copyWith(
                    fontSize: fontSize,
                    letterSpacing: -0.24,
                    fontWeight: FontWeight.w600,
                    color: textColor ?? AppColors.appTextPrimaryColor,
                  ),
                ),
                if (suffixIcon != null)
                  Icon(
                    suffixIcon,
                    size: suffixIconSize,
                    color: suffixIconColor,
                  ).paddingOnly(left: 8),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
