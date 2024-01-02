// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/bloc/app_states.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/core/utils/media_query_values.dart';
import 'package:university_project/widgets/app_bar_wave.dart';
import 'package:university_project/widgets/my_button.dart';

class DoctorResultPage extends StatelessWidget {
  const DoctorResultPage({super.key});

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
              title: const Text(
                'نتائج التحاليل',
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
                  child: appCubit.pillsList.isEmpty
                      ? Center(
                          child: Text('لايوجد نتائج',
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontFamily: AppStrings.appFont,
                                  fontSize: context.textScaleFactor * 35)))
                      : ListView.builder(
                          itemCount: appCubit.pillsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: SizedBox(
                                height: context.height * 0.2,
                                child: InkWell(
                                  onTap: () async {
                                    var user = await appCubit.getUserById(
                                      appCubit.pillsList[index]['employee_id'],
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
                                                    child: Text('النتيجة',
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
                                                      appCubit.pillsList[index]
                                                          ['result'],
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
                                                    child: Text('اسم الطبيب',
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
                                                  appCubit.pillsList[index]
                                                      ['date'],
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontFamily:
                                                        AppStrings.appFont,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    appCubit.pillsList[index]
                                                        ['patient_name'],
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .secondaryColor,
                                                      fontFamily:
                                                          AppStrings.appFont,
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  appCubit
                                                      .pillsTestsNames[index]
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
