// ignore_for_file: use_build_context_synchronously

import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/bloc/app_states.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/pages/admin_pages/tests_page/test_card.dart';
import 'package:university_project/pages/admin_pages/tests_page/test_page_items/delete_or_edit_test.dart';
import 'package:university_project/pages/employee_pages/home_page/home_page_items/add_order_page.dart';

class TestsListView extends StatelessWidget {
  const TestsListView({super.key, this.onPress, this.onLongPress});
  final VoidCallback? onPress;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit appCubit = AppCubit.get(context);
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      scrollDirection: Axis.vertical,
                      itemCount: appCubit.testsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onLongPress: () {
                              onLongPress ??
                                  deleteOrEditTest(context, appCubit, index);
                            },
                            child: TestCard(
                              image: AppImages.appLogoPath,
                              testName: appCubit.testsList[index]['name'],
                              testType: AppLists
                                  .testType[appCubit.testsList[index]['type']],
                              testPrice:
                                  appCubit.testsList[index]['price'].toString(),
                              onPress: onPress ??
                                  () {
                                    appCubit.testId =
                                        appCubit.testsList[index]['id'];
                                    appCubit.clearEvent(controller: [
                                      appCubit.orderPatientPhoneController,
                                      appCubit.orderPatientAgeController,
                                      appCubit.orderPatientNameController,
                                    ]);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AddOrderPage()));
                                  },
                            ),
                          ),
                        );
                      })),
            ),
          );
        });
  }
}
