part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const unknown404 = _Paths.unknown404;
  static const splash = _Paths.splash;
  static const onboarding = _Paths.onboarding;
  static const home = _Paths.home;
  static const editToDo = home + _Paths.editToDo;
 }

abstract class _Paths {
  static const unknown404 = '/404';
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const editToDo = '$home/editToDo';
}
