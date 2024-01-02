// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import 'package:intl/intl.dart' as intl;

import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/bloc/app_states.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/core/utils/media_query_values.dart';
import 'package:university_project/widgets/my_text_field.dart';

class EditExpensesPage extends StatelessWidget {
  const EditExpensesPage({super.key});

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
                "تعديل المصاريف",
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontFamily: AppStrings.appFont,
                    fontSize: context.textScaleFactor * 20),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 5,
                      ),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: SizedBox(
                                height: context.height * 0.14,
                                child: Form(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: MyTextField(
                                    controller: appCubit.expensesNameController,
                                    labelText: 'العنوان',
                                    validator: "names",
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 6, right: 6, top: 3),
                              child: SizedBox(
                                height: context.height * 0.14,
                                child: Form(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: MyTextField(
                                    controller:
                                        appCubit.expensesDescriptionController,
                                    labelText: 'الوصف',
                                    validator: "names",
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 6, right: 6, top: 3),
                              child: SizedBox(
                                height: context.height * 0.14,
                                child: Form(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: MyTextField(
                                    controller:
                                        appCubit.expensesValueController,
                                    labelText: 'القيمة',
                                    validator: 'names',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 6, right: 6, top: 6),
                              child: SizedBox(
                                height: context.height * 0.14,
                                child: Form(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: MyTextField(
                                    readOnly: true,
                                    controller: appCubit.expensesDateController,
                                    labelText: 'التاريخ',
                                    validator: "names",
                                    onTap: () async {
                                      DateTime? pickeddate =
                                          await showDatePicker(
                                              confirmText: 'موافق',
                                              cancelText: 'إالغاء',
                                              helpText: 'اختيار التاريخ',
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2030));

                                      if (pickeddate != null) {
                                        appCubit.expensesDateController.text =
                                            intl.DateFormat('yyyy-MM-dd')
                                                .format(pickeddate);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                          fontSize:
                                              context.height <= 600 ? 10 : 16,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primaryColor),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (appCubit.checkEmpty(controller: [
                                        appCubit.expensesDateController,
                                        appCubit.expensesNameController,
                                        appCubit.expensesDescriptionController,
                                        appCubit.expensesValueController,
                                      ])) {
                                        await appCubit.editExpensesSql(
                                            id: appCubit.expenseIdForEdit);
                                        await appCubit.getAllExpenses();
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.success,
                                          title: 'تم تعديل المصاريف بنجاح  ',
                                          textColor: AppColors.secondaryColor,
                                          titleColor: AppColors.secondaryColor,
                                          onConfirmBtnTap: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          confirmBtnText: 'تم',
                                          confirmBtnColor:
                                              Colors.greenAccent[700]!,
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
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        backgroundColor: AppColors.primaryColor,
                                        elevation: 0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6),
                                      child: Text(
                                        'تعديل',
                                        style: TextStyle(
                                            fontFamily: AppStrings.appFont,
                                            fontSize:
                                                context.height <= 600 ? 10 : 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          );
        });
  }
}
