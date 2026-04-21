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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool securePassword = true;
  


  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  late AppLocalizations appLocalizations = AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
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
                  appLocalizations.login_to_your_account,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 24.h),

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
                  // validator: (value) =>
                  //     Validator.validatePassword(value, appLocalizations),
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
                SizedBox(height: 8.h),
                CustomTextButton(
                  title: appLocalizations.forget_password,
                  align: TextAlign.end,
                ),

                SizedBox(height: 32.h),
                CustomElevatedButton(
                  title: appLocalizations.login,
                  onClick: _login,
                ),
                SizedBox(height: 32.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      appLocalizations.dont_have_an_account,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    CustomTextButton(
                      title: appLocalizations.signup,
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesManager.register,
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
      child: Text(appLocalizations.or, style: Theme.of(context).textTheme.titleLarge,),
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
        appLocalizations.login_with_google,
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
  void _login() async {
    if (_formKey.currentState?.validate() == false) return;

    try {
      DialogUtils.showLoading(context, dismissible: false);

      UserCredential userCredential = await FirebaseService.login(
        email: _emailController.text,
        password: _passwordController.text,
      );
      UserModel.currentUser = await FirebaseService.getUserFromFireStore(
        userCredential.user!.uid,
      );

      DialogUtils.hideDialog(context);

      DialogUtils.showToastMessage(
        message: appLocalizations.logged_in_successfully,
        backgroundColor: Colors.green,
      );

      Navigator.pushReplacementNamed(context, RoutesManager.homeScreen);
    } on FirebaseAuthException catch (exception) {
      DialogUtils.hideDialog(context);

      if (exception.code == 'invalid-credential') {
        DialogUtils.showToastMessage(
          message: appLocalizations.wrong_email_or_password,
          backgroundColor: Colors.red,
        );
      } else if (exception.code == 'user-not-found') {
        DialogUtils.showToastMessage(
          message: appLocalizations.wrong_email_or_password,
          backgroundColor: Colors.red,
        );
      } else if (exception.code == 'wrong-password') {
        DialogUtils.showToastMessage(
          message: appLocalizations.wrong_email_or_password,
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
