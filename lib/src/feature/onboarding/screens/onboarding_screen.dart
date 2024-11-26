import 'package:co_learning_mobile_app/src/common/routes/app_route.dart';
import 'package:co_learning_mobile_app/src/common/utility/app_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/constants/common_imports.dart';
import '../../../common/widgets/custom_button.dart';
import '../services/onboarding_screen_service.dart';
import '../widgets/onboarding_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with OnBoardingScreenService, AppTheme, Language {
  final List<Widget> pages = [
    OnboardingWidget(
      image: ImageAssets.icOnBoarding1,
      title: label(
        e: LanguageEn.instance.onboardingTitleText1,
        b: LanguageBn.instance.onboardingTitleText1,
      ),
      subtitile: label(
        e: LanguageEn.instance.onboardingSubTitleText1,
        b: LanguageBn.instance.onboardingSubTitleText1,
      ),
    ),
    OnboardingWidget(
      image: ImageAssets.icOnBoarding2,
      title: label(
        e: LanguageEn.instance.onboardingTitleText2,
        b: LanguageBn.instance.onboardingTitleText2,
      ),
      subtitile: label(
        e: LanguageEn.instance.onboardingSubTitleText2,
        b: LanguageBn.instance.onboardingSubTitleText2,
      ),
    ),
    OnboardingWidget(
      image: ImageAssets.icOnBoarding1,
      title: label(
        e: LanguageEn.instance.onboardingTitleText3,
        b: LanguageBn.instance.onboardingTitleText3,
      ),
      subtitile: label(
        e: LanguageEn.instance.onboardingSubTitleText3,
        b: LanguageBn.instance.onboardingSubTitleText3,
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        color: backgroundColors[currentPage],
        child: Column(
          children: [
            Flexible(
              child: PageView.builder(
                controller: controller,
                onPageChanged: onPageChanged,
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return pages[index];
                },
              ),
            ),
            currentPage == 2
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.s24,
                    ),
                    child: CustomButton(
                      onTap: () {
                        onBoardUser();
                      },
                      title: "Get Started!",
                      textColor: clr.appPrimaryColor,
                      bgColor: clr.whiteColor,
                      radius: size.s12,
                      verticalPadding: size.s12,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          controller.jumpToPage(2); // Skip to the last page
                        },
                        child: const Text(
                          "Skip",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Row(
                        children: List.generate(
                          pages.length,
                          (index) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor: index == currentPage
                                  ? Colors.white
                                  : Colors.white54,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: size.s20),
                        child: GestureDetector(
                          onTap: () {
                            controller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.s20, vertical: size.s8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(size.s20),
                                color: clr.whiteColor,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 0),
                                      blurRadius: size.s12,
                                      color: clr.whiteColor)
                                ]),
                            child: Icon(Icons.arrow_forward,
                                color: clr.onBoardBgColor2),
                          ),
                        ),
                      )
                    ],
                  ),
            size.s32.kHeight,
          ],
        ),
      ),
    );
  }

  @override
  void onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: backgroundColors[index],
    ));
  }

  @override
  void navigateToAuthentication() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoute.signInScreen, (x) => false);
  }
}
