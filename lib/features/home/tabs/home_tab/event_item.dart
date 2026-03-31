import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/model/event_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventItem extends StatelessWidget {
   EventItem({super.key, required this.event});
  EventModel event;

  @override
  Widget build(BuildContext context) {
    return Container(

      width: double.infinity,

      decoration: BoxDecoration(
borderRadius: BorderRadius.circular(16.r),
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(ImageAssets.meeting)),
      ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            margin: REdgeInsets.all(8),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r)
            ),
            color: ColorsManager.whiteF4,
            child: Padding(
              padding:  REdgeInsets.all(8.0),
              child: Text("21 Jan", style: Theme.of(context).textTheme.titleSmall,),
            ),
          ),
          SizedBox(height: 97.h,),
          Card(
            margin: REdgeInsets.all(8),
            child: Padding(
              padding:  REdgeInsets.all(8.0),
              child: Row(children: [
                Expanded(child: Text(event.title, style: Theme.of(context).textTheme.titleMedium,)),
                Icon(Icons.favorite_border, color: ColorsManager.blue,)
              ],),
            ),
          )
        ],
      ),
    );
  }
}
