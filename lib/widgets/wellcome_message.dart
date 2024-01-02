import 'package:flutter/Material.dart';
import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/core/utils/app_constants.dart';

void wellcomeMessage(BuildContext context, AppCubit appCubit) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Container(
        padding: const EdgeInsets.all(16),
        height: 80,
        decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            const SizedBox(
              width: 30,
            ),
            const Icon(
              Icons.waving_hand,
              color: Colors.white,
              size: 45,
            ),
            const SizedBox(
              width: 48,
            ),
            Expanded(
              child: Text("أهلا بعودتك ${appCubit.currentUser['name']}",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        )),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
  ));
}
