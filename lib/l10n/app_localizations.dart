import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

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
    Locale('it')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'TableTable'**
  String get appTitle;

  /// No description provided for @settingsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTooltip;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navReservations.
  ///
  /// In en, this message translates to:
  /// **'Reservations'**
  String get navReservations;

  /// No description provided for @navSuppliers.
  ///
  /// In en, this message translates to:
  /// **'Suppliers'**
  String get navSuppliers;

  /// No description provided for @navExpenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get navExpenses;

  /// No description provided for @homeTodayData.
  ///
  /// In en, this message translates to:
  /// **'Today\'s data'**
  String get homeTodayData;

  /// No description provided for @homeReservationsToday.
  ///
  /// In en, this message translates to:
  /// **'Today\'s reservations'**
  String get homeReservationsToday;

  /// No description provided for @homeTotalPeople.
  ///
  /// In en, this message translates to:
  /// **'Total people'**
  String get homeTotalPeople;

  /// No description provided for @homeRemainingSeats.
  ///
  /// In en, this message translates to:
  /// **'Remaining seats'**
  String get homeRemainingSeats;

  /// No description provided for @homeTotalSeats.
  ///
  /// In en, this message translates to:
  /// **'Total seats'**
  String get homeTotalSeats;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsSectionGeneral.
  ///
  /// In en, this message translates to:
  /// **'GENERAL'**
  String get settingsSectionGeneral;

  /// No description provided for @settingsSectionApp.
  ///
  /// In en, this message translates to:
  /// **'APP'**
  String get settingsSectionApp;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose app language'**
  String get settingsLanguageSubtitle;

  /// No description provided for @settingsLanguageItalian.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get settingsLanguageItalian;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// No description provided for @settingsPrimaryColor.
  ///
  /// In en, this message translates to:
  /// **'Primary color'**
  String get settingsPrimaryColor;

  /// No description provided for @settingsPrimaryColorPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Primary color'**
  String get settingsPrimaryColorPickerTitle;

  /// No description provided for @settingsPrimaryColorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the app color'**
  String get settingsPrimaryColorSubtitle;

  /// No description provided for @settingsMaxSeats.
  ///
  /// In en, this message translates to:
  /// **'Maximum seats'**
  String get settingsMaxSeats;

  /// No description provided for @settingsMaxSeatsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set the people limit'**
  String get settingsMaxSeatsSubtitle;

  /// No description provided for @settingsSetMaxSeatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Set maximum seats'**
  String get settingsSetMaxSeatsTitle;

  /// No description provided for @settingsClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get settingsClose;

  /// No description provided for @settingsSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get settingsSave;

  /// No description provided for @settingsCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get settingsCancel;

  /// No description provided for @settingsInfo.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get settingsInfo;

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String settingsVersion(Object version);

  /// No description provided for @suppliersCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{0 suppliers} =1{1 supplier} other{{count} suppliers}}'**
  String suppliersCount(int count);

  /// No description provided for @suppliersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track what and where you buy'**
  String get suppliersSubtitle;

  /// No description provided for @suppliersAdd.
  ///
  /// In en, this message translates to:
  /// **'Add supplier'**
  String get suppliersAdd;

  /// No description provided for @supplierScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Supplier'**
  String get supplierScreenTitle;

  /// No description provided for @supplierDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete supplier'**
  String get supplierDeleteTitle;

  /// No description provided for @supplierDeletePrompt.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete supplier {name}?'**
  String supplierDeletePrompt(Object name);

  /// No description provided for @supplierEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit supplier'**
  String get supplierEditTitle;

  /// No description provided for @supplierEditPrompt.
  ///
  /// In en, this message translates to:
  /// **'Do you want to edit supplier {name}?'**
  String supplierEditPrompt(Object name);

  /// No description provided for @supplierFormNew.
  ///
  /// In en, this message translates to:
  /// **'New supplier'**
  String get supplierFormNew;

  /// No description provided for @supplierFormEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit supplier'**
  String get supplierFormEdit;

  /// No description provided for @supplierNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter a name'**
  String get supplierNameRequired;

  /// No description provided for @supplierNoneExpenses.
  ///
  /// In en, this message translates to:
  /// **'No expenses recorded'**
  String get supplierNoneExpenses;

  /// No description provided for @supplierAddExpense.
  ///
  /// In en, this message translates to:
  /// **'Add expense'**
  String get supplierAddExpense;

  /// No description provided for @reservationsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} reservations'**
  String reservationsCount(int count);

  /// No description provided for @reservationsRegistered.
  ///
  /// In en, this message translates to:
  /// **'Recorded reservations'**
  String get reservationsRegistered;

  /// No description provided for @reservationsRemaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining reservations ({count})'**
  String reservationsRemaining(int count);

  /// No description provided for @reservationsPast.
  ///
  /// In en, this message translates to:
  /// **'Past reservations ({count})'**
  String reservationsPast(int count);

  /// No description provided for @reservationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reservations'**
  String get reservationsTitle;

  /// No description provided for @reservationsAdd.
  ///
  /// In en, this message translates to:
  /// **'Add reservation'**
  String get reservationsAdd;

  /// No description provided for @reservationNone.
  ///
  /// In en, this message translates to:
  /// **'No reservations'**
  String get reservationNone;

  /// No description provided for @reservationScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Reservation'**
  String get reservationScreenTitle;

  /// No description provided for @reservationDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete reservation'**
  String get reservationDeleteTitle;

  /// No description provided for @reservationDeletePrompt.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete reservation for {name}?'**
  String reservationDeletePrompt(Object name);

  /// No description provided for @reservationReplacesThis.
  ///
  /// In en, this message translates to:
  /// **'This reservation replaces'**
  String get reservationReplacesThis;

  /// No description provided for @reservationPeople.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get reservationPeople;

  /// No description provided for @reservationDateTime.
  ///
  /// In en, this message translates to:
  /// **'Date and time'**
  String get reservationDateTime;

  /// No description provided for @reservationFormNew.
  ///
  /// In en, this message translates to:
  /// **'New reservation'**
  String get reservationFormNew;

  /// No description provided for @reservationFormEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit reservation'**
  String get reservationFormEdit;

  /// No description provided for @reservationNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter a name'**
  String get reservationNameRequired;

  /// No description provided for @reservationPeopleInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number'**
  String get reservationPeopleInvalid;

  /// No description provided for @reservationReplaceSummary.
  ///
  /// In en, this message translates to:
  /// **'Replaces reservation at {time} for {name}'**
  String reservationReplaceSummary(Object time, Object name);

  /// No description provided for @daySelectorToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get daySelectorToday;

  /// No description provided for @expensesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{0 expenses} =1{1 expense} other{{count} expenses}}'**
  String expensesCount(int count);

  /// No description provided for @expensesRegistered.
  ///
  /// In en, this message translates to:
  /// **'All recorded expenses'**
  String get expensesRegistered;

  /// No description provided for @expensesNone.
  ///
  /// In en, this message translates to:
  /// **'No expenses recorded'**
  String get expensesNone;

  /// No description provided for @expenseDialogNew.
  ///
  /// In en, this message translates to:
  /// **'New expense'**
  String get expenseDialogNew;

  /// No description provided for @expenseDialogEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit expense'**
  String get expenseDialogEdit;

  /// No description provided for @expenseFood.
  ///
  /// In en, this message translates to:
  /// **'Food item'**
  String get expenseFood;

  /// No description provided for @expenseRequired.
  ///
  /// In en, this message translates to:
  /// **'Required field'**
  String get expenseRequired;

  /// No description provided for @expenseDetailsOptional.
  ///
  /// In en, this message translates to:
  /// **'Details (optional)'**
  String get expenseDetailsOptional;

  /// No description provided for @expensePriceOptional.
  ///
  /// In en, this message translates to:
  /// **'Price (optional)'**
  String get expensePriceOptional;

  /// No description provided for @expensePriceInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid numeric value'**
  String get expensePriceInvalid;

  /// No description provided for @expensePrice.
  ///
  /// In en, this message translates to:
  /// **'Price: €{price}'**
  String expensePrice(Object price);

  /// No description provided for @expenseSupplier.
  ///
  /// In en, this message translates to:
  /// **'Supplier: {name}'**
  String expenseSupplier(Object name);

  /// No description provided for @expenseDateTime.
  ///
  /// In en, this message translates to:
  /// **'Date: {dateTime}'**
  String expenseDateTime(Object dateTime);

  /// No description provided for @commonName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get commonName;

  /// No description provided for @commonDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get commonDescription;

  /// No description provided for @commonPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get commonPhone;

  /// No description provided for @commonDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get commonDetails;

  /// No description provided for @commonDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get commonDate;

  /// No description provided for @commonTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get commonTime;

  /// No description provided for @commonAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get commonAdd;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @aboutLegalese.
  ///
  /// In en, this message translates to:
  /// **'© 2026 TableTable \n Built by Daniele with some AI models\nif something breaks, don\'t blame me :)\nplease leave a review\n'**
  String get aboutLegalese;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'it': return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
