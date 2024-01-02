// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/bloc/app_states.dart';
import 'package:university_project/core/enums/add_or_edit_enum.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/pages/admin_pages/home_page/home_page_items/add_or_edit_test_method.dart';
import 'package:university_project/pages/admin_pages/tests_page/test_page_items/tests_list_view.dart';
import 'package:university_project/widgets/my_fab.dart';
import 'package:university_project/widgets/app_bar_wave.dart';

class TestsPage extends StatelessWidget {
  const TestsPage({super.key});

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
            floatingActionButton: MyAdminFAB(
                onPress: () {
                  appCubit.clearEvent(controller: [
                    appCubit.testNameController,
                    appCubit.testPriceController,
                    appCubit.testTypeController,
                  ]);
                  appCubit.testType = 0;
                  addOrEditTestMethod(
                      addOrEditEnum: AddOrEditEnum.add,
                      appCubit: appCubit,
                      context: context);
                },
                text: 'إضافة تحليل'),
            appBar: AppBar(
              title: const Text(
                'التحاليل',
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
                Expanded(child: TestsListView(
                  onPress: () {
                    return;
                  },
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
