import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/bloc/app_states.dart';
import 'package:university_project/core/utils/app_constants.dart';

// ignore: must_be_immutable
class MyToggleButton extends StatelessWidget {
  List<Widget> children;
  MyToggleButton({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);

        return ToggleButtons(
          borderRadius: BorderRadius.circular(15),
          borderColor: AppColors.secondaryColor,
          fillColor: AppColors.secondaryColor,
          color: AppColors.secondaryColor,
          selectedColor: Colors.white,
          isSelected: appCubit.toggleBoolList,
          onPressed: (int index) {
            appCubit.toggleEmpType(index);

            if (appCubit.toggleBoolList.length == 3) {
              for (var i = 0; i < appCubit.toggleBoolList.length; i++) {
                if (appCubit.toggleBoolList[i] == true) {
                  appCubit.employeeType = i;
                }
              }
            }
            print(appCubit.employeeType);
          },
          children: children,
        );
      },
    );
  }
}
