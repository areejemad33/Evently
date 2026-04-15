import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/core/utils/validator.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/core/widgets/custom_text_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/l10n/app_localizations.dart';

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
                appLocalizations.create_your_account,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 24.h),

                CustomTextFormField(
  validator: (value) => Validator.validateName(value, appLocalizations),
                  controller: _nameController,
                  hintText: appLocalizations.enter_your_name,
                  prefixIcon: Icon(Icons.person_2_outlined),
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
  validator: (value) => Validator.validateEmail(value, appLocalizations),
                  controller: _emailController,
                  hintText: appLocalizations.enter_your_email,
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                SizedBox(height: 16.h),

                CustomTextFormField(
                  isSecure: securePassword,
  validator: (value) => Validator.validatePassword(value, appLocalizations),
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
                CustomElevatedButton(title: appLocalizations.signup, onClick: _register),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _register() {
    if (_formKey.currentState?.validate() == false) return;
  }
}
