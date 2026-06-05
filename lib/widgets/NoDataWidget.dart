import 'package:flutter/material.dart';

import 'coommon_widget.dart';

class NoDataWidget extends StatelessWidget {
  final String message;
  final String image;
  const NoDataWidget({required this.message, required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          image,
          height: 20,
          width: 20,
          color: Colors.grey,
        ),
        const SizedBox(height: 10),
        Flexible(
          child: Text(
            message,
            style: getSemiBoldTextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
