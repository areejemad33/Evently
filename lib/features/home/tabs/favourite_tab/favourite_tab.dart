import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/firebase/firebase_service.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/model/event_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/event_item.dart';

class FavouriteTab extends StatelessWidget {
  FavouriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    late AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return SafeArea(
      child: Column(
        children: [
          CustomTextFormField(
            hintText: appLocalizations.search_for_event,
            suffixIcon: Icon(Icons.search),
          ),
          FutureBuilder(
            future: FirebaseService.getFavouriteEvents(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(appLocalizations.something_went_wrong),
                );
              } else if (snapshot.data!.isEmpty) {
                return Center(child: Text(appLocalizations.no_events));
              } else {
                List<EventModel> favouriteEvents = snapshot.data!;
                return Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    itemBuilder: (context, index) => EventItem(
                      event: favouriteEvents[index],
                      markedAsFavourite: true,
                    ),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h),
                    itemCount: favouriteEvents.length,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
