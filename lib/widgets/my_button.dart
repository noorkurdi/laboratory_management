import 'package:flutter/Material.dart';
import 'package:university_project/core/utils/media_query_values.dart';

import '../core/utils/app_constants.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.brderColor,
    this.textColor,
    this.btnColor,
  });

  final String text;
  final VoidCallback onPressed;
  final Color? brderColor;
  final Color? textColor;
  final Color? btnColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(
                color: brderColor ?? AppColors.primaryColor,
                width: 2,
                strokeAlign: 5),
          ),
          backgroundColor: btnColor ?? Colors.white,
          elevation: 0),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontFamily: AppStrings.appFont,
              fontSize: context.height <= 600 ? 10 : 16,
              fontWeight: FontWeight.w900,
              color: textColor ?? AppColors.primaryColor),
        ),
      ),
    );
  }
}
