
import 'package:flutter/material.dart';


Widget backgroundcolor(BuildContext context,Color colors, double left , double right  ) {
  return Align(
    alignment: AlignmentDirectional(left,right),
    child: Container(
      height: 230,
      width: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: colors),
    ),
  );
}
