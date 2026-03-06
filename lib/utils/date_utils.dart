/// Formatta un [DateTime] nel formato "Gio 5 Mar · 20:30".
String formatDataOra(DateTime dt) {
  const giorni = ['Lun', 'Mar', 'Mer', 'Gio', 'Ven', 'Sab', 'Dom'];
  const mesi = [
    'Gen',
    'Feb',
    'Mar',
    'Apr',
    'Mag',
    'Giu',
    'Lug',
    'Ago',
    'Set',
    'Ott',
    'Nov',
    'Dic',
  ];
  final ora =
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  return '${giorni[dt.weekday - 1]} ${dt.day} ${mesi[dt.month - 1]} · $ora';
}

/// Formatta un [DateTime] nel formato "Gio 5 Mar".
String formatData(DateTime dt) {
  const giorni = ['Lun', 'Mar', 'Mer', 'Gio', 'Ven', 'Sab', 'Dom'];
  const mesi = [
    'Gen',
    'Feb',
    'Mar',
    'Apr',
    'Mag',
    'Giu',
    'Lug',
    'Ago',
    'Set',
    'Ott',
    'Nov',
    'Dic',
  ];
  return '${giorni[dt.weekday - 1]} ${dt.day} ${mesi[dt.month - 1]}';
}
