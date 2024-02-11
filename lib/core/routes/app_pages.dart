import 'package:get/get.dart';
import 'package:to_do_list/features/home/presentation/controllers/edit_to_do_controller.dart';
import 'package:to_do_list/features/home/presentation/controllers/home_page_controller.dart';
import 'package:to_do_list/features/home/presentation/views/edit_to_do_page.dart';
import 'package:to_do_list/features/home/presentation/views/home_page.dart';
import 'package:to_do_list/features/startUp/controller/onboarding_page_controller.dart';
import 'package:to_do_list/features/startUp/controller/splash_page_controller.dart';
import 'package:to_do_list/features/startUp/views/splash_page.dart';
import 'package:to_do_list/features/startUp/views/onboarding_page.dart';
import 'package:to_do_list/core/routes/unknow_route_page.dart';

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
