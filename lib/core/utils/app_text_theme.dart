part of 'design_utils.dart';
class AppTextTheme{
  AppTextTheme._();

  static TextOverflow defaultOverflow = TextOverflow.ellipsis;
  static String get getSFProFontFamily => 'SFProText';

  static final text12 = TextStyle(
    color: AppColors.black,
    fontSize: 12,
    letterSpacing: -.24,
    overflow: defaultOverflow,
    fontWeight: FontWeight.w500,
    fontFamily: getSFProFontFamily,
    decoration: TextDecoration.none,
  );
  static final text14 = TextStyle(
    color: AppColors.black,
    fontSize: 14,
    letterSpacing: -.24,
    overflow: defaultOverflow,
    fontWeight: FontWeight.w500,
    fontFamily: getSFProFontFamily,
      decoration: TextDecoration.none,
  );
  static final text16 = TextStyle(
    color: AppColors.black,
    fontSize: 16,
    letterSpacing: -.24,
    overflow: defaultOverflow,
    fontWeight: FontWeight.w500,
    fontFamily: getSFProFontFamily,
      decoration: TextDecoration.none,
  );

  static final text18 = TextStyle(
    color: AppColors.black,
    fontSize: 18,
    letterSpacing: -.24,
    overflow: defaultOverflow,
    fontWeight: FontWeight.w500,
    fontFamily: getSFProFontFamily,
      decoration: TextDecoration.none,
  );

  static final text22 = TextStyle(
    color: AppColors.black,
    fontSize: 22,
    letterSpacing: -.24,
    overflow: defaultOverflow,
    fontWeight: FontWeight.w500,
    fontFamily: getSFProFontFamily,
      decoration: TextDecoration.none,
  );

  static final text24 = TextStyle(
    color: AppColors.black,
    fontSize: 24,
    letterSpacing: -.24,
    overflow: defaultOverflow,
    fontWeight: FontWeight.w500,
    fontFamily: getSFProFontFamily,
      decoration: TextDecoration.none,
  );
}