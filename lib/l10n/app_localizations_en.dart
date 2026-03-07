// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'TableTable';

  @override
  String get settingsTooltip => 'Settings';

  @override
  String get navHome => 'Home';

  @override
  String get navReservations => 'Reservations';

  @override
  String get navSuppliers => 'Suppliers';

  @override
  String get navExpenses => 'Expenses';

  @override
  String get homeTodayData => 'Today\'s data';

  @override
  String get homeReservationsToday => 'Today\'s reservations';

  @override
  String get homeTotalPeople => 'Total people';

  @override
  String get homeRemainingSeats => 'Remaining seats';

  @override
  String get homeTotalSeats => 'Total seats';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSectionGeneral => 'GENERAL';

  @override
  String get settingsSectionApp => 'APP';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSubtitle => 'Choose app language';

  @override
  String get settingsLanguageItalian => 'Italian';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsPrimaryColor => 'Primary color';

  @override
  String get settingsPrimaryColorPickerTitle => 'Primary color';

  @override
  String get settingsPrimaryColorSubtitle => 'Choose the app color';

  @override
  String get settingsMaxSeats => 'Maximum seats';

  @override
  String get settingsMaxSeatsSubtitle => 'Set the people limit';

  @override
  String get settingsSetMaxSeatsTitle => 'Set maximum seats';

  @override
  String get settingsClose => 'Close';

  @override
  String get settingsSave => 'Save';

  @override
  String get settingsCancel => 'Cancel';

  @override
  String get settingsInfo => 'Information';

  @override
  String settingsVersion(Object version) {
    return 'Version $version';
  }

  @override
  String suppliersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count suppliers',
      one: '1 supplier',
      zero: '0 suppliers',
    );
    return '$_temp0';
  }

  @override
  String get suppliersSubtitle => 'Track what and where you buy';

  @override
  String get suppliersAdd => 'Add supplier';

  @override
  String get supplierScreenTitle => 'Supplier';

  @override
  String get supplierDeleteTitle => 'Delete supplier';

  @override
  String supplierDeletePrompt(Object name) {
    return 'Do you want to delete supplier $name?';
  }

  @override
  String get supplierEditTitle => 'Edit supplier';

  @override
  String supplierEditPrompt(Object name) {
    return 'Do you want to edit supplier $name?';
  }

  @override
  String get supplierFormNew => 'New supplier';

  @override
  String get supplierFormEdit => 'Edit supplier';

  @override
  String get supplierNameRequired => 'Enter a name';

  @override
  String get supplierNoneExpenses => 'No expenses recorded';

  @override
  String get supplierAddExpense => 'Add expense';

  @override
  String reservationsCount(int count) {
    return '$count reservations';
  }

  @override
  String get reservationsRegistered => 'Recorded reservations';

  @override
  String reservationsRemaining(int count) {
    return 'Remaining reservations ($count)';
  }

  @override
  String reservationsPast(int count) {
    return 'Past reservations ($count)';
  }

  @override
  String get reservationsTitle => 'Reservations';

  @override
  String get reservationsAdd => 'Add reservation';

  @override
  String get reservationNone => 'No reservations';

  @override
  String get reservationScreenTitle => 'Reservation';

  @override
  String get reservationDeleteTitle => 'Delete reservation';

  @override
  String reservationDeletePrompt(Object name) {
    return 'Do you want to delete reservation for $name?';
  }

  @override
  String get reservationReplacesThis => 'This reservation replaces';

  @override
  String get reservationPeople => 'People';

  @override
  String get reservationDateTime => 'Date and time';

  @override
  String get reservationFormNew => 'New reservation';

  @override
  String get reservationFormEdit => 'Edit reservation';

  @override
  String get reservationNameRequired => 'Enter a name';

  @override
  String get reservationPeopleInvalid => 'Enter a valid number';

  @override
  String reservationReplaceSummary(Object time, Object name) {
    return 'Replaces reservation at $time for $name';
  }

  @override
  String get daySelectorToday => 'Today';

  @override
  String expensesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count expenses',
      one: '1 expense',
      zero: '0 expenses',
    );
    return '$_temp0';
  }

  @override
  String get expensesRegistered => 'All recorded expenses';

  @override
  String get expensesNone => 'No expenses recorded';

  @override
  String get expenseDialogNew => 'New expense';

  @override
  String get expenseDialogEdit => 'Edit expense';

  @override
  String get expenseFood => 'Food item';

  @override
  String get expenseRequired => 'Required field';

  @override
  String get expenseDetailsOptional => 'Details (optional)';

  @override
  String get expensePriceOptional => 'Price (optional)';

  @override
  String get expensePriceInvalid => 'Enter a valid numeric value';

  @override
  String expensePrice(Object price) {
    return 'Price: €$price';
  }

  @override
  String expenseSupplier(Object name) {
    return 'Supplier: $name';
  }

  @override
  String expenseDateTime(Object dateTime) {
    return 'Date: $dateTime';
  }

  @override
  String get commonName => 'Name';

  @override
  String get commonDescription => 'Description';

  @override
  String get commonPhone => 'Phone';

  @override
  String get commonDetails => 'Details';

  @override
  String get commonDate => 'Date';

  @override
  String get commonTime => 'Time';

  @override
  String get commonAdd => 'Add';

  @override
  String get commonSave => 'Save';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get aboutLegalese => '© 2026 TableTable \n Built by Daniele with some AI models\nif something breaks, don\'t blame me :)\nplease leave a review\n';
}
