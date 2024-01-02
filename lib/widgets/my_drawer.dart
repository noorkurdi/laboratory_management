import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/core/utils/media_query_values.dart';
import 'package:university_project/widgets/log_out_button.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer(
      {super.key,
      required this.appCubit,
      required this.title,
      required this.onTap,
      required this.icon});
  final List<String> title;
  final List<VoidCallback> onTap;
  final List<IconData> icon;

  final AppCubit appCubit;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: context.width * 0.8,
      child: Column(
        children: [
          Card(
            elevation: 7,
            shadowColor: AppColors.primaryColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            color: AppColors.primaryColor,
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              color: AppColors.secondaryColor,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: context.height * 0.06),
                    child: CircleAvatar(
                      radius: context.height * 0.1,
                      backgroundColor: AppColors.primaryColor,
                      child: CircleAvatar(
                        radius: context.height * 0.09,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                            radius: context.height * 0.06,
                            backgroundColor: Colors.white,
                            child: appCubit.whoLogged == 0
                                ? SvgPicture.asset(
                                    appCubit.adminImg,
                                    color: AppColors.secondaryColor,
                                  )
                                : appCubit.whoLogged == 1
                                    ? SvgPicture.asset(
                                        appCubit.doctorImg,
                                        color: AppColors.secondaryColor,
                                      )
                                    : SvgPicture.asset(
                                        appCubit.employeeImg,
                                        color: AppColors.secondaryColor,
                                      )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.height * 0.02,
                  ),
                  Center(
                    child: Text(
                      appCubit.currentUserName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: AppStrings.appFont,
                        fontSize: context.textScaleFactor * 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: context.height * 0.04,
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: title.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 7,
                        shadowColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.white,
                        child: ListTile(
                          style: ListTileStyle.drawer,
                          onTap: onTap[index],
                          leading:
                              Icon(icon[index], color: AppColors.primaryColor),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.primaryColor,
                          ),
                          title: Text(
                            title[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondaryColor,
                              fontFamily: AppStrings.appFont,
                              fontSize: context.textScaleFactor * 25,
                            ),
                          ),
                        ),
                      );
                    })),
          ),
          // Spacer(),
          LogOutButton(appCubit: appCubit)
        ],
      ),
    );
  }
}
