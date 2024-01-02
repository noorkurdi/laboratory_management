// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/bloc/app_states.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/core/utils/media_query_values.dart';
import 'package:university_project/pages/admin_pages/employees_page/employees_page.dart';
import 'package:university_project/pages/admin_pages/expenses_page/expenses_page.dart';
import 'package:university_project/pages/admin_pages/revenues_page/revenues_page.dart';
import 'package:university_project/pages/admin_pages/tests_page/test_page.dart';
import 'package:university_project/widgets/app_bar_wave.dart';
import 'package:university_project/widgets/my_drawer.dart';
import 'package:university_project/widgets/my_datatable.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: RefreshIndicator(
            onRefresh: () async {
              await appCubit.getFinancial();
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startFloat,
              backgroundColor: Colors.white,
              extendBody: true,
              drawer: MyDrawer(appCubit: appCubit, title: const [
                'التحاليل',
                'الموظفين',
                'الإيرادات',
                'المصاريف'
              ], onTap: [
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TestsPage()));
                },
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminEmployeesPage()));
                },
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminRevenuesPage()));
                },
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminExpensesPage()));
                }
              ], icon: const [
                Icons.science_outlined,
                Icons.people,
                Icons.move_to_inbox,
                Icons.monetization_on
              ]),
              // floatingActionButton: MyAdminFAB(
              //     onPress: () async {
              //       await appCubit.testtt();
              //       appCubit.clearEvent(controller: [
              //         appCubit.testNameController,
              //         appCubit.testPriceController,
              //         appCubit.testTypeController,
              //       ]);
              //       appCubit.testType = 0;
              //       addOrEditTestMethod(
              //           addOrEditEnum: AddOrEditEnum.add,
              //           appCubit: appCubit,
              //           context: context);
              //     },
              //     text: 'إضافة تحليل'),

              appBar: AppBar(
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
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: appCubit.financialList['pills']!.isEmpty
                          ? Center(
                              child: Text('\n\n\n\nلايوجد بيانات مالية لعرضها',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                    fontFamily: AppStrings.appFont,
                                    fontSize: context.textScaleFactor * 17,
                                  )),
                            )
                          : MyDataTable(appCubit: appCubit))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
