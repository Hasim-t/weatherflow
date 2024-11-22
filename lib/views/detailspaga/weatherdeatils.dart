 import 'package:flutter/widgets.dart';
import 'package:weatherflow/res/styles/colors.dart';

Widget buildWeatherDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: CustomColors.white,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: CustomColors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
    
  }