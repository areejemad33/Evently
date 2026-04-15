import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/widgets/custom_tab_bar.dart';
import 'package:evently_app/core/widgets/tab_item.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/model/category_model.dart';
import 'package:evently_app/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'event_item.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
      final appLocalizations = AppLocalizations.of(context)!;
        final categories = CategoryModel.getCategoriesWithAll(context);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLocalizations.welcome_back,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      "Areej Emad",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.light_mode_outlined, color: ColorsManager.darkBlue),
                Card(
                  color: ColorsManager.darkBlue,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 8.0,
                    ),
                    child: Text(
                      "EN",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
        
        DefaultTabController(
          length: categories.length,
          child: TabBar(
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            dividerColor: Colors.transparent, 
            indicatorColor: Colors.transparent,
            tabs: categories.map(
              (category) => TabItem(
                category: category,
                selectedBgColor: ColorsManager.darkBlue,
                selectedFgColor: ColorsManager.white,
                unSelectedBgColor: ColorsManager.white,
                unSelectedFgColor: ColorsManager.black,
                isSelected:
                    categories.indexOf(category) == selectedIndex,
              ),
            ).toList(),
          ),
        ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              itemBuilder: (context, index) => EventItem(
                event: EventModel(
                  id: "1",
                  category: CategoryModel.getCategories(context)[1],
                  title: "Meeting For Updating The Development Method",
                  description: "",
                  date: DateTime.now(),
                  time: TimeOfDay.now(),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
