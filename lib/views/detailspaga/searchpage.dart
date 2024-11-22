import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherflow/controller/searchcontroller.dart';
import 'package:weatherflow/models/weathermodel.dart';
import 'package:weatherflow/repository/deboucer.dart';
import 'package:weatherflow/repository/weatherapi.dart';
import 'package:weatherflow/res/styles/colors.dart';
import 'package:weatherflow/views/detailspaga/weatherdeatils.dart';
import 'package:weatherflow/views/home/home_screen.dart';


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

class Searchpage extends GetView<SearchController> {
  const Searchpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (!Get.isRegistered<SearchController>()) {
      Get.put(SearchController());
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.black,
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.searchController,
                style: const TextStyle(color: CustomColors.white),
                onChanged: controller.updateLocation,
                decoration: const InputDecoration(
                  fillColor: CustomColors.white,
                  labelStyle: TextStyle(color: CustomColors.white),
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.white,
                  hintStyle: TextStyle(color: CustomColors.white),
                  hintText: 'Enter the Location',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => FutureBuilder<Map<String, dynamic>?>(
                          future: fetchtherealtime(controller.location.value),
                          builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: CustomColors.white,
                            ),
                          );
                        }

                        if (snapshot.hasError ||
                            !snapshot.hasData ||
                            snapshot.data == null) {
                          return const Center(
                            child: Text(
                              'Unable to fetch weather data.\nPlease check your location and try again.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: CustomColors.white,
                                fontSize: 16,
                              ),
                            ),
                          );
                        }

                        final data = snapshot.data!;
                        final locationData =
                            data['location'] as Map<String, dynamic>?;
                        final current =
                            data['current'] as Map<String, dynamic>?;

                        if (locationData == null || current == null) {
                          return const Center(
                            child: Text(
                              'Enter the location',
                              style: TextStyle(
                                color: CustomColors.white,
                                fontSize: 16,
                              ),
                            ),
                          );
                        }

                        return GestureDetector(
                          onTap: () {
                            Get.to(HomeScreen());
                          },
                          child: Container(
                            height: 450,
                            width: 300,
                            decoration: BoxDecoration(
                              color: CustomColors.purple,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 20),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: CustomColors.white,
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              locationData['name']
                                                      ?.toString() ??
                                                  'Unknown Location',
                                              style: const TextStyle(
                                                color: CustomColors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        locationData['country']?.toString() ??
                                            '',
                                        style: const TextStyle(
                                          color: CustomColors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Text(
                                  '${current['temperature']?.toString() ?? 'N/A'}°C',
                                  style: const TextStyle(
                                    color: CustomColors.white,
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  (current['weather_descriptions'] as List?)
                                          ?.firstOrNull
                                          ?.toString() ??
                                      'No description',
                                  style: const TextStyle(
                                    color: CustomColors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 30),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    children: [
                                      buildWeatherDetailRow(
                                        'Feels Like',
                                        '${current['feelslike']?.toString() ?? 'N/A'}°C',
                                      ),
                                      buildWeatherDetailRow(
                                        'Humidity',
                                        '${current['humidity']?.toString() ?? 'N/A'}%',
                                      ),
                                      buildWeatherDetailRow(
                                        'Wind',
                                        '${current['wind_speed']?.toString() ?? 'N/A'} km/h',
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                               ElevatedButton.icon(
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
    padding: const EdgeInsets.symmetric(
        horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                )],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }




}
