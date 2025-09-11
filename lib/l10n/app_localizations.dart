import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// No description provided for @landingPageFirstTitle.
  ///
  /// In en, this message translates to:
  /// **'Track Your Luggage'**
  String get landingPageFirstTitle;

  /// No description provided for @landingPageSecondTitle.
  ///
  /// In en, this message translates to:
  /// **'Real Time Tracking'**
  String get landingPageSecondTitle;

  /// No description provided for @landingPageThirdTitle.
  ///
  /// In en, this message translates to:
  /// **'Safely Retrieve'**
  String get landingPageThirdTitle;

  /// No description provided for @landingPageButtonTextNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get landingPageButtonTextNext;

  /// No description provided for @landingPageButtonTextStart.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get landingPageButtonTextStart;

  /// No description provided for @landingPageFirstText.
  ///
  /// In en, this message translates to:
  /// **'Connect your baggage ID to the BagFinder app and track your luggage throughout the entire trip!'**
  String get landingPageFirstText;

  /// No description provided for @landingPageSecondText.
  ///
  /// In en, this message translates to:
  /// **'Receive location updates for your luggage, ensuring peace of mind from check-in to arrival!'**
  String get landingPageSecondText;

  /// No description provided for @landingPageThirdText.
  ///
  /// In en, this message translates to:
  /// **'Get notified when your bag is near the pickup area and follow the app\'s directions to retrieve it quickly!'**
  String get landingPageThirdText;

  /// No description provided for @loginPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in!'**
  String get loginPageTitle;

  /// No description provided for @loginPageTitle2.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get loginPageTitle2;

  /// No description provided for @loginPageTitle2SecondLine.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get loginPageTitle2SecondLine;

  /// No description provided for @loginPageTitle3.
  ///
  /// In en, this message translates to:
  /// **'Need help?'**
  String get loginPageTitle3;

  /// No description provided for @loginPageTitle4.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get loginPageTitle4;

  /// No description provided for @loginPageTitle5.
  ///
  /// In en, this message translates to:
  /// **'Find your account'**
  String get loginPageTitle5;

  /// No description provided for @loginPageDoesntHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?Sign-up'**
  String get loginPageDoesntHaveAccount;

  /// No description provided for @loginPageForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Find your account'**
  String get loginPageForgotPassword;

  /// No description provided for @loginPageRememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get loginPageRememberMe;

  /// No description provided for @comeBackToHomepage.
  ///
  /// In en, this message translates to:
  /// **'Come back to Homepage'**
  String get comeBackToHomepage;

  /// No description provided for @loginPageButtonLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginPageButtonLogin;

  /// No description provided for @signUpPageButtonSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign-up'**
  String get signUpPageButtonSignUp;

  /// No description provided for @needHelpPageSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get needHelpPageSend;

  /// No description provided for @loginPageContactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support!'**
  String get loginPageContactSupport;

  /// No description provided for @forgotEmailPageButtonSendEmail.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get forgotEmailPageButtonSendEmail;

  /// No description provided for @emailPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get emailPlaceholder;

  /// No description provided for @sendEmailForConfimationPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Tell your e-mail for confirmation'**
  String get sendEmailForConfimationPlaceholder;

  /// No description provided for @sendEmailPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Send E-Mail'**
  String get sendEmailPlaceholder;

  /// No description provided for @passwordPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordPlaceholder;

  /// No description provided for @fullNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullNamePlaceholder;

  /// No description provided for @emailForContactPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'E-mail for Contact'**
  String get emailForContactPlaceholder;

  /// No description provided for @contactUsYourProblemPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Contact us your problem'**
  String get contactUsYourProblemPlaceholder;

  /// No description provided for @loginPageAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get loginPageAlreadyHaveAccount;

  /// No description provided for @loginPageClickHere.
  ///
  /// In en, this message translates to:
  /// **'Click here'**
  String get loginPageClickHere;

  /// No description provided for @helloUserHomepage.
  ///
  /// In en, this message translates to:
  /// **'Hello!,'**
  String get helloUserHomepage;

  /// No description provided for @greetingsFromBagFinder.
  ///
  /// In en, this message translates to:
  /// **'BagFinder wishes you a great trip!'**
  String get greetingsFromBagFinder;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pt': return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
