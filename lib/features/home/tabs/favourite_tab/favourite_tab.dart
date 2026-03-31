import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/model/category_model.dart';
import 'package:evently_app/model/event_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../home_tab/event_item.dart';

class FavouriteTab extends StatelessWidget {
  const FavouriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomTextFormField(hintText: "Search for event", suffixIcon: Icon(Icons.search),),
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
