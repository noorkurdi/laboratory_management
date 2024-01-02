// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/core/enums/add_or_edit_enum.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/core/utils/media_query_values.dart';
import 'package:university_project/widgets/drop_down_form_field.dart';
import 'package:university_project/widgets/my_text_field.dart';

Future<dynamic> addOrEditTestMethod({
  required BuildContext context,
  required AppCubit appCubit,
  int? index,
  required AddOrEditEnum addOrEditEnum,
}) {
  if (addOrEditEnum == AddOrEditEnum.edit) {
    appCubit.testNameController.text = appCubit.testsList[index!]['name'];
    appCubit.testPriceController.text =
        appCubit.testsList[index]['price'].toString();
    appCubit.testType = appCubit.testsList[index]['type'];
  } else {}
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) {
      return SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).viewInsets.bottom > 0.0
              ? context.height / 1.1
              : context.height / 1.5,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    addOrEditEnum == AddOrEditEnum.add
                        ? 'إضافة تحليل'
                        : 'تعديل التحليل',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontFamily: AppStrings.appFont,
                      fontSize: context.textScaleFactor * 20,
                    ),
                  ),
                  const Spacer(),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: MyTextField(
                        controller: appCubit.testNameController,
                        labelText: "اسم التحليل",
                        textInputType: TextInputType.name,
                        validator: 'names',
                      ),
                    ),
                  ),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: MyDropDownFormField(
                          labelText: 'نوع التحليل',
                          appCubit: appCubit,
                          items: AppLists.testType,
                          forWhat: 'testTypeForAddTest')),
                  const Spacer(),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: MyTextField(
                        controller: appCubit.testPriceController,
                        labelText: "السعر",
                        textInputType: TextInputType.number,
                        validator: 'names',
                        preIcon: const Text('syp'),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await appCubit.getAllTests();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                  color: AppColors.primaryColor,
                                  width: 2,
                                  strokeAlign: 5),
                            ),
                            backgroundColor: Colors.white,
                            elevation: 0),
                        child: Text(
                          'إلغاء',
                          style: TextStyle(
                              fontFamily: AppStrings.appFont,
                              fontSize: context.height <= 600 ? 10 : 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColor),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (addOrEditEnum == AddOrEditEnum.add) {
                            if (appCubit.checkEmpty(controller: [
                              appCubit.testNameController,
                              appCubit.testPriceController,
                            ])) {
                              await appCubit.addNewTestSql(
                                  name: appCubit.testNameController.text,
                                  type: appCubit.testType,
                                  price: int.parse(
                                      appCubit.testPriceController.text));
                              await appCubit.getAllTests();
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                title: 'تم إضافة تحليل بنجاح',
                                textColor: AppColors.secondaryColor,
                                titleColor: AppColors.secondaryColor,
                                onConfirmBtnTap: () {
                                  Navigator.pop(context);

                                  Navigator.pop(context);
                                },
                                confirmBtnText: 'تم',
                                confirmBtnColor: Colors.greenAccent[700]!,
                                confirmBtnTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: AppStrings.appFont,
                                  fontSize: 20,
                                ),
                              );
                            } else {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: '!! هناك خطأ',
                                text: '!! تأكد من المعلومات المدخلة',
                                confirmBtnColor: Colors.red[700]!,
                                confirmBtnText: 'موافق',
                                onConfirmBtnTap: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                confirmBtnTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: AppStrings.appFont,
                                  fontSize: 20,
                                ),
                              );
                            }
                          } else if (addOrEditEnum == AddOrEditEnum.edit) {
                            if (appCubit.checkEmpty(controller: [
                              appCubit.testNameController,
                              appCubit.testPriceController,
                            ])) {
                              print('object');
                              await appCubit.editTestSql(
                                  id: appCubit.testsList[index!]['id']);
                              await appCubit.getAllTests();
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                title: 'تم تعديل التحليل بنجاح',
                                textColor: AppColors.secondaryColor,
                                titleColor: AppColors.secondaryColor,
                                onConfirmBtnTap: () {
                                  Navigator.pop(context);

                                  Navigator.pop(context);
                                },
                                confirmBtnText: 'تم',
                                confirmBtnColor: Colors.greenAccent[700]!,
                                confirmBtnTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: AppStrings.appFont,
                                  fontSize: 20,
                                ),
                              );
                            } else {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: '!! هناك خطأ',
                                text: '!! تأكد من المعلومات المدخلة',
                                confirmBtnColor: Colors.red[700]!,
                                confirmBtnText: 'موافق',
                                onConfirmBtnTap: () {
                                  Navigator.pop(context);
                                },
                                confirmBtnTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: AppStrings.appFont,
                                  fontSize: 20,
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            backgroundColor: AppColors.primaryColor,
                            elevation: 0),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text(
                            addOrEditEnum == AddOrEditEnum.add
                                ? 'إضافة'
                                : 'تعديل',
                            style: TextStyle(
                                fontFamily: AppStrings.appFont,
                                fontSize: context.height <= 600 ? 10 : 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
