// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';

import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/bloc/app_states.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/core/utils/media_query_values.dart';
import 'package:university_project/pages/doctor_pages/home_page/home_page_items/add_pill_page.dart';
import 'package:university_project/pages/logIn/login_page.dart';
import 'package:university_project/widgets/app_bar_wave.dart';
import 'package:university_project/widgets/my_button.dart';

class DoctorHomePage extends StatelessWidget {
  const DoctorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            backgroundColor: Colors.white,
            extendBody: true,
            appBar: AppBar(
              leading: IconButton(
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LogInPage(),
                            ));
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
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  )),
              title: const Text(
                'الصفحة الرئيسية',
                style: TextStyle(
                  fontFamily: AppStrings.appFont,
                  color: Colors.white,
                ),
              ),
              backgroundColor: AppColors.secondaryColor,
              elevation: 0,
              centerTitle: true,
            ),
            body: Column(
              children: [
                const AppBarWave(),
                Expanded(
                  child: appCubit.ordersWithoutResultList.isEmpty
                      ? Center(
                          child: Text('لايوجد طلبات حاليا',
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontFamily: AppStrings.appFont,
                                  fontSize: context.textScaleFactor * 35)))
                      : ListView.builder(
                          itemCount: appCubit.ordersWithoutResultList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: SizedBox(
                                height: context.height * 0.2,
                                child: InkWell(
                                  onTap: () async {
                                    var user = await appCubit.getUserById(
                                      appCubit.ordersWithoutResultList[index]
                                          ['employee_id'],
                                    );
                                    showDialog(
                                      context: context,
                                      builder: (context) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 120, horizontal: 20),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: FittedBox(
                                                    child: Text('اسم المريض',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .primaryColor,
                                                            fontFamily:
                                                                AppStrings
                                                                    .appFont,
                                                            fontSize: context
                                                                    .textScaleFactor *
                                                                25)),
                                                  ),
                                                ),
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: Text(
                                                      appCubit.ordersWithoutResultList[
                                                              index]
                                                          ['patient_name'],
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .secondaryColor,
                                                          fontFamily: AppStrings
                                                              .appFont,
                                                          fontSize: context
                                                                  .textScaleFactor *
                                                              20)),
                                                ),
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: FittedBox(
                                                    child: Text('عمر المريض',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .primaryColor,
                                                            fontFamily:
                                                                AppStrings
                                                                    .appFont,
                                                            fontSize: context
                                                                    .textScaleFactor *
                                                                25)),
                                                  ),
                                                ),
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: Text(
                                                      appCubit
                                                          .ordersWithoutResultList[
                                                              index]
                                                              ['patient_age']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .secondaryColor,
                                                          fontFamily: AppStrings
                                                              .appFont,
                                                          fontSize: context
                                                                  .textScaleFactor *
                                                              20)),
                                                ),
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: FittedBox(
                                                    child: Text('رقم المريض',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .primaryColor,
                                                            fontFamily:
                                                                AppStrings
                                                                    .appFont,
                                                            fontSize: context
                                                                    .textScaleFactor *
                                                                25)),
                                                  ),
                                                ),
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: Text(
                                                      appCubit
                                                          .ordersWithoutResultList[
                                                              index]
                                                              ['patient_phone']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .secondaryColor,
                                                          fontFamily: AppStrings
                                                              .appFont,
                                                          fontSize: context
                                                                  .textScaleFactor *
                                                              20)),
                                                ),
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: FittedBox(
                                                    child: Text('اسم الموظف',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .primaryColor,
                                                            fontFamily:
                                                                AppStrings
                                                                    .appFont,
                                                            fontSize: 25)),
                                                  ),
                                                ),
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: FittedBox(
                                                    child: Text(user[0]['name'],
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .secondaryColor,
                                                            fontFamily:
                                                                AppStrings
                                                                    .appFont,
                                                            fontSize: 20)),
                                                  ),
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
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  appCubit.ordersWithoutResultList[
                                                      index]['date'],
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontFamily:
                                                        AppStrings.appFont,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Text(
                                                  appCubit.ordersWithoutResultList[
                                                      index]['patient_name'],
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    color: AppColors
                                                        .secondaryColor,
                                                    fontFamily:
                                                        AppStrings.appFont,
                                                    fontSize: 24,
                                                  ),
                                                ),
                                                Text(
                                                  appCubit
                                                      .ordersTestsNames[index]
                                                      .toString(),
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontFamily:
                                                        AppStrings.appFont,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            MyButton(
                                                text: 'إصدار النتيجة',
                                                onPressed: () {
                                                  appCubit.clearEvent(
                                                      controller: [
                                                        appCubit
                                                            .pillResultController
                                                      ]);

                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddPillPage(
                                                          index: index,
                                                        ),
                                                      ));
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                )
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: AppColors.secondaryColor,
              selectedIconTheme: IconThemeData(color: AppColors.secondaryColor),
              unselectedItemColor: Colors.grey,
              currentIndex: appCubit.currentIndexForDoctorNavBar,
              selectedFontSize: 20.0,
              elevation: 15.0,
              onTap: (index) {
                appCubit.changeIndexForDoctorNavBar(index);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => appCubit.doctorsScreenList[index],
                ));
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.move_to_inbox),
                  label: 'الطلبات',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long_sharp),
                  label: 'النتائج',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
