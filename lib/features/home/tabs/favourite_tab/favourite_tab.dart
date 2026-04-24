// import 'package:evently_app/core/widgets/custom_text_form_field.dart';
// import 'package:evently_app/firebase/firebase_service.dart';
// import 'package:evently_app/l10n/app_localizations.dart';
// import 'package:evently_app/model/event_model.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../../core/widgets/event_item.dart';

// class FavouriteTab extends StatefulWidget {
//   FavouriteTab({super.key});

//   @override
//   State<FavouriteTab> createState() => _FavouriteTabState();
// }

// class _FavouriteTabState extends State<FavouriteTab> {
//   List<EventModel> allEvents = [];

//   List<EventModel> filteredEvents = [];

//   String searchQuery = "";

//   @override
//   Widget build(BuildContext context) {
//     late AppLocalizations appLocalizations = AppLocalizations.of(context)!;

//     return SafeArea(
//       child: Column(
//         children: [
//           CustomTextFormField(
//             hintText: appLocalizations.search_for_event,
//              onChanged: (value) {
//     filterEventsBySearchKey(value);
//   },
//             suffixIcon: Icon(Icons.search),
//           ),
//           FutureBuilder(
//             future: FirebaseService.getFavouriteEvents(context),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(
//                   child: Text(appLocalizations.something_went_wrong),
//                 );
//               } else if (snapshot.data!.isEmpty) {
//                 return Center(child: Text(appLocalizations.no_events));
//               } else {
//   allEvents = snapshot.data!;

//   if (searchQuery.isEmpty) {
//     filteredEvents = allEvents;
//   }

//   return Expanded(
//     child: ListView.separated(
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//       itemCount: filteredEvents.length,
//       itemBuilder: (context, index) => EventItem(
//         event: filteredEvents[index],
//         markedAsFavourite: true,
//       ),
//       separatorBuilder: (context, index) =>
//           SizedBox(height: 16.h),
//     ),
//   );
// }
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   String normalize(String text) {
//   return text
//       .toLowerCase()
//       .replaceAll('أ', 'ا')
//       .replaceAll('إ', 'ا')
//       .replaceAll('آ', 'ا')
//       .replaceAll('ة', 'ه')
//       .replaceAll('ى', 'ي');
// }

// void filterEventsBySearchKey(String searchKey) {
//   final query = normalize(searchKey);

//   filteredEvents = allEvents.where((event) {
//     final title = normalize(event.title);
//     final description = normalize(event.description);

//     return title.contains(query) || description.contains(query);
//   }).toList();

//   setState(() {});
// }
// }


import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/firebase/firebase_service.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/event_item.dart';

class FavouriteTab extends StatefulWidget {
  const FavouriteTab({super.key});

  @override
  State<FavouriteTab> createState() => _FavouriteTabState();
}

class _FavouriteTabState extends State<FavouriteTab> {
  List<EventModel> allEvents = [];
  String searchQuery = "";

  /// 🔍 normalize
  String normalize(String text) {
    return text
        .toLowerCase()
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا')
        .replaceAll('ة', 'ه')
        .replaceAll('ى', 'ي');
  }


  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return SafeArea(
      child: Column(
        children: [
          /// 🔍 SEARCH
          CustomTextFormField(
            hintText: appLocalizations.search_for_event,
            suffixIcon: const Icon(Icons.search),
          onChanged: (value) {
  setState(() {
    searchQuery = value;
  });
},
          ),

          /// 📡 STREAM (REAL TIME)
          Expanded(
            child: StreamBuilder<List<EventModel>>(
              stream: FirebaseService.getFavouriteEventsRealTime(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(appLocalizations.something_went_wrong),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(appLocalizations.no_events),
                  );
                }

                /// 📦 raw data from stream
                final events = snapshot.data!;

                /// 🔥 apply search on stream data
                final filtered = searchQuery.isEmpty
                    ? events
                    : events.where((event) {
                        final title = normalize(event.title);
                        final description = normalize(event.description);
                        final query = normalize(searchQuery);

                        return title.contains(query) ||
                            description.contains(query);
                      }).toList();

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 24),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) => EventItem(
                    event: filtered[index],
                    markedAsFavourite: true,
                  ),
                  separatorBuilder: (context, index) =>
                      SizedBox(height: 16.h),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}