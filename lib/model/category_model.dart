import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  String id;
  String name;
  IconData icon;
  String image;
  String darkImage;
  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.image,
    required this.darkImage,
  });
   String getImage(bool isDark) {
    return isDark ? darkImage : image;
  }

  static List<CategoryModel> getCategoriesWithAll(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    List<CategoryModel> categoriesWithAll = [
      CategoryModel(
        id: "0",
        name: appLocalizations.aLL,
        icon: Icons.all_inclusive,
        image: "",
        darkImage: "",
      ),
      CategoryModel(
        id: "1",
        name: appLocalizations.sport,
        icon: Icons.sports_football,
        image: ImageAssets.sport,
        darkImage: ImageAssets.sportDark,
      ),
      CategoryModel(
        id: "2",
        name: appLocalizations.birthday,
        icon: Icons.cake_outlined,
        image: ImageAssets.birthday,
        darkImage: ImageAssets.birthdayDark,
      ),
      CategoryModel(
        id: "3",
        name: appLocalizations.book_club,
        icon: Icons.bookmark_border_outlined,
        image: ImageAssets.bookClub,
        darkImage: ImageAssets.bookClubDark,
      ),
      CategoryModel(
        id: "4",
        name: appLocalizations.meeting,
        icon: Icons.laptop_mac_outlined,
        image: ImageAssets.meeting,
        darkImage: ImageAssets.meetingDark,
      ),
      CategoryModel(
        id: "5",
        name: appLocalizations.exhibtion,
        icon: Icons.water_drop_rounded,
        image: ImageAssets.exhibition,
        darkImage: ImageAssets.exhibitionDark,
      ),
    ];
    return categoriesWithAll;
  }

  static List<CategoryModel> getCategories(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    List<CategoryModel> categories = [
      CategoryModel(
        id: "1",
        name: appLocalizations.sport,
        icon: Icons.sports_football,
        image: ImageAssets.sport,
        darkImage: ImageAssets.sportDark,
      ),
      CategoryModel(
        id: "2",
        name: appLocalizations.birthday,
        icon: Icons.cake_outlined,
        image: ImageAssets.birthday,
        darkImage: ImageAssets.birthdayDark,
      ),
      CategoryModel(
        id: "3",
        name: appLocalizations.book_club,
        icon: Icons.bookmark_border_outlined,
        image: ImageAssets.bookClub,
        darkImage: ImageAssets.bookClubDark,
      ),
      CategoryModel(
        id: "4",
        name: appLocalizations.meeting,
        icon: Icons.laptop_mac_outlined,
        image: ImageAssets.meeting,
        darkImage: ImageAssets.meetingDark,
      ),
      CategoryModel(
        id: "5",
        name: appLocalizations.exhibtion,
        icon: Icons.water_drop_rounded,
        image: ImageAssets.exhibition,
        darkImage: ImageAssets.exhibitionDark,
      ),
    ];
    return categories;
  }
}
