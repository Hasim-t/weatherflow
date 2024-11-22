import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherflow/controller/splash.dart';
import 'package:weatherflow/res/styles/colors.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SplashscreenController(),
      builder: (context) {
        return Scaffold(
         backgroundColor:  CustomColors.blue,
         body: Padding(
           padding: const EdgeInsets.all(0),
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
              SizedBox(height: 10,),
               Center(
                child: Lottie.asset('assets/cloudeanimation.json'),
               ),
                Text('Weater app'),
             ],
           ),
           
         ),

        );
      },
    );
  }
}
