import 'package:evently_app/core/ex/date_ex.dart';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/ui_utils/dialog_utils.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/core/widgets/custom_tab_bar.dart';
import 'package:evently_app/core/widgets/custom_text_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/firebase/firebase_service.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/model/category_model.dart';
import 'package:evently_app/model/event_model.dart';
import 'package:evently_app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  late AppLocalizations appLocalization = AppLocalizations.of(context)!;
  DateTime selectedDateTime = DateTime.now();
  late CategoryModel selectedCategory = CategoryModel.getCategories(context)[0];

  /// 24/3/2026 -> 9:44
  TimeOfDay pickedTime = TimeOfDay.now();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
      final appLocalization = AppLocalizations.of(context)!;
final isDark = Theme.of(context).brightness == Brightness.dark;
final image = selectedCategory.getImage(isDark);
    return Scaffold(
      appBar: AppBar(title: Text(appLocalization.add_event)),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child:  ClipRRect(
  borderRadius: BorderRadius.circular(16.r),
  child:Image.asset(image, fit: BoxFit.cover)
)
            ),
            SizedBox(height: 16.h),

            CustomTabBar(
              categories: CategoryModel.getCategories(context),
              onCategoryItemClicked: (newCategory) {
                selectedCategory = newCategory;
                setState(() {});
              },
            ),
            SizedBox(height: 16.h),
            Text("Title", style: Theme.of(context).textTheme.displayLarge),
            SizedBox(height: 8.h),
            CustomTextFormField(
              controller: _titleController,
              hintText: appLocalization.event_title,
            ),
            SizedBox(height: 16.h),
            Text(
              "Description",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            SizedBox(height: 8.h),
            CustomTextFormField(
              controller: _descriptionController,
              hintText: appLocalization.event_decription,
              maxLines: 4,
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Icon(Icons.date_range_outlined),
                SizedBox(width: 4.w),
                Text(
                  selectedDateTime.getFormattedDate,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Spacer(),
                CustomTextButton(title: "Choose Date", onTap: _selectEventData),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Icon(Icons.access_time),
                SizedBox(width: 4.w),
                Text(
                  selectedDateTime.getFormattedTime,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Spacer(),
                CustomTextButton(title: "Choose Time", onTap: _chooseEventTime),
              ],
            ),
            SizedBox(height: 24.h),
            CustomElevatedButton(title: "Add Event", onClick: _addEvent),
          ],
        ),
      ),
    );
  }

  void _addEvent() async {
  if (_titleController.text.trim().isEmpty) {
    DialogUtils.showToastMessage(
      message: "Title cannot be empty",
      backgroundColor: Colors.red,
    );
    return;
  }

  EventModel event = EventModel(
    ownerId: UserModel.currentUser!.id,
    id: "",
    category: selectedCategory,
  
    title: _titleController.text.trim(),
    description: _descriptionController.text.trim(),
    dateTime: selectedDateTime,
  );

  DialogUtils.showLoading(context);

  await FirebaseService.addEventToFireStore(event, context);

  DialogUtils.hideDialog(context);

  DialogUtils.showToastMessage(
    message: appLocalization.event_created,
    backgroundColor: Colors.green,
  );

  Navigator.pop(context);
}
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

  void _chooseEventTime() async {
    pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now()) ??
        pickedTime;
    selectedDateTime = selectedDateTime.copyWith(
      hour: pickedTime.hour,
      minute: pickedTime.minute,
    );
    setState(() {});
  }
}
