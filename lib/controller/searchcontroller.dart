import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:weatherflow/models/weathermodel.dart';
import 'package:weatherflow/repository/deboucer.dart';
import 'package:weatherflow/res/styles/colors.dart';

class SearchController extends GetxController {
  final Debouncer _debouncer = Debouncer(miliscecond: 500);
  final TextEditingController searchController = TextEditingController();
  final RxString location = ''.obs;
  

  final WeatherController weatherController = Get.put(WeatherController());

  void updateLocation(String value) {
    _debouncer.run(() {
      location.value = value;
    });
  }

  void addLocationToHome(Map<String, dynamic> data) {
    final weatherData = WeatherData.fromJson(data);
    weatherController.addWeatherLocation(weatherData);
    Get.snackbar(
      'Success',
      'Location added to home screen',
      backgroundColor: CustomColors.blue.withOpacity(0.7),
      colorText: CustomColors.white,
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
class WeatherController extends GetxController {
  final RxList<WeatherData> savedLocations = <WeatherData>[].obs;

  void addWeatherLocation(WeatherData weather) {
    savedLocations.add(weather);
    update();
  }

  void removeWeatherLocation(int index) {
    savedLocations.removeAt(index);
    update();
  }
}