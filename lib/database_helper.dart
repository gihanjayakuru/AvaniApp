import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('avani_data.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS service_form_data (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      location TEXT,
      serviceType TEXT,
      serviceDescription TEXT,
      createdDate TEXT
    )
  ''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS form_data(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      location TEXT,
      filterClean TEXT,
      blowerCheck TEXT,
      inspectCleanIduCoilFins TEXT,
      checkCleanDrainPlate TEXT,
      drainPumpCheck TEXT,
      checkPipingDuckInsulation TEXT,
      checkNoise TEXT,
      indoorHousingCondition TEXT,
      pcbStatus TEXT,
      acSlidinDoorOperation TEXT,
      thermostatSetting TEXT,
      drainLineClean TEXT,
      compressorNoise TEXT,
      fanNoise TEXT,
      outdoorHousingCondition TEXT,
      remark TEXT,
      date TEXT,
      technicianName TEXT
    )
  ''');
  }

  Future<int> insertFormData(Map<String, dynamic> formData) async {
    final db = await instance.database;
    return await db.insert('form_data', formData);
  }

  // Future<void> insertServiceFormData(MergedData formData) async {
  //   final db = await database;

  //   // Convert the formData to JSON using its toJson method
  //   final formDataJson = formData.toJson();

  //   // Insert the formDataJson into the 'mergedData' table
  //   await db.insert('mergedData', formDataJson,
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  // }
  // Future<void> insertServiceFormData(Map<String, dynamic> formData) async {
  //   final db = await database;

  //   // Convert the formData to a MergedData object
  //   final mergedData = MergedData(
  //     location: formData['location'],
  //     serviceType: formData['serviceType'],
  //     serviceDescription: formData['serviceDescription'],
  //   );

  //   // Insert the mergedData into the 'serviceFormData' table
  //   await db.insert('mergedData', mergedData.toJson(),
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  // }

  // Future<int> insertServiceFormData(
  //     Map<String, dynamic> serviceFormData) async {
  //   print(serviceFormData);

  //   final db = await instance.database;
  //   return await db.insert('service_form_data', serviceFormData);
  // }

  Future<int> insertServiceFormData(
      Map<String, dynamic> serviceFormData) async {
    final db = await instance.database;
    return await db.insert('service_form_data', serviceFormData);
  }

  Future<List<Map<String, dynamic>>> getFormDataList() async {
    final db = await instance.database;
    return await db.query('form_data');
  }

  Future<int> updateFormData(Map<String, dynamic> formData) async {
    final db = await instance.database;
    final id = formData['id'];
    return await db.update(
      'form_data',
      formData,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteFormData(int id) async {
    final db = await instance.database;
    return await db.delete(
      'form_data',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
