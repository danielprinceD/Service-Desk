
import 'package:service_desk/controller/db_initializer.dart';

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
      modelId: map['modelId'],
      modelName: map['modelName'],
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

   static List getAllModel(){
     DBInitializer.instance.db.then((database) async {
      List models = await database.query('ModelTable');
        return models.isNotEmpty ? models : [];
     });
     return [];
  }

}