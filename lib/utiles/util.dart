import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constant/color.dart';

String getDateAndTimeFormatDate(DateTime date){
  String formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(date);
  return formattedDate;
}
String getDateFormatDate(DateTime date){
  String formattedDate = DateFormat('dd MMM yyyy').format(date);
  return formattedDate;
}
String getTimeFormatDate(DateTime date){
  String formattedDate = DateFormat('hh:mm a').format(date);
  return formattedDate;
}

void startActivity(BuildContext context, Widget navigatorScreenWidget) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return navigatorScreenWidget;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Start from the right side
        const end = Offset.zero; // End at normal position
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    ),
  );
}

closeAndStartActivity(BuildContext context, Widget screen){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => screen), (Route<dynamic> route) => false);
}


showSnackBar(String? message,BuildContext? context) {
  try
  {
    return ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: black,
        content: Text(message!,style: const TextStyle(color: white,fontSize: 16,fontWeight: FontWeight.w400)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
  catch (e)
  {
    if (kDebugMode)
    {
      print(e);
    }
  }
}


MaterialColor createMaterialColor(Color color) {
  try {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return const MaterialColor(0xFFFFFFFF, <int, Color>{});
  }
}