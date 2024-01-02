// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';

import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/bloc/app_states.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/core/utils/media_query_values.dart';

class AddPillPage extends StatelessWidget {
  const AddPillPage({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit appCubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.primaryColor,
                  )),
              elevation: 0,
              title: Text(
                "إصدار نتيجة",
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontFamily: AppStrings.appFont,
                    fontSize: context.textScaleFactor * 20),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 25,
                    horizontal: 10,
                  ),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Column(
                          children: [
                            SizedBox(
                              height: context.height * 0.50,
                              child: Form(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: TextFormField(
                                    controller: appCubit.pillResultController,
                                    maxLines: 10,
                                    validator: (value) {
                                      if (value == null) {
                                        return "هذا الحقل مطلوب";
                                      } else if (value == "") {
                                        return "هذا الحقل مطلوب";
                                      } else {
                                        return null;
                                      }
                                    },
                                    cursorColor: AppColors.secondaryColor,
                                    style: TextStyle(
                                      fontSize: 20 * context.textScaleFactor,
                                      color: AppColors.secondaryColor,
                                      fontFamily: AppStrings.appFont,
                                    ),
                                    decoration: InputDecoration(
                                      suffixIconColor: AppColors.secondaryColor,
                                      hintStyle: TextStyle(
                                        fontSize: 20 * context.textScaleFactor,
                                        color: Colors.grey,
                                      ),
                                      hintTextDirection: TextDirection.rtl,
                                      labelText: 'النتيجة',
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                              20 * context.textScaleFactor,
                                          fontFamily: AppStrings.appFont),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: AppColors.primaryColor,
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2.5,
                                          color: AppColors.primaryColor,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
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
                                    fontSize: context.textScaleFactor * 15,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryColor),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (appCubit.checkEmpty(controller: [
                                  appCubit.pillResultController,
                                ])) {
                                  await appCubit.addNewPillSql(index: index);
                                  // await appCubit.addNewExpensesSql(
                                  //     date: appCubit.expensesDateController.text,
                                  //     name: appCubit.expensesNameController.text,
                                  //     description: appCubit
                                  //         .expensesDescriptionController.text,
                                  //     value: int.parse(
                                  //         appCubit.expensesValueController.text),
                                  //     employeeId: appCubit.currentUser["id"]);
                                  await appCubit.getAllOrders();
                                  await appCubit.getAllPills();
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.success,
                                    title: 'تم إصدار نتيجة جديدة بنجاح  ',
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
                                    text: '!! تأكد تعبأة الحقول  ',
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
                                  'إصدار',
                                  style: TextStyle(
                                      fontFamily: AppStrings.appFont,
                                      fontSize: context.textScaleFactor * 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          );
        });
  }
}
