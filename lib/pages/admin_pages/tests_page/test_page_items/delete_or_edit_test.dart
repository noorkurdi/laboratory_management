// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/core/enums/add_or_edit_enum.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/core/utils/media_query_values.dart';
import 'package:university_project/pages/admin_pages/home_page/home_page_items/add_or_edit_test_method.dart';
import 'package:university_project/widgets/my_button.dart';

Future<dynamic> deleteOrEditTest(
    BuildContext context, AppCubit appCubit, int index) {
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) {
      return SizedBox(
        height: context.height * 0.2,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyButton(
                  text: 'حذف',
                  onPressed: () async {
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
                                  await appCubit.deleteTestSql(
                                      id: appCubit.testsList[index]['id']);
                                  await appCubit.getAllTests();

                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text('نعم',
                                    style: TextStyle(
                                      color: AppColors.secondaryColor,
                                    ))),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('لا',
                                    style: TextStyle(
                                      color: AppColors.secondaryColor,
                                    )))
                          ],
                        ),
                      ),
                    );
                  }),
              MyButton(
                  text: 'تعديل',
                  onPressed: () async {
                    Navigator.pop(context);
                    await addOrEditTestMethod(
                        context: context,
                        appCubit: appCubit,
                        index: index,
                        addOrEditEnum: AddOrEditEnum.edit);
                  })
            ],
          ),
        ),
      );
    },
  );
}
