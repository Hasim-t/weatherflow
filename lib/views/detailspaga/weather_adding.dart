import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:weatherflow/models/weathermodel.dart';
import 'package:weatherflow/res/styles/colors.dart';

Widget elivatedbutton(
  BuildContext context,
  dynamic snapshot,
  dynamic controller,
) {
  return ElevatedButton.icon(
    onPressed: () {
      final weatherData = WeatherData.fromJson(snapshot.data!);

      controller.weatherController.addWeatherLocation(weatherData);
      Get.snackbar(
        'Success',
        'Location added to home screen',
        backgroundColor: CustomColors.blue.withOpacity(0.7),
        colorText: CustomColors.white,
      );
    },
    icon: const Icon(Icons.add),
    label: const Text('Add to Home Screen'),
    style: ElevatedButton.styleFrom(
      backgroundColor: CustomColors.blue,
      foregroundColor: CustomColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
