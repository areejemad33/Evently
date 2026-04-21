
import 'package:evently_app/core/ex/date_ex.dart';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/ui_utils/dialog_utils.dart';
import 'package:evently_app/features/create_event/edit_event.dart';
import 'package:evently_app/firebase/firebase_service.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/model/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDetails extends StatefulWidget {
  final EventModel event;

  const EventDetails({super.key, required this.event});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    bool isOwner =
        widget.event.ownerId == FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder<EventModel>(
      stream: FirebaseService()
          .getEventById(widget.event.id, context),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final event = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              appLocalization.event_details,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            actions: isOwner
                ? [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditEvent(event: event),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        DialogUtils.showConfirmationDialog(
                          context,
                          title: appLocalization.delete_event,
                          message: appLocalization.delete_event_message,
                          positiveButtonText: appLocalization.delete,
                          negativeButtonText: appLocalization.cancel,
                          onPositivePressed: () async {
                            await FirebaseService.deleteEvent(
                                context, event);

                            Navigator.pop(context);

                            DialogUtils.showToastMessage(
                              message: "Event deleted successfully",
                              backgroundColor: Colors.green,
                            );
                          },
                        );
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

                /// TITLE
                Text(
                  event.title,
                  style: Theme.of(context).textTheme.displayMedium,
                ),

                SizedBox(height: 16.h),

                /// DATE + TIME
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: ColorsManager.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: ColorsManager.whiteF4,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.date_range_outlined,
                          color: ColorsManager.darkBlue,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 10.h),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.dateTime.getMonth,
                            style:
                                Theme.of(context).textTheme.headlineMedium,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            event.dateTime.getFormattedTime,
                            style:
                                Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                Text(
                  appLocalization.description,
                  style: Theme.of(context).textTheme.displayLarge,
                ),

                SizedBox(height: 8.h),

                /// DESCRIPTION
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: ColorsManager.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    event.description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}