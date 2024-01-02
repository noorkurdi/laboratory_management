// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/bloc/app_states.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/core/utils/media_query_values.dart';
import 'package:university_project/pages/employee_pages/orders_page/orders_page_items/edit_order_page.dart';
import 'package:university_project/widgets/app_bar_wave.dart';
import 'package:university_project/widgets/my_button.dart';

class EmployeeOrdersPage extends StatelessWidget {
  const EmployeeOrdersPage({super.key});

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
                'كل الطلبات',
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
                            return Slidable(
                              endActionPane: ActionPane(
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    backgroundColor: Colors.transparent,
                                    onPressed: ((context) async {
                                      appCubit.orderPatientAgeController.text =
                                          appCubit
                                              .ordersWithoutResultList[index]
                                                  ['patient_age']
                                              .toString();
                                      appCubit.orderPatientNameController
                                          .text = appCubit
                                              .ordersWithoutResultList[index]
                                          ['patient_name'];
                                      appCubit.orderPatientPhoneController
                                              .text =
                                          appCubit
                                              .ordersWithoutResultList[index]
                                                  ['patient_phone']
                                              .toString();
                                      appCubit.testId = appCubit
                                              .ordersWithoutResultList[index]
                                          ['test_id'];
                                      appCubit.orderIdForEdit = appCubit
                                          .ordersWithoutResultList[index]['id'];
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const EditOrderPage(),
                                          ));
                                    }),
                                    icon: Icons.edit,
                                    foregroundColor: AppColors.secondaryColor,
                                    label: 'تعديل',
                                  )
                                ],
                              ),
                              closeOnScroll: false,
                              startActionPane: ActionPane(
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    backgroundColor: Colors.transparent,
                                    onPressed: ((context) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: AlertDialog(
                                            content: Text(
                                              'هل انت متأكد؟',
                                              style: TextStyle(
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () async {
                                                    await appCubit
                                                        .deleteOrderSql(
                                                      id: appCubit
                                                              .ordersWithoutResultList[
                                                          index]['id'],
                                                    );
                                                    await appCubit
                                                        .getAllOrders();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('نعم',
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .secondaryColor,
                                                      ))),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('لا',
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .secondaryColor,
                                                      )))
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                    icon: Icons.delete,
                                    foregroundColor: Colors.red,
                                    label: 'حذف',
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: SizedBox(
                                  height: 65,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
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
                                                            fontFamily:
                                                                AppStrings
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
                                                            fontFamily:
                                                                AppStrings
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
                                                                [
                                                                'patient_phone']
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .secondaryColor,
                                                            fontFamily:
                                                                AppStrings
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
                                                      child: Text(
                                                          user[0]['name'],
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                appCubit.ordersWithoutResultList[
                                                    index]['date'],
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  color: AppColors.primaryColor,
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
                                                  color:
                                                      AppColors.secondaryColor,
                                                  fontFamily:
                                                      AppStrings.appFont,
                                                  fontSize: 24,
                                                ),
                                              ),
                                              Text(
                                                appCubit.ordersTestsNames[index]
                                                    .toString(),
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontFamily:
                                                      AppStrings.appFont,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
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
            // bottomNavigationBar: BottomNavigationBar(
            //   selectedItemColor: AppColors.secondaryColor,
            //   selectedIconTheme: IconThemeData(color: AppColors.secondaryColor),
            //   unselectedItemColor: Colors.grey,
            //   currentIndex: appCubit.currentIndexForEmployeeNavBar,
            //   selectedFontSize: 20.0,
            //   elevation: 15.0,
            //   onTap: (index) {
            //     appCubit.changeIndexForEmployeeNavBar(index);
            //     Navigator.of(context).pushReplacement(MaterialPageRoute(
            //       builder: (context) => appCubit.employeesScreenList[index],
            //     ));
            //   },
            //   items: const [
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.home),
            //       label: 'الرئيسية',
            //     ),
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.monetization_on),
            //       label: 'المصاريف',
            //     ),
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.move_to_inbox),
            //       label: 'الطلبات',
            //     ),
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.receipt_long_sharp),
            //       label: 'النتائج',
            //     ),
            //   ],
            // ),
          ),
        );
      },
    );
  }
}
