
import 'package:flutter/material.dart';
import 'package:mcluck_app/theme/colors.dart';

class ActionButtonWidget extends StatelessWidget {
  final String text;
  final double width;
  final void Function()? onTap;

  const ActionButtonWidget(
      {super.key,
        required this.text,
        required this.width,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
            color: AppColors.accentRed,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Center(
          child: Text(
              text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}