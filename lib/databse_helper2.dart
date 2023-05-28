import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'avani_data.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
      // Specify the onUpgrade callback if needed
      // onUpgrade: _upgradeDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    // Database creation logic goes here
    // Create the necessary tables and schema
    // Example:
    await db.execute('''
      CREATE TABLE IF NOT EXISTS service_form_data (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        location TEXT,
        serviceType TEXT,
        serviceDescription TEXT,
        createdDate TEXT
      )
    ''');
  }

  // Future<void> _upgradeDatabase(Database db, int oldVersion, int newVersion) async {
  //   Upgrade logic goes here if needed
  // }

  Future<void> insertServiceFormData(Map<String, dynamic> formData) async {
    final Database db = await instance.database;
    await db.insert('service_form_data', formData);
  }
}
