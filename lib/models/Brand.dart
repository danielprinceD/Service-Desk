import 'package:service_desk/controller/db_initializer.dart';

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

  static List getAllBrand(){
     DBInitializer.instance.db.then((database) async {
      List models = await database.query('BrandTable');
        return models.isNotEmpty ? models : [];
     });
     return [];
  }

}