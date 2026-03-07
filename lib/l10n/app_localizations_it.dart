// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'TableTable';

  @override
  String get settingsTooltip => 'Impostazioni';

  @override
  String get navHome => 'Home';

  @override
  String get navReservations => 'Prenotazioni';

  @override
  String get navSuppliers => 'Fornitori';

  @override
  String get navExpenses => 'Spese';

  @override
  String get homeTodayData => 'Dati di oggi';

  @override
  String get homeReservationsToday => 'Prenotazioni oggi';

  @override
  String get homeTotalPeople => 'Persone totali';

  @override
  String get homeRemainingSeats => 'Posti rimanenti';

  @override
  String get homeTotalSeats => 'Posti totali';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get settingsSectionGeneral => 'GENERALI';

  @override
  String get settingsSectionApp => 'APP';

  @override
  String get settingsLanguage => 'Lingua';

  @override
  String get settingsLanguageSubtitle => 'Scegli la lingua dell\'app';

  @override
  String get settingsLanguageItalian => 'Italiano';

  @override
  String get settingsLanguageEnglish => 'Inglese';

  @override
  String get settingsPrimaryColor => 'Colore primario';

  @override
  String get settingsPrimaryColorPickerTitle => 'Colore primario';

  @override
  String get settingsPrimaryColorSubtitle => 'Scegli il colore dell\'app';

  @override
  String get settingsMaxSeats => 'Coperti massimi';

  @override
  String get settingsMaxSeatsSubtitle => 'Imposta il limite di persone';

  @override
  String get settingsSetMaxSeatsTitle => 'Imposta coperti massimi';

  @override
  String get settingsClose => 'Chiudi';

  @override
  String get settingsSave => 'Salva';

  @override
  String get settingsCancel => 'Annulla';

  @override
  String get settingsInfo => 'Informazioni';

  @override
  String settingsVersion(Object version) {
    return 'Versione $version';
  }

  @override
  String suppliersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fornitori',
      one: '1 fornitore',
      zero: '0 fornitori',
    );
    return '$_temp0';
  }

  @override
  String get suppliersSubtitle => 'Segna cosa e dove compri qui';

  @override
  String get suppliersAdd => 'Aggiungi fornitore';

  @override
  String get supplierScreenTitle => 'Fornitore';

  @override
  String get supplierDeleteTitle => 'Elimina fornitore';

  @override
  String supplierDeletePrompt(Object name) {
    return 'Vuoi eliminare il fornitore $name?';
  }

  @override
  String get supplierEditTitle => 'Modifica fornitore';

  @override
  String supplierEditPrompt(Object name) {
    return 'Vuoi modificare il fornitore $name?';
  }

  @override
  String get supplierFormNew => 'Nuovo fornitore';

  @override
  String get supplierFormEdit => 'Modifica fornitore';

  @override
  String get supplierNameRequired => 'Inserisci un nome';

  @override
  String get supplierNoneExpenses => 'Nessuna spesa registrata';

  @override
  String get supplierAddExpense => 'Aggiungi spesa';

  @override
  String reservationsCount(int count) {
    return '$count prenotazioni';
  }

  @override
  String get reservationsRegistered => 'Prenotazioni registrate';

  @override
  String reservationsRemaining(int count) {
    return 'Prenotazioni rimanenti ($count)';
  }

  @override
  String reservationsPast(int count) {
    return 'Prenotazioni passate ($count)';
  }

  @override
  String get reservationsTitle => 'Prenotazioni';

  @override
  String get reservationsAdd => 'Aggiungi prenotazione';

  @override
  String get reservationNone => 'Nessuna prenotazione';

  @override
  String get reservationScreenTitle => 'Prenotazione';

  @override
  String get reservationDeleteTitle => 'Elimina prenotazione';

  @override
  String reservationDeletePrompt(Object name) {
    return 'Vuoi eliminare la prenotazione di $name?';
  }

  @override
  String get reservationReplacesThis => 'Questa prenotazione rimpiazza';

  @override
  String get reservationPeople => 'Persone';

  @override
  String get reservationDateTime => 'Data e ora';

  @override
  String get reservationFormNew => 'Nuova prenotazione';

  @override
  String get reservationFormEdit => 'Modifica prenotazione';

  @override
  String get reservationNameRequired => 'Inserisci un nome';

  @override
  String get reservationPeopleInvalid => 'Inserisci un numero valido';

  @override
  String reservationReplaceSummary(Object time, Object name) {
    return 'Rimpiazza prenotazione $time di $name';
  }

  @override
  String get daySelectorToday => 'Oggi';

  @override
  String expensesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count spese',
      one: '1 spesa',
      zero: '0 spese',
    );
    return '$_temp0';
  }

  @override
  String get expensesRegistered => 'Tutte le spese registrate';

  @override
  String get expensesNone => 'Nessuna spesa registrata';

  @override
  String get expenseDialogNew => 'Nuova spesa';

  @override
  String get expenseDialogEdit => 'Modifica spesa';

  @override
  String get expenseFood => 'Alimento';

  @override
  String get expenseRequired => 'Campo obbligatorio';

  @override
  String get expenseDetailsOptional => 'Dettagli (opzionale)';

  @override
  String get expensePriceOptional => 'Prezzo (opzionale)';

  @override
  String get expensePriceInvalid => 'Inserisci un valore numerico valido';

  @override
  String expensePrice(Object price) {
    return 'Prezzo: €$price';
  }

  @override
  String expenseSupplier(Object name) {
    return 'Fornitore: $name';
  }

  @override
  String expenseDateTime(Object dateTime) {
    return 'Data: $dateTime';
  }

  @override
  String get commonName => 'Nome';

  @override
  String get commonDescription => 'Descrizione';

  @override
  String get commonPhone => 'Telefono';

  @override
  String get commonDetails => 'Dettagli';

  @override
  String get commonDate => 'Data';

  @override
  String get commonTime => 'Orario';

  @override
  String get commonAdd => 'Aggiungi';

  @override
  String get commonSave => 'Salva';

  @override
  String get commonEdit => 'Modifica';

  @override
  String get commonDelete => 'Elimina';

  @override
  String get commonCancel => 'Annulla';

  @override
  String get aboutLegalese => '© 2026 TableTable \n Sviluppata da Daniele e alcuni modelli di intelligenza artificiale\nse funziona male non è colpa mia :)\nrecensitemi\n';
}
