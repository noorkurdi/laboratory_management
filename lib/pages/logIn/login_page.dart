// ignore_for_file: use_build_context_synchronously

import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/bloc/app_states.dart';
import 'package:university_project/core/utils/media_query_values.dart';
import 'package:university_project/pages/admin_pages/home_page/home_page.dart';
import 'package:university_project/pages/doctor_pages/home_page/home_page_items/home_page.dart';
import 'package:university_project/pages/employee_pages/home_page/home_page.dart';
import 'package:university_project/widgets/wellcome_message.dart';
import '../../core/utils/app_constants.dart';
import '../../widgets/my_button.dart';
import 'login_items/login_card.dart';

class LogInPage extends StatelessWidget {
  LogInPage({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
            backgroundColor: Colors.white,
            body: Align(
              alignment: Alignment.center,
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            fontSize:
                                40 * MediaQuery.of(context).textScaleFactor,
                            color: AppColors.secondaryColor,
                            fontFamily: AppStrings.appFont,
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey[550],
                        thickness: 3,
                      ),
                      LogInCard(appCubit: appCubit),
                      SizedBox(
                        height: context.height / 40,
                      ),
                      MyButton(
                        text: 'تسجيل الدخول',
                        onPressed: () async {
                          var x = await appCubit.loginEvent();
                          appCubit.sharedPreferences
                              .setBool('onBoarding', true);

                          print(x);
                          await appCubit.getThisMonthExpenses();
                          await appCubit.getThisMonthPills();
                          await appCubit.getFinancial();
                          if (x == 0) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AdminHomePage(),
                                ),
                                (route) => false);
                            wellcomeMessage(context, appCubit);
                          } else if (x == 1) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DoctorHomePage(),
                                ),
                                (route) => false);
                            wellcomeMessage(context, appCubit);
                          } else if (x == 2) {
                            await appCubit.employeeExpensesList(
                                appCubit.currentUser['id']);

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const EmployeeHomePage(),
                                ),
                                (route) => false);
                            wellcomeMessage(context, appCubit);
                          } else {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title: '!! هناك خطأ',
                              text: '!! تأكد من معلومات الحساب',
                              confirmBtnColor: Colors.red[700]!,
                              confirmBtnText: 'موافق',
                              onConfirmBtnTap: () {
                                Navigator.pop(context);
                              },
                              confirmBtnTextStyle: const TextStyle(
                                color: Colors.white,
                                fontFamily: AppStrings.appFont,
                                fontSize: 20,
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: context.height / 90,
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
