import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String description;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
  });
}
List<OnboardingModel> getOnboardingList(BuildContext context) {
  final t = AppLocalizations.of(context)!;

  return [
    OnboardingModel(
      image: ImageAssets.onboarding1,
      title: t.onboarding_title_1,
      description: t.onboarding_desc_1,
    ),
    OnboardingModel(
      image: ImageAssets.onboarding2,
      title: t.onboarding_title_2,
      description: t.onboarding_desc_2,
    ),
    OnboardingModel(
      image: ImageAssets.onboarding3,
      title: t.onboarding_title_3,
      description: t.onboarding_desc_3,
    ),
    OnboardingModel(
      image: ImageAssets.onboarding4,
      title: t.onboarding_title_4,
      description: t.onboarding_desc_4,
    ),
  ];
}