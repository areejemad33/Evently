import 'package:evently_app/core/prefs_manager/prefs_manager.dart';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/features/auth/login/login_screen.dart';
import 'package:evently_app/features/onbording/onboarding_data.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/lang_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final onboardingList = getOnboardingList(context);
    final isLast = currentIndex == onboardingList.length - 1;

    final themeProvider = Provider.of<ThemeProvider>(context);
    final langProvider = Provider.of<LangProvider>(context);

    final isDark = themeProvider.isDark;

    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,

        leading: (currentIndex >= 2)
            ? Padding(
                padding: const EdgeInsets.only(left: 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  onPressed: () {
                    controller.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              )
            : const SizedBox(),

        title: Image.asset(ImageAssets.evenltyLogo, height: 40),

        actions: [
          if (currentIndex != 0 && !isLast)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                child: Text(
                  t.skip,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            )
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
              onPageChanged: (index) => setState(() => currentIndex = index),
              itemBuilder: (context, index) {
                final item = onboardingList[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height -
                            kToolbarHeight -
                            100,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// IMAGE
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  item.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            /// DOTS
                            Center(
                              child: SmoothPageIndicator(
                                controller: controller,
                                count: onboardingList.length,
                                effect: const ExpandingDotsEffect(
                                  activeDotColor: ColorsManager.darkBlue,
                                  dotColor: ColorsManager.grey,
                                  dotHeight: 10,
                                  dotWidth: 8,
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            /// TITLE
                            Text(
                              item.title,
                              style: GoogleFonts.poppins(
                                textStyle:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),

                            const SizedBox(height: 10),

                            /// DESCRIPTION
                            Text(
                              item.description,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),

                            const SizedBox(height: 20),

                            /// SETTINGS (FIRST PAGE ONLY)
                            if (currentIndex == 0) ...[

                              /// LANGUAGE
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    t.language,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge,
                                  ),
                                  Row(
                                    children: [
                                      _langButton(
                                        title: "English",
                                        active:
                                            langProvider.currentLang == "en",
                                        onTap: () =>
                                            langProvider.updateAppLang("en"),
                                      ),
                                      const SizedBox(width: 10),
                                      _langButton(
                                        title: "Arabic",
                                        active:
                                            langProvider.currentLang == "ar",
                                        onTap: () =>
                                            langProvider.updateAppLang("ar"),
                                      ),
                                    ],
                                  )
                                ],
                              ),

                              const SizedBox(height: 10),

                              /// THEME
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    t.theme,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge,
                                  ),
                                  Row(
                                    children: [
                                      _iconButton(
                                        icon: Icons.light_mode,
                                        active: !isDark,
                                        onTap: () => themeProvider
                                            .updateAppTheme(
                                                ThemeMode.light),
                                      ),
                                      const SizedBox(width: 10),
                                      _iconButton(
                                        icon: Icons.dark_mode_outlined,
                                        active: isDark,
                                        onTap: () => themeProvider
                                            .updateAppTheme(
                                                ThemeMode.dark),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
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
                    ? t.lets_start
                    : isLast
                        ? t.get_started
                        : t.next,
                onClick: () {
                  if (isLast) {
                    PrefsManager.setSeenOnboarding();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  } else {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _langButton({
    required String title,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: active ? ColorsManager.darkBlue : ColorsManager.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: active ? ColorsManager.white : ColorsManager.darkBlue,
          ),
        ),
      ),
    );
  }

  Widget _iconButton({
    required IconData icon,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: active ? ColorsManager.darkBlue : ColorsManager.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          icon,
          color: active ? ColorsManager.white : ColorsManager.darkBlue,
        ),
      ),
    );
  }
}