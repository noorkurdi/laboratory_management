// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/bloc/app_states.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/core/utils/media_query_values.dart';
import 'package:university_project/widgets/my_text_field.dart';
import 'package:university_project/widgets/drop_down_form_field.dart';

class AddOrderPage extends StatelessWidget {
  const AddOrderPage({super.key});
  static GlobalKey<FormState> myKey = GlobalKey<FormState>();

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
                "إضافة طلب جديد",
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
                            Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: MyTextField(
                                controller: appCubit.orderPatientNameController,
                                labelText: 'اسم المريض',
                                validator: "names",
                              ),
                            ),
                            Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: MyTextField(
                                controller: appCubit.orderPatientAgeController,
                                labelText: 'عمر المريض',
                                validator: "names",
                                textInputType: TextInputType.number,
                              ),
                            ),
                            Form(
                              key: myKey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: MyTextField(
                                controller:
                                    appCubit.orderPatientPhoneController,
                                labelText: 'رقم الهاتف',
                                validator: "phone",
                                textInputType: TextInputType.number,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 5),
                              child: Visibility(
                                visible: appCubit.testId == null,
                                child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: MyDropDownFormField(
                                        labelText: 'اسم التحليل',
                                        appCubit: appCubit,
                                        items: appCubit.testsNamesList,
                                        forWhat: 'testNameForAddOrder')),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                print(appCubit.ordersWithoutResultList);
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
                                if (appCubit.testIdBeforConfirm != null &&
                                    appCubit.checkEmpty(controller: [
                                      appCubit.orderPatientAgeController,
                                      appCubit.orderPatientNameController,
                                      appCubit.orderPatientPhoneController,
                                    ]) &&
                                    myKey.currentState!.validate()) {
                                  appCubit.testId = appCubit.testIdBeforConfirm;
                                  await appCubit.addNewOrderSql(
                                    patientAge: int.parse(appCubit
                                        .orderPatientAgeController.text),
                                    patientName: appCubit
                                        .orderPatientNameController.text,
                                    patientPhone: appCubit
                                        .orderPatientPhoneController.text,
                                  );
                                  await appCubit.getAllOrders();
                                  appCubit.testId = null;

                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.success,
                                    title: 'تم إضافة طلب جديد بنجاح  ',
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
                                  'إضافة',
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
