import 'package:evently_app/core/ex/date_ex.dart';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/ui_utils/dialog_utils.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/core/widgets/custom_tab_bar.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/firebase/firebase_service.dart';
import 'package:evently_app/firebase/notifications_service.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/model/category_model.dart';
import 'package:evently_app/model/event_model.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EditEvent extends StatefulWidget {
  final EventModel event;

  const EditEvent({super.key, required this.event});

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  late AppLocalizations appLocalization = AppLocalizations.of(context)!;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  late CategoryModel selectedCategory;
  late DateTime selectedDateTime;
  late TimeOfDay pickedTime;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.event.title);
    _descriptionController =
        TextEditingController(text: widget.event.description);

    selectedCategory = widget.event.category;
    selectedDateTime = widget.event.dateTime;
    pickedTime = TimeOfDay.fromDateTime(widget.event.dateTime);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appLocalization = AppLocalizations.of(context)!;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(appLocalization.edit_event)),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.asset(
                themeProvider.isDark
                    ? selectedCategory.darkImage
                    : selectedCategory.image,
              ),
            ),

            SizedBox(height: 16.h),

            /// CATEGORY
            CustomTabBar(
              categories: CategoryModel.getCategories(context),
              onCategoryItemClicked: (newCategory) {
                selectedCategory = newCategory;
                setState(() {});
              },
            ),

            SizedBox(height: 16.h),

            /// TITLE
            Text(appLocalization.title,
                style: Theme.of(context).textTheme.displayLarge),
            SizedBox(height: 8.h),
            CustomTextFormField(
              controller: _titleController,
              hintText: appLocalization.event_title,
            ),

            SizedBox(height: 16.h),

            /// DESCRIPTION
            Text(appLocalization.description,
                style: Theme.of(context).textTheme.displayLarge),
            SizedBox(height: 8.h),
            CustomTextFormField(
              controller: _descriptionController,
              hintText: appLocalization.event_decription,
              maxLines: 4,
            ),

            SizedBox(height: 24.h),

            /// DATE
            Row(
              children: [
                Icon(Icons.date_range_outlined,
                    color: ColorsManager.darkBlue),
                SizedBox(width: 8.w),
                Text(appLocalization.event_date,
                    style: Theme.of(context).textTheme.displayLarge),
                Spacer(),
                GestureDetector(
                  onTap: _selectEventData,
                  child: Text(
                    selectedDateTime.getFormattedDate,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: ColorsManager.darkBlue,
                          decoration: TextDecoration.underline,
                          decorationColor: ColorsManager.darkBlue,
                        ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            /// TIME
            Row(
              children: [
                Icon(Icons.access_time, color: ColorsManager.darkBlue),
                SizedBox(width: 8.w),
                Text(appLocalization.event_time,
                    style: Theme.of(context).textTheme.displayLarge),
                Spacer(),
                GestureDetector(
                  onTap: _chooseEventTime,
                  child: Text(
                    selectedDateTime.getFormattedTime,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: ColorsManager.darkBlue,
                          decoration: TextDecoration.underline,
                          decorationColor: ColorsManager.darkBlue,
                        ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 40.h),

            /// UPDATE BUTTON
            CustomElevatedButton(
              title: appLocalization.update_event,
              onClick: _updateEvent,
            ),
          ],
        ),
      ),
    );
  }

  /// 🔥 UPDATE EVENT + NOTIFICATION FIX
  void _updateEvent() async {
    if (_titleController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty) {
      DialogUtils.showToastMessage(
        message: appLocalization.please_fill_all_fields,
        backgroundColor: Colors.red,
      );
      return;
    }

    final updatedEvent = widget.event.copyWith(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: selectedCategory,
      dateTime: selectedDateTime,
    );

    DialogUtils.showLoading(context);

    // 🔴 1. cancel old notification
    await NotificationService.cancelNotification(
      widget.event.id.hashCode,
    );

    // 🟢 2. update firebase
    await FirebaseService.updateEvent(context, updatedEvent);

    // 🔵 3. schedule new notification
    DateTime reminderTime =
        selectedDateTime.subtract(Duration(hours: 1));

    if (reminderTime.isBefore(DateTime.now())) {
      reminderTime = DateTime.now().add(Duration(seconds: 5));
    }

    await NotificationService.scheduleNotification(
      id: updatedEvent.id.hashCode,
      title: updatedEvent.title,
      body: appLocalization.reminder,
      scheduledTime: reminderTime,
    );

    DialogUtils.hideDialog(context);

    DialogUtils.showToastMessage(
      message: appLocalization.event_updated_successfully,
      backgroundColor: Colors.green,
    );

    Navigator.pop(context, updatedEvent);
  }

  /// DATE
  void _selectEventData() async {
    selectedDateTime =
        await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365)),
            ) ??
            selectedDateTime;

    selectedDateTime = selectedDateTime.copyWith(
      hour: pickedTime.hour,
      minute: pickedTime.minute,
    );

    setState(() {});
  }

  /// TIME
  void _chooseEventTime() async {
    pickedTime =
        await showTimePicker(
              context: context,
              initialTime: pickedTime,
            ) ??
            pickedTime;

    selectedDateTime = selectedDateTime.copyWith(
      hour: pickedTime.hour,
      minute: pickedTime.minute,
    );

    setState(() {});
  }
}