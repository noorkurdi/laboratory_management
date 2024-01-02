import 'package:flutter/Material.dart';
import 'package:university_project/core/utils/media_query_values.dart';

import '../core/utils/app_constants.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final Widget? icon;
  final TextInputType? textInputType;
  final bool? hideInput;
  final bool? readOnly;
  final VoidCallback? onTap;
  final String? validator;
  final Widget? preIcon;

  final double? fontSize;

  const MyTextField({
    Key? key,
    required this.controller,
    this.preIcon,
    this.labelText,
    this.hintText,
    this.icon,
    this.textInputType,
    this.hideInput,
    this.readOnly,
    this.onTap,
    this.validator,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5),
      child: TextFormField(
        validator: validator == "names"
            ? (value) {
                if (value == null) {
                  return "هذا الحقل مطلوب";
                } else if (value == "") {
                  return "هذا الحقل مطلوب";
                } else {
                  return null;
                }
              }
            : validator == "phone"
                ? (value) {
                    if (value != null) {
                      if (value.length < 9) {
                        return "رقم الهاتف غير صحيح";
                      } else {
                        return null;
                      }
                    } else {
                      return "هذا الحقل مطلوب";
                    }
                  }
                : (value) {
                    if (value != null) {
                      if (value.length < 4) {
                        return "كلمة السر يجب أن لاتقل عن 4 محارف";
                      } else {
                        return null;
                      }
                    } else {
                      return "هذا الحقل مطلوب";
                    }
                  },
        onTap: onTap,
        readOnly: readOnly ?? false,
        obscureText: hideInput ?? false,
        keyboardType: textInputType,
        controller: controller,
        cursorColor: AppColors.secondaryColor,
        style: TextStyle(
          fontSize: fontSize ?? 20 * context.textScaleFactor,
          color: AppColors.secondaryColor,
          fontFamily: AppStrings.appFont,
        ),
        decoration: InputDecoration(
          prefix: preIcon,
          suffix: icon,
          suffixIconColor: AppColors.secondaryColor,
          hintStyle: TextStyle(
            fontSize: fontSize ?? 20 * context.textScaleFactor,
            color: Colors.grey,
          ),
          hintText: hintText,
          hintTextDirection: TextDirection.rtl,
          labelText: labelText ?? '',
          labelStyle: TextStyle(
              color: Colors.grey,
              fontSize: fontSize ?? 20 * context.textScaleFactor,
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
      ),
    );
  }
}
