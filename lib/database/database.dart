import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/prenotazione.dart';

class PrenotazioniDatabase {
  static final PrenotazioniDatabase instance = PrenotazioniDatabase._init();

  static Database? _database;

  PrenotazioniDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('prenotazioni.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE prenotazioni (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        numeroPersone INTEGER NOT NULL,
        dataOra TEXT NOT NULL
      )
    ''');
  }

  // CRUD

  Future<int> createPrenotazione(Prenotazione p) async {
    final db = await instance.database;
    return await db.insert('prenotazioni', p.toMap());
  }

  Future<List<Prenotazione>> readAllPrenotazioni() async {
    final db = await instance.database;
    final result = await db.query('prenotazioni', orderBy: 'dataOra ASC');
    return result.map((map) => Prenotazione.fromMap(map)).toList();
  }

  Future<int> updatePrenotazione(Prenotazione p) async {
    final db = await instance.database;
    return db.update(
      'prenotazioni',
      p.toMap(),
      where: 'id = ?',
      whereArgs: [p.id],
    );
  }

  Future<int> deletePrenotazione(int id) async {
    final db = await instance.database;
    return await db.delete('prenotazioni', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
