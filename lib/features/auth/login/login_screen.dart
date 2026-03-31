import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/core/utils/validator.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/core/widgets/custom_text_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                  "Login to your account",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 24.h),

                CustomTextFormField(
                  validator: Validator.validateEmail,
                  controller: _emailController,
                  hintText: "Enter your email",
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                SizedBox(height: 16.h),

                CustomTextFormField(
                  isSecure: securePassword,
                  validator: Validator.validatePassword,
                  controller: _passwordController,
                  hintText: "Enter your password",
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon:IconButton(onPressed: (){
                    setState(() {
                    securePassword = !securePassword; // f

                    });
                  }, icon: Icon(securePassword ? Icons.visibility_off : Icons.visibility)),
                ),
                SizedBox(height: 8.h),
                CustomTextButton(
                  title: "Forget Password ?",
                  align: TextAlign.end,
                ),

                SizedBox(height: 32.h),
                CustomElevatedButton(title: "Login", onClick: _login,),
                SizedBox(height: 32.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account ? ",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    CustomTextButton(
                      title: "Sign up",
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesManager.register,
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


  void _login(){
    if(_formKey.currentState?.validate() == false)return ;
  }
}
