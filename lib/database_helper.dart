import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null && _database!.isOpen) return _database!;
    _database = await _initDB('databasBa.db');
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
      image_name TEXT,
      imagePath TEXT,
      image_data BLOB
      
    )
  ''');
  }

  Future<List<Map<String, dynamic>>> getServiceFormDataList() async {
    final db = await instance.database;
    return await db.query('service_form_data');
  }

  Future<void> insertServiceFormData(
      Map<String, dynamic> serviceFormData) async {
    final Database db = await instance.database;
    await db.insert('service_form_data', serviceFormData);
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

  Future<bool> saveImage(int formId, File _image) async {
    final db = await instance.database;
    final imagePath = _image.path;
    final bytes = await _image.readAsBytes();
    final imageName = path.basename(imagePath);
    final imageMap = {
      'form_id': formId,
      'image_name': imageName,
      'image_data': bytes,
      'imagePath': imagePath,
    };
    print('image save with id:${formId}');
    print('image save imageName:${imageName}');
    print('image save imagePath:${imagePath}');

    final insertedId = await db.insert('images', imageMap);
    return insertedId != -1;
  }

  // Future<void> saveImage(int formId, File imageFile) async {
  //   // Open the database
  //   final db = await instance.database;

  //   // Get the path to the image file
  //   final imagePath = imageFile.path;

  //   // Convert the image file to bytes
  //   final bytes = await imageFile.readAsBytes();

  //   // Define the image file name
  //   final imageName = path.basename(imagePath);

  //   // Create a map of the image data
  //   final imageMap = {
  //     'form_id': formId,
  //     'image_name': imageName,
  //     'image_data': bytes,
  //   };

  //   // Insert the image data into the database
  //   await db.insert('images', imageMap);
  // }
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

  Future<String?> getImagePathForForm(int formId) async {
    print('getImagePathForForm callingggg! : $formId');
    printImageData();
    final db = await instance.database;

    final query = '''
    SELECT imagePath FROM images WHERE form_id = ? LIMIT 1
  ''';
    final result = await db.rawQuery(query, [formId]);

    print('This is result:${result}');

    if (result.isEmpty) {
      print('No data Empty !');
    }

    if (result.isNotEmpty) {
      final imageName = result.first['image_name'] as String?;
      print('Image name ::: --${imageName}');

      // if (imageName != null) {
      // final documentsDirectory = await getApplicationDocumentsDirectory();
      // final imagePath = path.join(documentsDirectory.path, imageName);
      final imagePath = result.first['imagePath'] as String;
      // final imageFile = File(imagePath);

      print('Image path ::: --${imagePath}');

      return imagePath;
      // if (await imageFile.exists()) {
      //   print(
      //       'Image path File Founded...: $imagePath'); // Print the image path
      // } else {
      //   print('Image file not found,by retrived path...');
      // }
      // }
    }

    return null;
  }
  // Future<String?> getImagePathForForm(int formId) async {
  //   print('getImagePathForForm callingggg! : ${formId}');
  //   final db = await instance.database;
  //   final result = await db.query(
  //     'images',
  //     columns: ['image_name'],
  //     where: 'form_id = ?',
  //     whereArgs: [formId],
  //     limit: 1,
  //   );
  //   if (result.isEmpty) {
  //     print('No data Empty !');
  //   }
  //   if (result.isNotEmpty) {
  //     final imageName = result.first['image_name'] as String?;
  //     if (imageName != null) {
  //       final documentsDirectory = await getApplicationDocumentsDirectory();
  //       final imagePath = path.join(documentsDirectory.path, imageName);
  //       final imageFile = File(imagePath);
  //       if (await imageFile.exists()) {
  //         print('Image path: $imagePath'); // Print the image path
  //         return imagePath;
  //       }
  //     }
  //   }
  //   return null;
  // }

  // Future<String?> getImagePathForForm(int formId) async {
  //   final db = await instance.database;
  //   final result = await db.query(
  //     'images',
  //     columns: ['image_name'],
  //     where: 'form_id = ?',
  //     whereArgs: [formId],
  //     limit: 1,
  //   );
  //   if (result.isNotEmpty) {
  //     final imageName = result.first['image_name'] as String?;
  //     if (imageName != null) {
  //       final documentsPath = await getApplicationDocumentsDirectory();
  //       return path.join(documentsPath.path, imageName);
  //     }
  //   }
  //   return null;
  // }

  Future<void> closeDatabase() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
      _database = null;
    }
  }
}
