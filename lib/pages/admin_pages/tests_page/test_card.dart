import 'package:flutter/Material.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/core/utils/media_query_values.dart';

class TestCard extends StatelessWidget {
  const TestCard({
    super.key,
    required this.image,
    required this.testName,
    required this.testType,
    required this.onPress,
    required this.testPrice,
  });

  final String image;
  final String testName;
  final String testType;
  final String testPrice;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GestureDetector(
        onTap: onPress,
        child: SizedBox(
          height: 100 / 375 * context.width,
          width: 160 / 375 * context.width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    // const Color(0xff343434).withOpacity(0.7),
                    // const Color(0xff343434).withOpacity(0.2)
                    AppColors.secondaryColor.withOpacity(0.7),
                    AppColors.secondaryColor.withOpacity(0.4)
                  ],
                )),
              ),
              Padding(
                padding: EdgeInsets.all(context.width * 18 / 375),
                child: Text.rich(TextSpan(
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: AppStrings.appFont,
                    ),
                    children: [
                      TextSpan(
                        text: '$testName\n',
                        style: TextStyle(
                          fontSize: context.textScaleFactor * 18,
                        ),
                      ),
                      TextSpan(
                        text: '$testType\n',
                        style: TextStyle(
                          fontSize: context.textScaleFactor * 14,
                        ),
                      ),
                      TextSpan(
                        text: '${testPrice}syp',
                        style: TextStyle(
                          fontSize: context.textScaleFactor * 14,
                        ),
                      )
                    ])),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
