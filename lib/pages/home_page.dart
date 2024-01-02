import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/bloc/app_states.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () async {}, child: const Text('add emp ')),
                ElevatedButton(
                    onPressed: () async {
                      // for (var i = 8; i < 9; i++) {

                      // }
                      // await appCubit.deleteExpensesSql(id: 1);

                      // print(alaEmp);
                    },
                    child: const Text('all emp')),
              ],
            ),
          ),
        );
      },
    );
  }
}
