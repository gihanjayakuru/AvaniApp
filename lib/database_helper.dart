import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null && _database!.isOpen) return _database!;
    _database = await _initDB('databDD.db');
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
      createdDate TEXT,
      location TEXT,
      beforeRoomTemperature TEXT,
      beforeSetPointTemperature TEXT,
      beforeSupplyGrillTemperature TEXT,
      beforeReturnGrillTemperature TEXT,
      beforeGasPressureLowSide TEXT,
      beforeGasPressureHighSide TEXT,
      beforeAmp TEXT,
      afterRoomTemperature TEXT,
      afterSetPointTemperature TEXT,
      afterSupplyGrillTemperature TEXT,
      afterReturnGrillTemperature TEXT,
      afterGasPressureLowSide TEXT,
      afterGasPressureHighSide TEXT,
      afterAmp TEXT,
      filterClean TEXT,
      blowerCheck TEXT,
      indoorInspectCleanIduCoilFins TEXT,
      checkCleanDrainPlate TEXT,
      drainPumpCheck TEXT,
      checkPipingDuckInsulation TEXT,
      checkNoise TEXT,
      indoorHousingCondition TEXT,
      indoorPcbStatus TEXT,
      compressorNoise TEXT,
      fanNoise TEXT,
      outdoorInspectCleanIduCoilFins TEXT,
      outdoorPcbStatus TEXT,
      outdoorHousingCondition TEXT,
      acSlidinDoorOperation TEXT,
      thermostatSetting TEXT,
      drainLineClean TEXT,
      remark TEXT,
      date TEXT,
      technicianName TEXT,
      image TEXT
    )
  ''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS form_data(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      createdDate TEXT,
      location TEXT,
      indoorModel TEXT,
      indoorModelNum TEXT,
      indoorSerialNum TEXT,
      indoorCapacity TEXT,
      outdoorModel TEXT,
      outdoorModelNum TEXT,
      outdoorSerialNum TEXT,
      outdoorCapacity TEXT
    )
  ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS images (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      form_id INTEGER,
      indoor_image_name TEXT,
      indoor_image_path TEXT,
      outdoor_image_name TEXT,
      outdoor_image_path TEXT
    )
  ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS service_images (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      form_id TEXT,
      image_name TEXT,
      image_path TEXT
    )
  ''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS saved_pdfs (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      pdf_path TEXT
    )
  ''');
  }

  Future<List<Map<String, dynamic>>> getServiceFormDataList() async {
    final db = await instance.database;
    return await db.query('service_form_data');
  }

  // Future<int> insertFormData(Map<String, dynamic> formData) async {
  //   final db = await instance.database;
  //   return await db.insert('form_data', formData);
  // }

  Future<int> insertServiceFormData(
      Map<String, dynamic> serviceFormData) async {
    final db = await instance.database;
    return await db.insert('service_form_data', serviceFormData);
  }

  Future<int> deleteServiceFormData(int id) async {
    final db = await instance.database;
    return await db.delete(
      'service_form_data',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getFormDataList() async {
    final db = await database;
    return await db.query('form_data');
  }

  Future<int> insertFormData(Map<String, dynamic> formData) async {
    final db = await instance.database;
    return await db.insert('form_data', formData);
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

  Future<bool> saveImages(
      int formId, File? indoorImage, File? outdoorImage) async {
    final db = await instance.database;

    print('wccccco outdoor image :${outdoorImage}');
    print('wooccccoccooo indoor image :${indoorImage}');

    // Save indoor image
    if (indoorImage != null && outdoorImage != null) {
      final indoorImagePath = indoorImage.path;
      // final indoorBytes = await indoorImage.readAsBytes();
      final indoorImageName = path.basename(indoorImagePath);

      final outdoorImagePath = outdoorImage.path;
      // final outdoorBytes = await outdoorImage.readAsBytes();
      final outdoorImageName = path.basename(outdoorImagePath);

      final imageMap = {
        'form_id': formId,
        'indoor_image_name': indoorImageName,
        // 'indoor_image_data': indoorBytes,
        'indoor_image_path': indoorImagePath,
        'outdoor_image_name': outdoorImageName,
        // 'outdoor_image_data': outdoorBytes,
        'outdoor_image_path': outdoorImagePath,
      };

      final indoorInsertedId = await db.insert('images', imageMap);
      if (indoorInsertedId == -1) {
        return false; // Indoor image insertion failed
      }
    }

    return true; // Images saved successfully
  }

  Future<void> printImageData() async {
    final db = await instance.database;
    final result = await db.query('images');
    if (result.isNotEmpty) {
      for (final row in result) {
        final id = row['id'];
        final formId = row['form_id'];
        final imageName = row['image_name'];
        // final imageData = row['image_data'];
        final imagePath = row['imagePath'];
        print(
            'ID: $id, Form ID: $formId, Image Name: $imageName,  Image Path: $imagePath');
      }
    } else {
      print('No data in the "images" table.');
    }
  }

  Future<List<String?>> getImagePathsForForm(int formId) async {
    final db = await instance.database;

    final List<Map<String, dynamic>> result = await db.query(
      'images',
      columns: ['indoor_image_path', 'outdoor_image_path'],
      where: 'form_id = ?',
      whereArgs: [formId],
      limit: 1,
    );

    if (result.isNotEmpty) {
      final Map<String, dynamic> row = result.first;
      final String? indoorImagePath = row['indoor_image_path'];
      final String? outdoorImagePath = row['outdoor_image_path'];

      print('indoor path: ${indoorImagePath}');
      print('outdoor path: ${outdoorImagePath}');

      return [indoorImagePath, outdoorImagePath];
    }

    return [];
  }

  Future<bool> saveServiceImages(List<File> images, int formId) async {
    final db = await instance.database;
    for (final image in images) {
      final imagePath = image.path;
      // final imageBytes = await image.readAsBytes();
      final imageName = path.basename(imagePath);
      print(imagePath);
      final serviceImagesMap = {
        'form_id': formId,
        'image_name': imageName,
        // 'image_data': imageBytes,
        'image_path': imagePath,
      };

      await db.insert('service_images', serviceImagesMap);
    }
    return true;
  }

  Future<List<Map<String, dynamic>>> getServiceImagesForForm(int formId) async {
    final db = await instance.database;
    final result = await db.query(
      'service_images',
      where: 'form_id = ?',
      whereArgs: [formId],
    );
    return result;
  }

  Future<List<String>> getSavedPDFs() async {
    final db = await instance.database;
    final result = await db.query('saved_pdfs');

    // print('result in Databas Manager get savedPdf files paths ${result}');
    return result.map((row) => row['pdf_path'] as String).toList();
  }

  Future<void> deletePDF(String pdfPath) async {
    final db = await instance.database;
    await db.delete('saved_pdfs', where: 'pdf_path = ?', whereArgs: [pdfPath]);
  }

  Future<int> savePDFPath(String pdfPath) async {
    print('calling save PDF classss....${pdfPath}');
    final db = await instance.database;
    return await db.insert('saved_pdfs', {'pdf_path': pdfPath});
  }

  // Future<void> openPDF(String pdfPath) {
  //   return OpenFile.open(pdfPath);
  // }

  Future<void> closeDatabase() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
      _database = null;
    }
  }
}
