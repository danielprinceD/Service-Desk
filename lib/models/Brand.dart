import 'package:service_desk/controller/db_initializer.dart';

class Brand {
  final int? brandId;
  final String brandName;

  Brand({ this.brandId, required this.brandName});

  Map<String, dynamic> toMap() {
    return {
      'brandId': brandId,
      'brandName': brandName,
    };
  }

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      brandId: map['brandId'],
      brandName: map['brandName'],
    );
  }

  bool addOrUpdateBrand() {
    DBInitializer.instance.db.then((database) async {
      brandId == null
          ? await database.insert('BrandTable', toMap())
          : await database.update('BrandTable', toMap(),
              where: 'BrandId = ?', whereArgs: [brandId]);
      return true;
    });
    return false;
  }

}