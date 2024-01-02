import 'package:flutter/material.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/core/utils/media_query_values.dart';

class MyAdminFAB extends StatelessWidget {
  const MyAdminFAB({super.key, required this.onPress, required this.text});
  final VoidCallback onPress;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        width: context.width / 3,
        height: context.height / 11,
        child: FloatingActionButton(
          hoverColor: AppColors.primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: onPress,
          backgroundColor: AppColors.secondaryColor,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: AppStrings.appFont,
                  fontSize: context.textScaleFactor * 15),
            ),
          ),
        ),
      ),
    ]);
  }
}
