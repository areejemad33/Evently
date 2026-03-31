


import 'package:evently_app/core/ex/date_ex.dart';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/widgets/custom_tab_bar.dart';
import 'package:evently_app/core/widgets/custom_text_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CreateEvent extends StatefulWidget {
   CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  DateTime selectedDateTime = DateTime.now(); /// 24/3/2026 -> 9:44
  TimeOfDay pickedTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
  print(selectedDateTime.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text("Create Event"),
      ),
      body: Padding(
        padding:  REdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.asset(ImageAssets.meeting)),
            SizedBox(height: 16.h,),

            CustomTabBar(categories: CategoryModel.categories,),
            SizedBox(height: 16.h,),
            Text("Title", style: Theme.of(context).textTheme.displayLarge,),
            SizedBox(height: 8.h,),
            CustomTextFormField(hintText: "Event title"),
            SizedBox(height: 16.h,),
            Text("Description", style: Theme.of(context).textTheme.displayLarge,),
            SizedBox(height: 8.h,),
            CustomTextFormField(hintText: "Event description", maxLines: 4,),
SizedBox(height: 16.h,),
            Row(
              children: [
                Icon(Icons.date_range_outlined),
                SizedBox(width: 4.w,),
                Text(selectedDateTime.getFormattedDate, style: Theme.of(context).textTheme.displayLarge,),
                Spacer(),
                CustomTextButton(
                  title: "Choose Date", onTap: _selectEventData
                   ,)
              ],
            ),
            SizedBox(height: 20.h,),
            Row(
              children: [
                Icon(Icons.access_time),
                SizedBox(width: 4.w,),
                Text(selectedDateTime.getFormattedTime, style: Theme.of(context).textTheme.displayLarge,),
                Spacer(),
                CustomTextButton(title: "Choose Time", onTap: _chooseEventTime,)
              ],
            ),

          ],
        ),
      ),
    );
  }

  void _selectEventData()async {
 selectedDateTime = await   showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 365))) ?? selectedDateTime;
 selectedDateTime = selectedDateTime.copyWith(hour: pickedTime.hour, minute: pickedTime.minute);
 setState(() {

  });
  }
  


  void _chooseEventTime() async{
  pickedTime = await  showTimePicker(context: context, initialTime: TimeOfDay.now()) ??pickedTime ;
 selectedDateTime = selectedDateTime.copyWith(hour: pickedTime.hour, minute: pickedTime.minute);
 setState(() {

 });
  }

}
