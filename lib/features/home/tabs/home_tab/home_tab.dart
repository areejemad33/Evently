
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/widgets/custom_tab_bar.dart';
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
                      "Welcome Back ✨",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      "Muhammed Saad",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.light_mode_outlined, color: ColorsManager.blue),
                Card(
                  color: ColorsManager.blue,
                  child: Padding(
                    padding: REdgeInsets.symmetric(vertical: 5, horizontal: 8),
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
          CustomTabBar(categories: CategoryModel.categoriesWithAll,),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              itemBuilder: (context, index) => EventItem(
                event: EventModel(
                  id: "1",
                  category: CategoryModel.categories[0],
                  title: "Meeting for Updating The Development Method ",
                  description: "Meeting for Updating The Development Method ",
                  date: DateTime.now(),
                  time: TimeOfDay.now(),
                ),
              ),

              separatorBuilder: (context, index)=>SizedBox(height: 16.h,),
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
