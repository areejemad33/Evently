import 'package:evently_app/core/ex/date_ex.dart';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/firebase/firebase_service.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/model/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDetails extends StatefulWidget {
  EventModel event; 
   EventDetails({super.key , required this.event});

  @override
  State<EventDetails> createState() => _EventDetailsState();
  
}

class _EventDetailsState extends State<EventDetails> {

  @override
  Widget build(BuildContext context) {
  
    final appLocalization = AppLocalizations.of(context)!;
  bool isOwner =
    widget.event.ownerId ==
    FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalization.event_details, style: Theme.of(context).textTheme.headlineMedium),
        actions: isOwner
    ? [
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {

          },
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
  
  },
        ),
      ]
    : [],
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            
        
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.asset(ImageAssets.meeting), 
            ),

            SizedBox(height: 16.h),

          
            Text(
              widget.event.title,
              style: Theme.of(context).textTheme.displayMedium,
            ),

            SizedBox(height: 16.h),

            Container(
  padding: EdgeInsets.all(12.w),
  decoration: BoxDecoration(
    color: ColorsManager.white,
    borderRadius: BorderRadius.circular(12.r),
  
  ),
  child: Row(
    children: [
      Column(
    
        children: [
Container(
  padding: EdgeInsets.all(15), 
  decoration: BoxDecoration(
    color: ColorsManager.whiteF4, 
    borderRadius: BorderRadius.circular(12), 
  ),
  child: Icon(
    Icons.date_range_outlined,
    color: ColorsManager.darkBlue,
    size: 30, 
  ),
)        ],
      ),
        SizedBox(width: 10.h),

          Column(
            children: [
              Column(
                  
                children: [
                
                  SizedBox(width: 8.w),
                  Text(
                    widget.event.dateTime.getMonth,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 4.h,),
                    Text(
                widget.event.dateTime.getFormattedTime,
                style: Theme.of(context).textTheme.displaySmall,
              ),
                ],
              ),
            ],
          ),
        
          
        
        ],
      ),
    
  
),

            SizedBox(height: 16.h),

        SizedBox(height: 12.h),

Text(
  appLocalization.description,
  style: Theme.of(context).textTheme.displayLarge,
),

SizedBox(height: 8.h),

Container(
  width: double.infinity,
padding: EdgeInsets.all(12.w),
  decoration: BoxDecoration(
    color: ColorsManager.white,
    borderRadius: BorderRadius.circular(12.r),
  
  ),
  child: Text(
    widget.event.description,
    style: Theme.of(context).textTheme.bodySmall,
  ),
),
          ],
        ),
      ),
    );
  }
}
