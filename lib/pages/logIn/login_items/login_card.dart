import 'package:flutter/Material.dart';
import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/core/utils/media_query_values.dart';

import '../../../widgets/my_text_field.dart';

class LogInCard extends StatelessWidget {
  const LogInCard({
    super.key,
    required this.appCubit,
  });

  final AppCubit appCubit;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        shadowColor: Colors.black,
        color: Colors.white,
        elevation: 7,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: SizedBox(
          width: context.width,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MyTextField(
                  controller: appCubit.loginEmailController,
                  labelText: "البريد الألكتروني",
                  textInputType: TextInputType.emailAddress,
                  hintText: 'ahmad@gmail.com',
                  validator: 'name',
                ),
                SizedBox(
                  height: context.height / 90,
                ),
                MyTextField(
                  controller: appCubit.loginPasswordController,
                  labelText: "كلمة السر",
                  textInputType: TextInputType.visiblePassword,
                  hideInput: true,
                  hintText: 'xxxxxxxx',
                  validator: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
