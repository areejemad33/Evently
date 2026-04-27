import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @login_to_your_account.
  ///
  /// In en, this message translates to:
  /// **'Login to your accunt'**
  String get login_to_your_account;

  /// No description provided for @enter_your_email.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enter_your_email;

  /// No description provided for @enter_your_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enter_your_password;

  /// No description provided for @forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forget Password ?'**
  String get forget_password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @dont_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account ? '**
  String get dont_have_an_account;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'SignUp'**
  String get signup;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @login_with_google.
  ///
  /// In en, this message translates to:
  /// **'Login With Google'**
  String get login_with_google;

  /// No description provided for @create_your_account.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get create_your_account;

  /// No description provided for @enter_your_name.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enter_your_name;

  /// No description provided for @confirm_your_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirm_your_password;

  /// No description provided for @already_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get already_have_an_account;

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back ✨'**
  String get welcome_back;

  /// No description provided for @aLL.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get aLL;

  /// No description provided for @sport.
  ///
  /// In en, this message translates to:
  /// **'Sport'**
  String get sport;

  /// No description provided for @birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get birthday;

  /// No description provided for @book_club.
  ///
  /// In en, this message translates to:
  /// **'Book Club'**
  String get book_club;

  /// No description provided for @meeting.
  ///
  /// In en, this message translates to:
  /// **'Meeting'**
  String get meeting;

  /// No description provided for @exhibtion.
  ///
  /// In en, this message translates to:
  /// **'Exhibtion'**
  String get exhibtion;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @favourite.
  ///
  /// In en, this message translates to:
  /// **'Favourite'**
  String get favourite;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @search_for_event.
  ///
  /// In en, this message translates to:
  /// **'Search for event'**
  String get search_for_event;

  /// No description provided for @dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get dark_mode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @add_event.
  ///
  /// In en, this message translates to:
  /// **'Add Event'**
  String get add_event;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @event_title.
  ///
  /// In en, this message translates to:
  /// **'Event Title'**
  String get event_title;

  /// No description provided for @event_decription.
  ///
  /// In en, this message translates to:
  /// **'Event Description'**
  String get event_decription;

  /// No description provided for @event_date.
  ///
  /// In en, this message translates to:
  /// **'Event_Date'**
  String get event_date;

  /// No description provided for @event_time.
  ///
  /// In en, this message translates to:
  /// **'Event_Time'**
  String get event_time;

  /// No description provided for @choose_time.
  ///
  /// In en, this message translates to:
  /// **'Choose time'**
  String get choose_time;

  /// No description provided for @choose_date.
  ///
  /// In en, this message translates to:
  /// **'Choose date'**
  String get choose_date;

  /// No description provided for @event_details.
  ///
  /// In en, this message translates to:
  /// **'Event details'**
  String get event_details;

  /// No description provided for @update_event.
  ///
  /// In en, this message translates to:
  /// **'Update Event'**
  String get update_event;

  /// No description provided for @name_is_required.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get name_is_required;

  /// No description provided for @email_is_required.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get email_is_required;

  /// No description provided for @password_is_required.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get password_is_required;

  /// No description provided for @please_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Please, confirm password'**
  String get please_confirm_password;

  /// No description provided for @email_canot_contain_spaces.
  ///
  /// In en, this message translates to:
  /// **'Email can\'t contain spaces'**
  String get email_canot_contain_spaces;

  /// No description provided for @invalid_email_format.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get invalid_email_format;

  /// No description provided for @minimum_8_characters_required.
  ///
  /// In en, this message translates to:
  /// **'Minimum 8 characters required'**
  String get minimum_8_characters_required;

  /// No description provided for @add_at_least_one_uppercase_letter.
  ///
  /// In en, this message translates to:
  /// **'Add at least one uppercase letter'**
  String get add_at_least_one_uppercase_letter;

  /// No description provided for @add_at_least_one_lowercase_letter.
  ///
  /// In en, this message translates to:
  /// **'Add at least one lowercase letter'**
  String get add_at_least_one_lowercase_letter;

  /// No description provided for @add_at_least_one_number.
  ///
  /// In en, this message translates to:
  /// **'Add at least one number'**
  String get add_at_least_one_number;

  /// No description provided for @add_at_least_one_special_character.
  ///
  /// In en, this message translates to:
  /// **'Add at least one special character'**
  String get add_at_least_one_special_character;

  /// No description provided for @password_doesnot_match.
  ///
  /// In en, this message translates to:
  /// **'Password doesn\'t match'**
  String get password_doesnot_match;

  /// No description provided for @weak_password.
  ///
  /// In en, this message translates to:
  /// **'The password provided is too weak. '**
  String get weak_password;

  /// No description provided for @email_already_in_use.
  ///
  /// In en, this message translates to:
  /// **'The account already exists for that email.'**
  String get email_already_in_use;

  /// No description provided for @something_went_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get something_went_wrong;

  /// No description provided for @account_created_successfully.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully'**
  String get account_created_successfully;

  /// No description provided for @logged_in_successfully.
  ///
  /// In en, this message translates to:
  /// **'Logged in successfully'**
  String get logged_in_successfully;

  /// No description provided for @wrong_email_or_password.
  ///
  /// In en, this message translates to:
  /// **'Wrong email or password'**
  String get wrong_email_or_password;

  /// No description provided for @event_created.
  ///
  /// In en, this message translates to:
  /// **'Event created successfully'**
  String get event_created;

  /// No description provided for @no_events.
  ///
  /// In en, this message translates to:
  /// **'No events yet'**
  String get no_events;

  /// No description provided for @delete_event.
  ///
  /// In en, this message translates to:
  /// **'Delete Event'**
  String get delete_event;

  /// No description provided for @delete_event_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this event ?'**
  String get delete_event_message;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @edit_event.
  ///
  /// In en, this message translates to:
  /// **'Edit Event'**
  String get edit_event;

  /// No description provided for @please_fill_all_fields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields'**
  String get please_fill_all_fields;

  /// No description provided for @event_updated_successfully.
  ///
  /// In en, this message translates to:
  /// **'Event updated successfully'**
  String get event_updated_successfully;

  /// No description provided for @signup_with_google.
  ///
  /// In en, this message translates to:
  /// **'Sign up with Google'**
  String get signup_with_google;

  /// No description provided for @onboarding_title_1.
  ///
  /// In en, this message translates to:
  /// **'Personalize Your Experience'**
  String get onboarding_title_1;

  /// No description provided for @onboarding_desc_1.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.'**
  String get onboarding_desc_1;

  /// No description provided for @onboarding_title_2.
  ///
  /// In en, this message translates to:
  /// **'Find Events That Inspire You'**
  String get onboarding_title_2;

  /// No description provided for @onboarding_desc_2.
  ///
  /// In en, this message translates to:
  /// **'Dive into a world of events crafted to fit your unique interests. Whether you\'re into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.'**
  String get onboarding_desc_2;

  /// No description provided for @onboarding_title_3.
  ///
  /// In en, this message translates to:
  /// **'Effortless Event Planning'**
  String get onboarding_title_3;

  /// No description provided for @onboarding_desc_3.
  ///
  /// In en, this message translates to:
  /// **'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.'**
  String get onboarding_desc_3;

  /// No description provided for @onboarding_title_4.
  ///
  /// In en, this message translates to:
  /// **'Connect with Friends & Share Moments'**
  String get onboarding_title_4;

  /// No description provided for @onboarding_desc_4.
  ///
  /// In en, this message translates to:
  /// **'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.'**
  String get onboarding_desc_4;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @lets_start.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Start'**
  String get lets_start;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @get_started.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get get_started;

  /// No description provided for @event_deleted.
  ///
  /// In en, this message translates to:
  /// **'Event deleted successfully'**
  String get event_deleted;

  /// No description provided for @reminder.
  ///
  /// In en, this message translates to:
  /// **'This Event will start in one hour.'**
  String get reminder;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
