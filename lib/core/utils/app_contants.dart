part of 'design_utils.dart';

bool isNullEmptyOrFalse(dynamic o) {
  if (o is Map<String, dynamic> || o is List<dynamic>) {
    return o == null || o.length == 0;
  }
  return o == null || o == false || o == "";
}

extension WidgetExtension on Widget {
  List<BoxShadow> get containerShadow => const [
        BoxShadow(
          blurRadius: 10,
          offset: Offset(0, 4),
          color: Color(0x0f00498a),
        ),
      ];

  Divider defaultDivider({double? thickness, Color? color, double? height}) {
    return Divider(
        thickness: thickness ?? 1,
        color: color ?? AppColors.greyOpacity08,
        height: height ?? 20);
  }

  Container defaultContainer({
    double hP = 10,
    double vP = 10,
    double vM = 0,
    double hM = 0,
    Color? backgroundColor,
    double borderRadius = 10.0,
  }) =>
      Container(
        decoration: BoxDecoration(
          boxShadow: containerShadow,
          color: backgroundColor ?? AppColors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.symmetric(horizontal: hP, vertical: vP),
        margin: EdgeInsets.symmetric(horizontal: hM, vertical: vM),
        child: this,
      );

  Widget defaultLoader({
    Color? color,
    double? radius,
  }) =>
      Center(
        child: CupertinoActivityIndicator(
          color: color ?? AppColors.white,
          radius: radius ?? 10.0,
        ),
      );
  Widget defaultFloatingActionButton({
    Color? iconColor,
    double? iconSize,
    required void Function() onPressed,
    IconData? icon,
  }) =>
      FloatingActionButton(
        onPressed: onPressed,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.white,
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.gradientStartColor,
                AppColors.gradientEndColor,
              ],
            ),
          ),
          child:  Icon(icon ?? Icons.add, size: iconSize, color: iconColor,),
        ),
      );
}

extension StringExtension on String {
  dynamic errorSnackBar() {
    Get
      ..closeAllSnackbars()
      ..snackbar(
        'Error !',
        this,
        backgroundColor: AppColors.redAccent,
        colorText: AppColors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      );
  }

  dynamic successSnackBar({void Function(GetSnackBar)? onTap}) {
    Get
      ..closeAllSnackbars()
      ..snackbar(
        'Success !',
        this,
        onTap: onTap,
        backgroundColor: AppColors.green,
        colorText: AppColors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      );
  }

  dynamic infoSnackBar() {
    Get
      ..closeAllSnackbars()
      ..snackbar(
        'Info !',
        this,
        colorText: AppColors.black,
        backgroundColor: AppColors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      );
  }
}
Matrix4 getTransformMatrix(TransformableListItem item) {
  /// final scale of child when the animation is completed
  const endScaleBound = 0.9;

  /// 0 when animation completed and [scale] == [endScaleBound]
  /// 1 when animation starts and [scale] == 1
  final animationProgress = item.visibleExtent / item.size.height;

  /// result matrix
  final paintTransform = Matrix4.identity();

  /// animate only if item is on edge
  if (item.position != TransformableListItemPosition.middle) {
    final scale = endScaleBound + ((1 - endScaleBound) * animationProgress);

    paintTransform
      ..translate(item.size.width / 2)
      ..scale(scale)
      ..translate(-item.size.width / 2);
  }

  return paintTransform;
}
