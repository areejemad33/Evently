
// abstract class Validator {
//   static String? validateName(String? name) {
//     if (name == null || name.trim().isEmpty) {
//       return "Name is required";
//     }
//     return null;
//   }

//   static String? validateEmail(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return "Email is required";
//     }

//     if (value.contains(" ")) {
//       return "Email can't contain spaces";
//     }

//     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');

//     if (!emailRegex.hasMatch(value.trim())) {
//       return "Invalid email format";
//     }

//     return null;
//   }

//   static String? validatePassword(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return "Password is required";
//     }

//     final password = value.trim();

//     if (password.length < 8) {
//       return "Minimum 8 characters required";
//     }

//     if (!RegExp(r'[A-Z]').hasMatch(password)) {
//       return "Add at least one uppercase letter";
//     }

//     if (!RegExp(r'[a-z]').hasMatch(password)) {
//       return "Add at least one lowercase letter";
//     }

//     if (!RegExp(r'[0-9]').hasMatch(password)) {
//       return "Add at least one number";
//     }

//     if (!RegExp(r'[!@#\$&*~]').hasMatch(password)) {
//       return "Add at least one special character";
//     }

//     return null;
//   }
// }

import 'package:evently_app/l10n/app_localizations.dart';

abstract class Validator {

  static String? validateName(String? name, AppLocalizations loc) {
    if (name == null || name.trim().isEmpty) {
      return loc.name_is_required;
    }
    return null;
  }

  static String? validateEmail(String? value, AppLocalizations loc) {
    if (value == null || value.trim().isEmpty) {
      return loc.email_is_required;
    }

    if (value.contains(" ")) {
      return loc.email_canot_contain_spaces;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');

    if (!emailRegex.hasMatch(value.trim())) {
      return loc.invalid_email_format;
    }

    return null;
  }

  static String? validatePassword(String? value, AppLocalizations loc) {
    if (value == null || value.trim().isEmpty) {
      return loc.password_is_required;
    }

    final password = value.trim();

    if (password.length < 8) {
      return loc.minimum_8_characters_required;
    }

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return loc.add_at_least_one_uppercase_letter;
    }

    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return loc.add_at_least_one_lowercase_letter;
    }

    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return loc.add_at_least_one_number;
    }

    if (!RegExp(r'[!@#\$&*~]').hasMatch(password)) {
      return loc.add_at_least_one_special_character;
    }

    return null;
  }
}