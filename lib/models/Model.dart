
import 'package:service_desk/controller/db_initializer.dart';
import 'package:sqflite/sqflite.dart';

class Model {
  int? modelId;
  String modelName;

  Model({ this.modelId, required this.modelName});

  Map<String, dynamic> toMap() {
    return {
      'modelId': modelId,
      'modelName': modelName,
    };
  }

  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      modelId: map['ModelId'],
      modelName: map['ModelName'],
    );
  }

  int? addOrUpdateModel() {
    DBInitializer.instance.db.then((database) async {
      int newModelId = modelId == null
          ? await database.insert('ModelTable', toMap())
          : await database.update('ModelTable', toMap(),
              where: 'ModelId = ?', whereArgs: [modelId]);
      return newModelId;
    });
    return null;
  }

   static Future<List> getAllModel() async {
     Database db = await DBInitializer.instance.db;
      List models = await db.query('ModelTable');
      return models ?? [];
  }

}