import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/widgets/custom_tab_bar.dart';
import 'package:evently_app/core/widgets/tab_item.dart';
import 'package:evently_app/firebase/firebase_service.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/model/category_model.dart';
import 'package:evently_app/model/event_model.dart';
import 'package:evently_app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/event_item.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;
 late   CategoryModel selectedCategory = CategoryModel.getCategoriesWithAll(
    context,
  )[0];
  List<EventModel> events = [];

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

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
                      UserModel.currentUser?.name ?? '',
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

          CustomTabBar(
            categories: CategoryModel.getCategoriesWithAll(context),
            onCategoryItemClicked: (newCategory) {
              selectedCategory = newCategory;
              setState(() {});
            },
          ),

          StreamBuilder(
            stream: FirebaseService.getEventsFromFireStoreRealTime(context, selectedCategory),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) { 
                return Center(
                  child: Text(appLocalizations.something_went_wrong),
                );
              }
              List<EventModel> events = snapshot.data!;
              return Expanded(
                child: events.isEmpty
                    ? Center(child: Text(appLocalizations.no_events))
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        itemBuilder: (context, index) =>
                            EventItem(event: events[index],                      
                                   markedAsFavourite: UserModel.currentUser?.favouriteEventsIds.contains(events[index].id) ?? false,
),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16.h),
                        itemCount: events.length,
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
