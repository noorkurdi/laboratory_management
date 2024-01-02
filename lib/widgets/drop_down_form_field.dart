import 'package:flutter/material.dart';
import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/core/utils/media_query_values.dart';

class MyDropDownFormField extends StatefulWidget {
  const MyDropDownFormField(
      {super.key,
      required this.appCubit,
      required this.items,
      required this.forWhat,
      required this.labelText});
  final AppCubit appCubit;
  final List<String> items;
  final String forWhat;
  final String labelText;
  @override
  State<MyDropDownFormField> createState() => _MyDropDownFormFieldState();
}

class _MyDropDownFormFieldState extends State<MyDropDownFormField> {
  String? val;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        borderRadius: BorderRadius.circular(15),
        decoration: InputDecoration(
          suffixIconColor: AppColors.secondaryColor,
          hintStyle: TextStyle(
            fontSize: 20 * context.textScaleFactor,
            color: Colors.grey,
          ),
          hintTextDirection: TextDirection.rtl,
          labelText: widget.labelText,
          labelStyle: TextStyle(
              color: Colors.grey,
              fontSize: 20 * context.textScaleFactor,
              fontFamily: AppStrings.appFont),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
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
        value: val,
        items: widget.items.map((e) {
          return DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 20 * context.textScaleFactor,
                ),
              ));
        }).toList(),
        onChanged: (value) {
          setState(() {
            val = value;
            if (widget.forWhat == 'addEmployees') {
              widget.appCubit.employeeType = widget.items.indexOf(value!);
              widget.appCubit.boolForAddVisipilyt();
            } else if (widget.forWhat == 'testTypeForAddTest') {
              widget.appCubit.testType = widget.items.indexOf(value!);
            } else if (widget.forWhat == 'testNameForAddOrder') {
              widget.appCubit.getTestIdByName(value!);
            }
          });
        });
  }
}
