import 'package:service_desk/controller/db_initializer.dart';
import 'package:sqflite/sqflite.dart';

class Brand {
  int? brandId;
  String brandName;

  Brand({ this.brandId, required this.brandName});

  Map<String, dynamic> toMap() {
    return {
      'brandId': brandId,
      'brandName': brandName,
    };
  }

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      brandId: map['BrandId'],
      brandName: map['BrandName'],
    );
  }

  int? addOrUpdateBrand() {
    DBInitializer.instance.db.then((database) async {
      int? result = brandId == null
          ? await database.insert('BrandTable', toMap())
          : await database.update('BrandTable', toMap(),
              where: 'BrandId = ?', whereArgs: [brandId]);
      return result;
    });
    return null;
  }

  static Future<List> getAllBrand() async {
      Database db = await DBInitializer.instance.db; 
      List models = await db.query('BrandTable');
      return models ?? [];
  }

}