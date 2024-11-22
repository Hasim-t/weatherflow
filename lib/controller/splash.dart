import 'package:get/get.dart';
import 'package:weatherflow/views/detailspaga/searchpage.dart';


class SplashscreenController extends GetxController {
  @override
  void onReady() {
    splashnavigator();
  

    super.onReady();
  }

  Future splashnavigator() async {
    await Future.delayed(const Duration(seconds: 3));

    Get.off(Searchpage());
  }
}
