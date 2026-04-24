import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/ui_utils/dialog_utils.dart';
import 'package:evently_app/firebase/firebase_service.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() =>
      _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title:  Text(appLocalization.forget_password, style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: Padding(
        padding: REdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
            
              Image.asset(
  ImageAssets.forgetPassword,
  height: 250.h,
  fit: BoxFit.fill,
),
    SizedBox(height: 20.h),
              /// 📧 EMAIL FIELD
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  if (!value.contains("@")) {
                    return "Enter valid email";
                  }
                  return null;
                },
              ),

              SizedBox(height: 24.h),

              /// 🔘 BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _resetPassword,
                  child: const Text("Send Reset Link"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔥 RESET PASSWORD FUNCTION
  void _resetPassword() async {
  if (!_formKey.currentState!.validate()) return;

  try {
    DialogUtils.showLoading(context);

    await FirebaseService.resetPassword(
      _emailController.text,
    );

    DialogUtils.hideDialog(context);

    DialogUtils.showToastMessage(
      message: "Reset link sent to your email",
      backgroundColor: Colors.green,
    );

    Navigator.pop(context);
  } catch (e) {
    DialogUtils.hideDialog(context);

    DialogUtils.showToastMessage(
      message: "Something went wrong",
      backgroundColor: Colors.red,
    );
  }
}
}