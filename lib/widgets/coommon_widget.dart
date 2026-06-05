import 'package:flutter/material.dart';

import '../constant/color.dart';


Widget getTitle(String title, {Color color = black, double fontSize = 16}) {
  return Text(
    title,
    textAlign: TextAlign.start,
    style: TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeight.w600,
    ),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );
}


TextStyle getLightTextStyle({Color color = black, double fontSize = 14}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: FontWeight.w300,
  );
}

TextStyle getRegularTextStyle({Color color = black, double fontSize = 14,FontWeight fontWeight = FontWeight.w400}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}

TextStyle getMediumTextStyle({Color color = black, double fontSize = 14}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: FontWeight.w500,
  );
}

TextStyle getSemiBoldTextStyle({Color color = black, double fontSize = 14}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: FontWeight.w600,
  );
}

TextStyle getBoldTextStyle({Color color = black, double fontSize = 14}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: FontWeight.w700,
  );
}

Widget getCommonButton(
    String title,
    bool isLoading,
    void Function()? onPressed, {
      double fontSize = 16,
    }) {
  return SizedBox(
    height: 48,
    child: TextButton(
      onPressed: onPressed, // disable when loading
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(Colors.lightBlue),
      ),
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isLoading
              ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,),
          )
              : Text(title,style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.w500,color: Colors.white,),),
        ),
      ),
    ),
  );
}

getCommonCard({Border? border}){
  return BoxDecoration(
    color: white,
    borderRadius: BorderRadius.circular(kButtonCornerRadius),
    border:border,
    boxShadow: [
      BoxShadow(
        color: cardBgColor, //color of shadow
        spreadRadius: 5, //spread radius
        blurRadius: 9, // blur radius
        offset: const Offset(0, 2), // changes position of shadow
      )
    ],
  );
}