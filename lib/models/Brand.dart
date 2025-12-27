import 'package:service_desk/controller/db_initializer.dart';
import 'package:sqflite/sqflite.dart';

class Brand {
  int? brandId;
  String brandName;

  Brand({this.brandId, required this.brandName});

  Map<String, dynamic> toMap() {
    return {'brandId': brandId, 'brandName': brandName};
  }

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(brandId: map['BrandId'], brandName: map['BrandName']);
  }

  Future<int?> addOrUpdateBrand(Transaction txn) async {
    final int result = brandId == null
        ? await txn.insert('BrandTable', toMap())
        : await txn.update(
            'BrandTable',
            toMap(),
            where: 'BrandId = ?',
            whereArgs: [brandId],
          );

    return result;
  }

  static Future<List> getAllBrand() async {
    Database db = await DBInitializer.instance.db;
    List models = await db.query('BrandTable');
    return models ?? [];
  }

  static Future<void> deleteBrand(int brandId) async {
    Database db = await DBInitializer.instance.db;
    await db.delete('BrandTable', where: 'BrandId = ?', whereArgs: [brandId]);
  }
}
