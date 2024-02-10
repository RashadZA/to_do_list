import 'package:flutter/cupertino.dart';
import 'package:to_do_list/core/utils/design_utils.dart';

class CoreButton extends CupertinoButton {
  const CoreButton({
    Key? key,
    Color? color,
    required Widget child,
    void Function()? onPressed,
    AlignmentGeometry alignment = Alignment.center,
    EdgeInsetsGeometry? padding = EdgeInsets.zero,
    BorderRadius? borderRadius =
        const BorderRadius.all(Radius.circular(10.0)),
  }) : super(
          key: key,
          minSize: 0,
          color: color,
          child: child,
          padding: padding,
          alignment: alignment,
          onPressed: onPressed,
          borderRadius: borderRadius,
          disabledColor: AppColors.transparent,
          pressedOpacity: 0.6,
        );
}
