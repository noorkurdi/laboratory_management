// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/bloc/app_states.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/pages/admin_pages/tests_page/test_page_items/tests_list_view.dart';
import 'package:university_project/pages/employee_pages/expenses_page/expenses_page.dart';
import 'package:university_project/pages/employee_pages/home_page/home_page_items/add_order_page.dart';
import 'package:university_project/pages/employee_pages/orders_page/orders_page.dart';
import 'package:university_project/pages/employee_pages/result_page/result_page.dart';
import 'package:university_project/widgets/my_fab.dart';
import 'package:university_project/widgets/app_bar_wave.dart';
import 'package:university_project/widgets/my_drawer.dart';

class EmployeeHomePage extends StatelessWidget {
  const EmployeeHomePage({super.key});

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
              drawer: MyDrawer(appCubit: appCubit, title: const [
                'الطلبات',
                'النتائج',
                'المصاريف'
              ], onTap: [
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EmployeeOrdersPage()));
                },
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EmployeeResultPage()));
                },
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EmployeeExpensesPage()));
                }
              ], icon: const [
                Icons.move_to_inbox,
                Icons.receipt_long_sharp,
                Icons.monetization_on
              ]),
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
              floatingActionButton: MyAdminFAB(
                  onPress: () async {
                    appCubit.getAllTests();
                    appCubit.clearEvent(controller: [
                      appCubit.orderPatientPhoneController,
                      appCubit.orderPatientAgeController,
                      appCubit.orderPatientNameController,
                    ]);
                    appCubit.testId = null;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddOrderPage()));
                  },
                  text: 'طلب جديد'),
              body: Column(
                children: [
                  const AppBarWave(),
                  Expanded(child: TestsListView(
                    onLongPress: () {
                      return;
                    },
                  ))
                ],
              ),
            ));
      },
    );
  }
}
