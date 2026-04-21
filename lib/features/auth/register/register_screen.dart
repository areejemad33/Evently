import 'dart:developer';

import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/core/ui_utils/dialog_utils.dart';
import 'package:evently_app/core/utils/validator.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/core/widgets/custom_text_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/firebase/firebase_service.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _nameController;

  late TextEditingController _emailController;

  late TextEditingController _passwordController;

  late TextEditingController _confirmPasswordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool securePassword = true;
  bool secureConfirmPassword = true;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  late AppLocalizations appLocalizations;
  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(ImageAssets.evenltyLogo),
                SizedBox(height: 16.h),
                Text(
                  appLocalizations.create_your_account,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 24.h),

                CustomTextFormField(
                  validator: (value) =>
                      Validator.validateName(value, appLocalizations),
                  controller: _nameController,
                  hintText: appLocalizations.enter_your_name,
                  prefixIcon: Icon(Icons.person_2_outlined),
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  validator: (value) =>
                      Validator.validateEmail(value, appLocalizations),
                  controller: _emailController,
                  hintText: appLocalizations.enter_your_email,
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                SizedBox(height: 16.h),

                CustomTextFormField(
                  isSecure: securePassword,
                  validator: (value) =>
                      Validator.validatePassword(value, appLocalizations),
                  controller: _passwordController,
                  hintText: appLocalizations.enter_your_password,
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        securePassword = !securePassword;
                      });
                    },
                    icon: Icon(
                      securePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                CustomTextFormField(
                  isSecure: secureConfirmPassword,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return appLocalizations.please_confirm_password;
                    }
                    if (input != _passwordController.text) {
                      return appLocalizations.password_doesnot_match;
                    }
                    return null;
                  },
                  controller: _confirmPasswordController,
                  hintText: appLocalizations.confirm_your_password,
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        secureConfirmPassword = !secureConfirmPassword;
                      });
                    },
                    icon: Icon(
                      secureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                SizedBox(height: 60.h),
                CustomElevatedButton(
                  title: appLocalizations.signup,
                  onClick: _register,
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      appLocalizations.already_have_an_account,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    CustomTextButton(
                      title: appLocalizations.login,
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesManager.login,
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                Row(
  children: [
    Expanded(
      child: Divider(
      
        color: ColorsManager.grey,
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(appLocalizations.or , style: Theme.of(context).textTheme.titleLarge,),
    ),
    Expanded(
      child: Divider(
    
        color: Colors.grey,
      ),
    ),
  ],
),
                SizedBox(height: 24.h),

                ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: ColorsManager.darkBlue,
    elevation: 0,
    side: BorderSide(color: Colors.grey.shade300),
    padding: EdgeInsets.symmetric(vertical: 12),
  ),
  onPressed: signInWithGoogle,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Image.asset(
  ImageAssets.googleLogo,
  width: 40,
  height: 40,
),
      SizedBox(width: 10),
      Text(
        appLocalizations.signup_with_google,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  ),
)
              ],
            ),
          ),
        ),
      ),
    );
  }

Future<void> signInWithGoogle() async {
  try {
    DialogUtils.showLoading(context, dismissible: false);

    UserModel? user =
        await FirebaseService.signInWithGoogle();

    if (user == null) {
      DialogUtils.hideDialog(context);
      return;
    }

    UserModel.currentUser = user;

    await FirebaseService.addUserToFireStore(user);

    DialogUtils.hideDialog(context);

    DialogUtils.showToastMessage(
      message: appLocalizations.logged_in_successfully,
      backgroundColor: Colors.green,
    );

    Navigator.pushReplacementNamed(
      context,
      RoutesManager.homeScreen,
    );
  } catch (e) {
    DialogUtils.hideDialog(context);

    DialogUtils.showToastMessage(
      message: appLocalizations.something_went_wrong,
      backgroundColor: Colors.red,
    );
  }
}
  void _register() async {
    if (_formKey.currentState?.validate() == false) return;
    try {
      DialogUtils.showLoading(context, dismissible: false);
      UserCredential userCredential = await FirebaseService.register(
        email: _emailController.text,
        password: _passwordController.text,
      );
    
      DialogUtils.hideDialog(context);
      UserModel user = UserModel(
        id: userCredential.user!.uid,
        name: _nameController.text,
        email: _emailController.text, favouriteEventsIds: [],
      );
      await FirebaseService.addUserToFireStore(user);
      DialogUtils.showToastMessage(
        message: appLocalizations.account_created_successfully,
        backgroundColor: Colors.green,
      );
      Navigator.pushReplacementNamed(context, RoutesManager.login);
    } on FirebaseAuthException catch (exception) {
      DialogUtils.hideDialog(context);
      if (exception.code == 'weak-password') {
        DialogUtils.showToastMessage(
          message: appLocalizations.weak_password,
          backgroundColor: Colors.red,
        );
      } else if (exception.code == 'email-already-in-use') {
        DialogUtils.showToastMessage(
          message: appLocalizations.email_already_in_use,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showToastMessage(
        message: appLocalizations.something_went_wrong,
        backgroundColor: Colors.red,
      );
    }
  }
}
