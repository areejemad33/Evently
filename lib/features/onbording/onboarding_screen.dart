

import 'package:evently_app/core/prefs_manager/prefs_manager.dart';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/features/auth/login/login_screen.dart';

import 'package:evently_app/features/onbording/onboarding_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController controller = PageController();
  int currentIndex = 0;

  bool isEnglish = true;
  bool isLight = true;

  bool get isLast => currentIndex == onboardingList.length - 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.whiteF4,
        centerTitle: true,
        leading: (currentIndex >= 2)
            ? Padding(
                padding: const EdgeInsets.only(left: 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: ColorsManager.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    controller.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                    color: ColorsManager.darkBlue,
                  ),
                ),
              )
            : const SizedBox(),
        title: Image.asset(
        ImageAssets.evenltyLogo,
          height: 40,
        ),
        actions: [
          if (currentIndex != 0 && !isLast)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: ColorsManager.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: Text(
                  "Skip",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            )
          else
            const SizedBox(width: 60),
        ],
      ),

      body: Column(
        children: [
          SizedBox(height: 16.h),

          /// PAGE VIEW
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: onboardingList.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final item = onboardingList[index];

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              item.image,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Center(
                          child: SmoothPageIndicator(
                            controller: controller,
                            count: onboardingList.length,
                            effect: ExpandingDotsEffect(
                              activeDotColor: ColorsManager.darkBlue,
                              dotColor: ColorsManager.grey,
                              dotHeight: 10,
                              dotWidth: 8,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          item.title,
                          style: GoogleFonts.poppins(
                            textStyle:
                                Theme.of(context).textTheme.displayMedium,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          item.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),

                        const SizedBox(height: 20),

                        /// FIRST PAGE ONLY
                        if (currentIndex == 0) ...[
                          /// LANGUAGE
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Language",
                                style:
                                    Theme.of(context).textTheme.titleLarge,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isEnglish = true;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isEnglish
                                            ? ColorsManager.darkBlue
                                            : ColorsManager.white,
                                        borderRadius:
                                            BorderRadius.circular(16),
                                      ),
                                      child: Text(
                                        "English",
                                        style: TextStyle(
                                          color: isEnglish
                                              ? ColorsManager.white
                                              : ColorsManager.darkBlue,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isEnglish = false;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: !isEnglish
                                            ? ColorsManager.darkBlue
                                            : ColorsManager.white,
                                        borderRadius:
                                            BorderRadius.circular(16),
                                      ),
                                      child: Text(
                                        "Arabic",
                                        style: TextStyle(
                                          color: !isEnglish
                                              ? ColorsManager.white
                                              : ColorsManager.darkBlue,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          /// THEME
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Theme",
                                style:
                                    Theme.of(context).textTheme.titleLarge,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isLight = true;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isLight
                                            ? ColorsManager.darkBlue
                                            : ColorsManager.white,
                                        borderRadius:
                                            BorderRadius.circular(16),
                                      ),
                                      child: Icon(
                                        Icons.light_mode,
                                        color: isLight
                                            ? ColorsManager.white
                                            : ColorsManager.darkBlue,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isLight = false;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: !isLight
                                            ? ColorsManager.darkBlue
                                            : ColorsManager.white,
                                        borderRadius:
                                            BorderRadius.circular(16),
                                      ),
                                      child: Icon(
                                        Icons.dark_mode_outlined,
                                        color: !isLight
                                            ? ColorsManager.white
                                            : ColorsManager.darkBlue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          /// BUTTON
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                title: currentIndex == 0
                    ? "Let's Start"
                    : isLast
                        ? "Get Started"
                        : "Next",
                onClick: () async {
                  if (isLast) {
                       PrefsManager.setSeenOnboarding();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  } else {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }
                },
              style: ElevatedButton.styleFrom( shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(16), ), ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}