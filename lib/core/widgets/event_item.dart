import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/core/ex/date_ex.dart';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/features/create_event/event_details.dart';
import 'package:evently_app/firebase/firebase_service.dart';
import 'package:evently_app/model/event_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventItem extends StatefulWidget {
  EventItem({super.key, required this.event , required this.markedAsFavourite});
  EventModel event;
  bool markedAsFavourite;

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
late  bool favourite = widget.markedAsFavourite;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EventDetails(event:  widget.event)),
      ),
      child: Container(
        width: double.infinity,
      
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          image: DecorationImage(
            image: AssetImage(ImageAssets.meeting),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              margin: REdgeInsets.all(8),
              color: ColorsManager.whiteF4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.event.dateTime.getMonth,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            SizedBox(height: 97.h),
      
            Card(
              margin: REdgeInsets.all(8),
              color: ColorsManager.whiteF4,
      
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: REdgeInsets.all(8.0),
                      child: Text(
                        widget.event.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: favourite
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border),
                    color: ColorsManager.darkBlue,
                    onPressed: _markEventAsFavourite,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _markEventAsFavourite() async {
    if (favourite) {
      await FirebaseService.removeEventFromFavourite(widget.event);
    } else {
      await FirebaseService.addEventToFavourite(widget.event);
    }
    favourite = !favourite;
    setState(() {});
  }
}
