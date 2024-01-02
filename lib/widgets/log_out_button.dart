// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/pages/logIn/login_page.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({
    super.key,
    required this.appCubit,
  });

  final AppCubit appCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: ElevatedButton(
        onPressed: () async {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.warning,
            title: 'تسجيل الخروج؟',
            textColor: AppColors.secondaryColor,
            titleColor: AppColors.secondaryColor,
            cancelBtnText: 'إلغاء',
            cancelBtnTextStyle: const TextStyle(
              color: Colors.black,
              fontFamily: AppStrings.appFont,
              fontSize: 20,
            ),
            showCancelBtn: true,
            onCancelBtnTap: () {
              Navigator.pop(context);
            },
            onConfirmBtnTap: () async {
              await appCubit.clearEvent(controller: [
                appCubit.loginEmailController,
                appCubit.loginPasswordController,
              ]);
              await appCubit.logOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => LogInPage(),
                ),
                (route) => false,
              );
            },
            confirmBtnText: 'نعم',
            confirmBtnColor: Colors.red,
            confirmBtnTextStyle: const TextStyle(
              color: Colors.white,
              fontFamily: AppStrings.appFont,
              fontSize: 20,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'تسجيل الخروج',
            style: TextStyle(
              color: Colors.white,
              fontFamily: AppStrings.appFont,
            ),
          ),
        ),
      ),
    );
  }
}
