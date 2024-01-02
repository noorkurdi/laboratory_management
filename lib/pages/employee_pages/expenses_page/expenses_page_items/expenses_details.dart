import 'package:flutter/material.dart';
import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/core/utils/media_query_values.dart';
import 'package:university_project/widgets/my_button.dart';

Future<dynamic> showExpensesDetails(BuildContext context, AppCubit appCubit,
    int index, List<Map<dynamic, dynamic>> user) {
  return showDialog(
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: FittedBox(
                  child: Text('التفاصيل',
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontFamily: AppStrings.appFont,
                          fontSize: context.textScaleFactor * 25)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      width: context.width * 0.5,
                      height: context.height * 0.2,
                      child: Text(
                          appCubit.employeesExpensesList[index]['description'],
                          style: TextStyle(
                              color: AppColors.secondaryColor,
                              fontFamily: AppStrings.appFont,
                              fontSize: context.textScaleFactor * 20)),
                    ),
                  ),
                ],
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: FittedBox(
                  child: Text('اسم الموظف',
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontFamily: AppStrings.appFont,
                          fontSize: 25)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: FittedBox(
                      child: Text(user[0]['name'],
                          style: TextStyle(
                              color: AppColors.secondaryColor,
                              fontFamily: AppStrings.appFont,
                              fontSize: 20)),
                    ),
                  ),
                ],
              ),
              MyButton(
                  text: 'تم',
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    ),
  );
}
