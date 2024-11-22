import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherflow/controller/searchcontroller.dart';
import 'package:weatherflow/res/styles/colors.dart';
import 'package:weatherflow/views/detailspaga/searchpage.dart';
import 'package:weatherflow/views/home/backgroundcolors.dart';
class HomeScreen extends StatelessWidget {
  final WeatherController weatherController = Get.find<WeatherController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Get.to(Searchpage()),
            icon: const Icon(Icons.search),
            color: CustomColors.white,
          ),
          const SizedBox(width: 13),
        ],
        backgroundColor: CustomColors.transparant,
      ),
      body: Stack(
        children: [
          backgroundcolor(context, CustomColors.blue, 0.78, -0.72),
          backgroundcolor(context, CustomColors.purple, -0.78, -0.72),
          backgroundcolor(context, CustomColors.orenge, 0, 0),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Obx(
                () => ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: weatherController.savedLocations.length,
                  itemBuilder: (context, index) {
                    final weather = weatherController.savedLocations[index];
                    return Dismissible(
                      key: Key(weather.location + index.toString()),
                      onDismissed: (direction) {
                        weatherController.removeWeatherLocation(index);
                      },
                      background: Container(
                        color: CustomColors.transparant.withOpacity(0.7),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16),
                        child: const Icon(Icons.delete, color: CustomColors.white),
                      ),
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        color: CustomColors.transparant,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        weather.location,
                                        style: const TextStyle(
                                          color: CustomColors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        weather.country,
                                        style: const TextStyle(
                                          color: CustomColors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${weather.temperature}°C',
                                    style: const TextStyle(
                                      color: CustomColors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                weather.description,
                                style: const TextStyle(
                                  color: CustomColors.white,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Humidity: ${weather.humidity}% | Wind: ${weather.windSpeed} km/h',
                                style: const TextStyle(
                                  color: CustomColors.white,
                                  fontSize: 14,
                                ),
                              ),

                       
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}