import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(ImageAssets.profileImage, height: 104.h),
        Text(
          "Muhammed Saad",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        Text(
          "moo@gmail.com",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        SizedBox(height: 32.h),
        Container(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Theme.of(context).dividerColor,
              width: 1.w,
            ),
            color: Theme.of(context).primaryColor,
          ),
          width: double.infinity,
          child: Row(
            children: [
              Text(
                "Dark Mode",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Spacer(),
              Switch(value: false, onChanged: (_) {}),
            ],
          ),
        ),

        SizedBox(height: 16.h),

        DropdownMenu(

          dropdownMenuEntries: ["English", "Arabic"]
              .map((text) => DropdownMenuEntry(value: text, label: text))
              .toList(),
          label: const Text('English'),
          width: 300,

          enableFilter: true,
          menuStyle:   MenuStyle(
    alignment: Alignment.bottomRight,

   // MaterialStatePropertyAll(Size.fromHeight(124)),),
        ))
        ,SizedBox(height: 16.h,),
        Container(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Theme.of(context).dividerColor,
              width: 1.w,
            ),
            color: Theme.of(context).primaryColor,
          ),
          width: double.infinity,
          child: Row(
            children: [
              Text(
                "Logout",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Spacer(),
            Icon(Icons.logout, color: Colors.red,)
            ],
          ),
        ),
      ],
    );
  }
}
