// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/bloc/app_states.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/core/utils/media_query_values.dart';
import 'package:university_project/pages/admin_pages/employees_page/add_employee_page.dart';
import 'package:university_project/pages/admin_pages/employees_page/edit_employee_page.dart';
import 'package:university_project/widgets/my_fab.dart';
import 'package:university_project/widgets/app_bar_wave.dart';

class AdminEmployeesPage extends StatelessWidget {
  const AdminEmployeesPage({super.key});

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
                'الموظفين',
                style: TextStyle(
                  fontFamily: AppStrings.appFont,
                  color: Colors.white,
                ),
              ),
              backgroundColor: AppColors.secondaryColor,
              elevation: 0,
              centerTitle: true,
            ),
            floatingActionButton: MyAdminFAB(
                text: 'إضافة موظف',
                onPress: () async {
                  final alaEmp = await appCubit.getAllUsersql();
                  print(alaEmp);
                  appCubit.clearEvent(controller: [
                    appCubit.employeeNameController,
                    appCubit.employeeAddressController,
                    appCubit.employeePhoneController,
                    appCubit.employeeSalaryController,
                    appCubit.employeeEmailController,
                    appCubit.employeePasswpordController,
                  ]);
                  appCubit.employeeType = 3;

                  print(appCubit.employeeType);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddEmployeePage()));
                }),
            body: Column(
              children: [
                const AppBarWave(),
                Expanded(
                  child: ListView.builder(
                    itemCount: appCubit.employeesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: Colors.transparent,
                              onPressed: ((context) async {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        title: const Text(
                                          'هل انت متأكد من الحذف؟',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 219, 37, 24),
                                            fontFamily: AppStrings.appFont,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        actionsAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        actions: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 219, 37, 24),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            onPressed: () async {
                                              if (appCubit.employeesList[index]
                                                      ['type'] ==
                                                  0) {
                                                await appCubit
                                                    .getUserIdByEmployeeName(
                                                        appCubit.employeesList[
                                                            index]['name']);
                                                await appCubit.deleteUserSql(
                                                    id: appCubit
                                                        .userIdForEditEmployeeInAdminPage);
                                              }
                                              await appCubit.deleteEmployeeSql(
                                                  id: appCubit
                                                          .employeesList[index]
                                                      ['id']);
                                              await appCubit.getAllEmployees();
                                              await appCubit.getAllUsersql();
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'نعم',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: AppStrings.appFont,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                side: BorderSide(
                                                    color:
                                                        AppColors.primaryColor,
                                                    width: 2),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'لا',
                                              style: TextStyle(
                                                color: AppColors.primaryColor,
                                                fontFamily: AppStrings.appFont,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              }),
                              icon: Icons.delete,
                              foregroundColor: Colors.red,
                              label: 'حذف',
                            )
                          ],
                        ),
                        closeOnScroll: false,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: SizedBox(
                            height: 65,
                            child: InkWell(
                              onTap: () async {
                                await appCubit.getAllEmployees();
                                await appCubit.getAllUsersql();
                                appCubit.employeeId =
                                    appCubit.employeesList[index]['id'];
                                appCubit.employeeNameController.text =
                                    appCubit.employeesList[index]['name'];
                                appCubit.employeeAddressController.text =
                                    appCubit.employeesList[index]['address'];
                                appCubit.employeePhoneController.text = appCubit
                                    .employeesList[index]['phone']
                                    .toString();
                                appCubit.employeeSalaryController.text =
                                    appCubit.employeesList[index]['salary']
                                        .toString();
                                appCubit.employeeTypeController.text = appCubit
                                    .employeesList[index]['type']
                                    .toString();
                                await appCubit.getOneUserByNameql(
                                    appCubit.employeesList[index]['name']);
                                await appCubit.boolForEditVisipilyt();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const EditEmployeePage()));
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
                                        SizedBox(
                                          width: context.width * 0.075,
                                          height: context.width * 0.075,
                                          child: appCubit.employeesList[index]
                                                      ['type'] !=
                                                  3
                                              ? SvgPicture.asset(
                                                  appCubit.getUserPhoto(appCubit
                                                          .employeesList[index]
                                                      ['type']),
                                                  color:
                                                      AppColors.secondaryColor,
                                                )
                                              : Icon(
                                                  Icons.person,
                                                  color:
                                                      AppColors.secondaryColor,
                                                ),
                                        ),
                                        Text(
                                          appCubit.employeesList[index]['name'],
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            color: AppColors.secondaryColor,
                                            fontFamily: AppStrings.appFont,
                                            fontSize: 24,
                                          ),
                                        ),
                                        const SizedBox(),
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
          ),
        );
      },
    );
  }
}
