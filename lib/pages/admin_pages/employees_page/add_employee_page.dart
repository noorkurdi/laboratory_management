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

class AddEmployeePage extends StatelessWidget {
  const AddEmployeePage({super.key});
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
                "إضافة حساب",
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
                    vertical: 5,
                    horizontal: 5,
                  ),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: MyDropDownFormField(
                              labelText: "نوع الموظف",
                              forWhat: 'addEmployees',
                              appCubit: appCubit,
                              items: AppLists.employeeType),
                        ),
                        SizedBox(
                          height: context.height * 0.04,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: MyTextField(
                              controller: appCubit.employeeNameController,
                              labelText: 'اسم الموظف',
                              validator: "names",
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 6, right: 6, top: 3),
                          child: Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: MyTextField(
                              controller: appCubit.employeeAddressController,
                              labelText: 'العنوان',
                              validator: "names",
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 6, right: 6, top: 3),
                          child: Form(
                            key: myKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: MyTextField(
                              onTap: () {},
                              textInputType: TextInputType.number,
                              preIcon: const Text('963+'),
                              controller: appCubit.employeePhoneController,
                              labelText: 'الهاتف',
                              validator: 'phone',
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 6, right: 6, top: 6),
                          child: Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: MyTextField(
                              controller: appCubit.employeeSalaryController,
                              labelText: 'الراتب',
                              validator: "names",
                              textInputType: TextInputType.number,
                              preIcon: const Text('syp'),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: appCubit.isvisipleForAddEmp,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 6, right: 6, top: 6),
                                child: Form(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: MyTextField(
                                    controller:
                                        appCubit.employeeEmailController,
                                    labelText: 'البريد الالكتروني',
                                    validator: "names",
                                    textInputType: TextInputType.emailAddress,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 6, right: 6, top: 6),
                                child: Form(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: MyTextField(
                                    controller:
                                        appCubit.employeePasswpordController,
                                    labelText: 'كلمة المرور',
                                    validator: "",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
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
                                      fontSize: context.textScaleFactor * 10,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryColor),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (appCubit.checkEmpty(controller: [
                                        appCubit.employeeNameController,
                                        appCubit.employeeAddressController,
                                        appCubit.employeePhoneController,
                                        appCubit.employeeSalaryController,
                                      ]) &&
                                      appCubit.employeeType != null &&
                                      myKey.currentState!.validate()) {
                                    await appCubit.addNewEmployeeSql(
                                        name: appCubit
                                            .employeeNameController.text,
                                        address: appCubit
                                            .employeeAddressController.text,
                                        phone: appCubit
                                            .employeePhoneController.text,
                                        salary: appCubit
                                            .employeeSalaryController.text);

                                    if (appCubit.employeeTypeController.text !=
                                        '3') {
                                      if (appCubit.employeeEmailController.text
                                              .isNotEmpty &&
                                          appCubit.employeePasswpordController
                                              .text.isNotEmpty) {
                                        await appCubit.addUserSql();
                                      }
                                    }
                                    await appCubit.getAllEmployees();
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.success,
                                      title: 'تم إضافة موظف بنجاح  ',
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
                                        fontSize: context.textScaleFactor * 10,
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
            ),
          );
        });
  }
}
