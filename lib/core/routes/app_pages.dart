import 'package:get/get.dart';
import 'package:to_do_list/controllers/edit_to_do_controller.dart';
import 'package:to_do_list/controllers/home_page_controller.dart';
import 'package:to_do_list/controllers/start_up_controller/onboarding_page_controller.dart';
import 'package:to_do_list/controllers/start_up_controller/splash_page_controller.dart';
import 'package:to_do_list/views/edit_to_do_page.dart';
import 'package:to_do_list/views/home_page.dart';
import 'package:to_do_list/views/stat_up_pages/onboarding_page.dart';
import 'package:to_do_list/views/stat_up_pages/splash_page.dart';
import 'package:to_do_list/views/unknow_route_page.dart';

part 'app_routes.dart';

class AppPages {
  static final unknownRoute = GetPage(
    name: _Paths.unknown404,
    page: () => const Unknown404Screen(),
  );
  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: _Paths.splash,
      page: () => const SplashPage(),
      binding: BindingsBuilder(
            () => Get.lazyPut<SplashPageController>(() => SplashPageController()),
      ),
    ),
    GetPage(
      name: _Paths.onboarding,
      page: () => const OnboardingPage(),
      binding: BindingsBuilder(
            () => Get.lazyPut<OnboardingPageController>(() => OnboardingPageController()),
      ),
    ),
    GetPage(
      name: _Paths.home,
      page: () => const HomePage(),
      binding: BindingsBuilder(
            () => Get.lazyPut<HomePageController>(() => HomePageController()),
      ),
      children: [
        GetPage(
          name: _Paths.editToDo,
          page: () => const EditToDoPage(),
          binding: BindingsBuilder(
                () => Get.lazyPut<EditToDoPageController>(() => EditToDoPageController()),
          ),
        ),
      ],
    ),
  ];
}

class BindingsX {
  static BindingsBuilder initialBindigs() {
    return BindingsBuilder(() {});
  }
}
