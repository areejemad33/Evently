import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/widgets/custom_tab_bar.dart';
import 'package:evently_app/firebase/firebase_service.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/model/category_model.dart';
import 'package:evently_app/model/event_model.dart';
import 'package:evently_app/model/user_model.dart';
import 'package:evently_app/providers/lang_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/event_item.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
   late CategoryModel selectedCategory =
      CategoryModel.getCategoriesWithAll(context)[0];

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
        final themeProvider = Provider.of<ThemeProvider>(context);
final langProvider = Provider.of<LangProvider>(context);
final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Column(
        children: [
          /// 👤 HEADER
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
                const Spacer(),
          

Icon(
  themeProvider.isDark
      ? Icons.dark_mode_outlined
      : Icons.light_mode_outlined,
  color: isDark ? ColorsManager.blue : ColorsManager.darkBlue,
    size: 32,
),
SizedBox(width: 6,),
               Card(
      color: isDark ? ColorsManager.blue : ColorsManager.darkBlue,
      child: Padding(
        padding: const EdgeInsets.symmetric(
       vertical: 12, 
          horizontal: 10.0,
        ),
        child: Text(
          langProvider.currentLang.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          /// 📂 CATEGORY TAB
          CustomTabBar(
            
            categories: CategoryModel.getCategoriesWithAll(context),
            onCategoryItemClicked: (newCategory) {
              setState(() {
                selectedCategory = newCategory;
              });
            },
          ),

          /// 🔥 STREAM (EVENTS + USER REALTIME)
          Expanded(
            child: StreamBuilder<UserModel>(
              stream: FirebaseService.getUserStream(),
              builder: (context, userSnapshot) {
                if (!userSnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final user = userSnapshot.data!;
                final favIds = user.favouriteEventsIds;

                return StreamBuilder<List<EventModel>>(
                  stream: FirebaseService.getEventsFromFireStoreRealTime(
                      context, selectedCategory),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(appLocalizations.something_went_wrong),
                      );
                    }

                    final events = snapshot.data ?? [];

                    if (events.isEmpty) {
                      return Center(
                        child: Text(appLocalizations.no_events),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 24),
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index];

                        return EventItem(
                          event: event,
                          markedAsFavourite: favIds.contains(event.id),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.h),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
