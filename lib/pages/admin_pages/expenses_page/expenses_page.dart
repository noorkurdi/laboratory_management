// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/bloc/app_states.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/core/utils/media_query_values.dart';
import 'package:university_project/pages/admin_pages/expenses_page/expenses_page_itmes/edit_expenses_page.dart';
import 'package:university_project/widgets/my_fab.dart';
import 'package:university_project/widgets/app_bar_wave.dart';
import 'package:university_project/widgets/my_button.dart';

import '../../common_pages/add_expenses_page.dart';

class AdminExpensesPage extends StatelessWidget {
  const AdminExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: RefreshIndicator(
            onRefresh: () async {
              await appCubit.getAllExpenses();
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startFloat,
              backgroundColor: Colors.white,
              extendBody: true,
              appBar: AppBar(
                title: const Text(
                  'المصاريف',
                  style: TextStyle(
                    fontFamily: AppStrings.appFont,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: AppColors.secondaryColor,
                elevation: 0,
                centerTitle: true,
              ),
              floatingActionButton: MyAdminFAB(
                  onPress: () {
                    appCubit.clearEvent(controller: [
                      appCubit.expensesDateController,
                      appCubit.expensesValueController,
                      appCubit.expensesDescriptionController,
                      appCubit.expensesNameController,
                    ]);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddExpensesPage()));
                  },
                  text: "إضافة"),
              body: Column(
                children: [
                  const AppBarWave(),
                  Stack(children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        width: context.width,
                        height: context.height * 0.195,
                        child: Card(
                          color: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: context.width,
                        height: context.height * 0.18,
                        child: Card(
                          color: AppColors.secondaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('المصاريف الكلية لهذا الشهر',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: AppStrings.appFont,
                                          fontSize:
                                              context.textScaleFactor * 20)),
                                  Text('${appCubit.thisMonthExpenses}syp',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: AppStrings.appFont,
                                          fontSize:
                                              context.textScaleFactor * 30)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                  Expanded(
                    child: ListView.builder(
                      itemCount: appCubit.allExpensesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                backgroundColor: Colors.transparent,
                                onPressed: ((context) async {
                                  appCubit.expensesNameController.text =
                                      appCubit.allExpensesList[index]['name'];
                                  appCubit.expensesDescriptionController.text =
                                      appCubit.allExpensesList[index]
                                          ['description'];
                                  appCubit.expensesValueController.text =
                                      appCubit.allExpensesList[index]['value']
                                          .toString();
                                  appCubit.expensesDateController.text =
                                      appCubit.allExpensesList[index]['date'];
                                  appCubit.expenseIdForEdit =
                                      appCubit.allExpensesList[index]['id'];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const EditExpensesPage(),
                                      ));
                                }),
                                icon: Icons.edit,
                                foregroundColor: AppColors.secondaryColor,
                                label: 'تعديل',
                              )
                            ],
                          ),
                          closeOnScroll: false,
                          startActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                backgroundColor: Colors.transparent,
                                onPressed: ((context) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: AlertDialog(
                                        content: Text(
                                          'هل انت متأكد؟',
                                          style: TextStyle(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () async {
                                                await appCubit
                                                    .deleteExpensesSql(
                                                  id: appCubit.allExpensesList[
                                                      index]['id'],
                                                );
                                                await appCubit.getAllExpenses();
                                                await appCubit
                                                    .getThisMonthExpenses();
                                                await appCubit.getFinancial();

                                                Navigator.pop(context);
                                              },
                                              child: Text('نعم',
                                                  style: TextStyle(
                                                    color: AppColors
                                                        .secondaryColor,
                                                  ))),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('لا',
                                                  style: TextStyle(
                                                    color: AppColors
                                                        .secondaryColor,
                                                  )))
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                                icon: Icons.delete,
                                foregroundColor: Colors.red,
                                label: 'حذف',
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: SizedBox(
                              height: context.height * 0.15,
                              child: InkWell(
                                onTap: () async {
                                  var user = await appCubit.getUserById(
                                    appCubit.allExpensesList[index]
                                        ['employee_id'],
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (context) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 120, horizontal: 20),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: FittedBox(
                                                  child: Text('التفاصيل',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .primaryColor,
                                                          fontFamily: AppStrings
                                                              .appFont,
                                                          fontSize: context
                                                                  .textScaleFactor *
                                                              25)),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: Container(
                                                      width:
                                                          context.width * 0.5,
                                                      height:
                                                          context.height * 0.2,
                                                      child: Text(
                                                          appCubit.allExpensesList[
                                                                  index]
                                                              ['description'],
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .secondaryColor,
                                                              fontFamily:
                                                                  AppStrings
                                                                      .appFont,
                                                              fontSize: context
                                                                      .textScaleFactor *
                                                                  20)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: FittedBox(
                                                  child: Text('اسم الموظف',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .primaryColor,
                                                          fontFamily: AppStrings
                                                              .appFont,
                                                          fontSize: 25)),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: FittedBox(
                                                      child: Text(
                                                          user.isNotEmpty
                                                              ? user[0]['name']
                                                              : 'موظف سابق',
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .secondaryColor,
                                                              fontFamily:
                                                                  AppStrings
                                                                      .appFont,
                                                              fontSize: 20)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              MyButton(
                                                  text: 'تم',
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  })
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            appCubit.allExpensesList[index]
                                                ['date'],
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontFamily: AppStrings.appFont,
                                              fontSize:
                                                  context.textScaleFactor * 17,
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                appCubit.allExpensesList[index]
                                                    ['name'],
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  color:
                                                      AppColors.secondaryColor,
                                                  fontFamily:
                                                      AppStrings.appFont,
                                                  fontSize:
                                                      context.textScaleFactor *
                                                          20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '${appCubit.allExpensesList[index]['value'].toString()}syp',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontFamily: AppStrings.appFont,
                                              fontSize:
                                                  context.textScaleFactor * 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              // bottomNavigationBar: BottomNavigationBar(
              //   selectedItemColor: AppColors.secondaryColor,
              //   selectedIconTheme: IconThemeData(color: AppColors.secondaryColor),
              //   unselectedItemColor: Colors.grey,
              //   currentIndex: appCubit.currentIndexForAdminNavBar,
              //   selectedFontSize: 20.0,
              //   elevation: 15.0,
              //   onTap: (index) {
              //     appCubit.changeIndexForAdminNavBar(index);
              //     Navigator.of(context).pushReplacement(MaterialPageRoute(
              //       builder: (context) => appCubit.adminsScreenList[index],
              //     ));
              //   },
              //   items: const [
              //     BottomNavigationBarItem(
              //       icon: Icon(Icons.home),
              //       label: 'الرئيسية',
              //     ),
              //     BottomNavigationBarItem(
              //       icon: Icon(Icons.monetization_on),
              //       label: 'المصاريف',
              //     ),
              //     BottomNavigationBarItem(
              //       icon: Icon(Icons.move_to_inbox),
              //       label: 'الإيرادات',
              //     ),
              //     BottomNavigationBarItem(
              //       icon: Icon(Icons.people),
              //       label: 'الموظفين',
              //     ),
              //   ],
              // ),
            ),
          ),
        );
      },
    );
  }
}
