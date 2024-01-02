import 'package:flutter/material.dart';
import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/core/utils/media_query_values.dart';

class MyDataTable extends StatelessWidget {
  const MyDataTable({
    super.key,
    required this.appCubit,
  });

  final AppCubit appCubit;
  @override
  Widget build(BuildContext context) {
    List<DataRow> rows = [];
    for (int i = 0; i < appCubit.financialList["dates"]!.length; i++) {
      rows.add(DataRow(cells: [
        DataCell(Text(appCubit.financialList["dates"]![i].toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
              fontFamily: AppStrings.appFont,
              fontSize: context.textScaleFactor * 17,
            ))),
        DataCell(Text(appCubit.financialList["expenses"]![i]?.toString() ?? "",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
              fontFamily: AppStrings.appFont,
              fontSize: context.textScaleFactor * 17,
            ))),
        DataCell(Text(appCubit.financialList["pills"]![i]?.toString() ?? "",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
              fontFamily: AppStrings.appFont,
              fontSize: context.textScaleFactor * 17,
            ))),
      ]));
    }

    return DataTable(
        columnSpacing: 20,
        columns: [
          DataColumn(
              label: Text(
            "التاريخ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor,
              fontFamily: AppStrings.appFont,
              fontSize: context.textScaleFactor * 20,
            ),
          )),
          DataColumn(
              label: Text("المصاريف",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor,
                    fontFamily: AppStrings.appFont,
                    fontSize: context.textScaleFactor * 20,
                  ))),
          DataColumn(
              label: Text("الواردات",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor,
                    fontFamily: AppStrings.appFont,
                    fontSize: context.textScaleFactor * 20,
                  ))),
        ],
        rows: rows);
  }
}
