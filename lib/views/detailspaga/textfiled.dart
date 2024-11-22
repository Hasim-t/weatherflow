import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weatherflow/res/styles/colors.dart';

Widget textformfiled(
  BuildContext context,
  dynamic controller,
) {
  return TextFormField(
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
  );
}
