// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/bloc/app_states.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/core/utils/media_query_values.dart';
import 'package:university_project/pages/common_pages/add_expenses_page.dart';
import 'package:university_project/pages/employee_pages/expenses_page/expenses_page_items/expenses_details.dart';
import 'package:university_project/widgets/my_fab.dart';
import 'package:university_project/widgets/app_bar_wave.dart';

class EmployeeExpensesPage extends StatelessWidget {
  const EmployeeExpensesPage({super.key});

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
                'المصاريف',
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
                onPress: () {
                  appCubit.clearEvent(controller: [
                    appCubit.expensesDateController,
                    appCubit.expensesValueController,
                    appCubit.expensesDescriptionController,
                    appCubit.expensesNameController,
                  ]);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddExpensesPage()));
                },
                text: "إضافة"),
            body: Column(
              children: [
                const AppBarWave(),
                Expanded(
                  child: appCubit.employeesExpensesList.isEmpty
                      ? Center(
                          child: Text('لايوجد مصاريف حاليا',
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontFamily: AppStrings.appFont,
                                  fontSize: context.textScaleFactor * 35)))
                      : ListView.builder(
                          itemCount: appCubit.employeesExpensesList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: SizedBox(
                                height: 65,
                                child: InkWell(
                                  onTap: () async {
                                    var user = await appCubit.getUserById(
                                      appCubit.employeesExpensesList[index]
                                          ['employee_id'],
                                    );
                                    showExpensesDetails(
                                        context, appCubit, index, user);
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
                                              appCubit.employeesExpensesList[
                                                  index]['date'],
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: AppColors.primaryColor,
                                                fontFamily: AppStrings.appFont,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              appCubit.employeesExpensesList[
                                                  index]['name'],
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: AppColors.secondaryColor,
                                                fontFamily: AppStrings.appFont,
                                                fontSize: 24,
                                              ),
                                            ),
                                            Text(
                                              '${appCubit.employeesExpensesList[index]['value'].toString()}syp',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: AppColors.primaryColor,
                                                fontFamily: AppStrings.appFont,
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
