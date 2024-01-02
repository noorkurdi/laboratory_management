import 'package:flutter/Material.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/core/utils/media_query_values.dart';
import 'package:university_project/widgets/wave_clipper.dart';

class AppBarWave extends StatelessWidget {
  const AppBarWave({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.8,
          child: ClipPath(
            clipper: WaveClipper(),
            child: Container(
              color: AppColors.primaryColor,
              height: context.height / 6,
            ),
          ),
        ),
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            color: AppColors.secondaryColor,
            height: context.height / 8,
          ),
        ),
      ],
    );
  }
}
