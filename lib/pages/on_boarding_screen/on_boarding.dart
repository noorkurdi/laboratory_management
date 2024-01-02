import 'package:flutter/material.dart';

import 'package:introduction_screen/introduction_screen.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/pages/logIn/login_page.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'اجراء التحاليل بسهولة',
            body: 'طلب التحاليل واجراءها وادارتها بسرعة ودقة ',
            image: Image.asset(AppImages.onboarding1, width: 350),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'استعراض النتائج',
            body: 'اصدار النتائج واستعراضها بكل سهولة وفاعلية',
            image: Image.asset(AppImages.onboarding2, width: 350),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'ادارة شاملة',
            body: 'ادارة شاملة للموظفين وللحسابات  بكفاءة ودقة عالية',
            image: Image.asset(AppImages.onboarding3, width: 350),
            decoration: getPageDecoration(),
          ),
          // PageViewModel(
          //   title: 'Secure shopping and easy payment',
          //   body:
          //       'Enjoy a convenient shopping experience away from fraud and ads',
          //   //Start your journey
          //   image: Image.asset(
          //     AppImages.onboarding4,
          //     width: 350,
          //   ),
          //   decoration: getPageDecoration(),
          // ),
        ],
        done: Text('بدء',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.secondaryColor)),
        onDone: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => LogInPage()),
        ),
        showSkipButton: true,
        skip: Text('تخطي', style: TextStyle(color: AppColors.secondaryColor)),
        onSkip: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => LogInPage()),
        ),
        next: Icon(Icons.arrow_forward, color: AppColors.secondaryColor),
        dotsDecorator: getDotDecoration(),
        // onChange: (index) => print('Page $index selected'),
        globalBackgroundColor: Colors.white,
        skipOrBackFlex: 0,
        nextFlex: 0,
        animationDuration: 800,
        bodyPadding: const EdgeInsets.only(top: 30),
        // isProgressTap: false,
        // isProgress: false,
        // showNextButton: false,
        // freeze: true,
      ),
    );
  }

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: AppColors.primaryColor,
        activeColor: AppColors.secondaryColor,
        size: const Size(10, 10),
        activeSize: const Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.secondaryColor),
      bodyTextStyle: TextStyle(fontSize: 20, color: AppColors.primaryColor),
      // descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
      imagePadding: const EdgeInsets.all(5),
      pageColor: Colors.white,
      bodyPadding: const EdgeInsets.only(top: 30));
}
