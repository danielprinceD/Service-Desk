
import 'package:service_desk/controller/db_initializer.dart';

class Model {
  final int? modelId;
  final String modelName;

  Model({ this.modelId, required this.modelName});

  Map<String, dynamic> toMap() {
    return {
      'modelId': modelId,
      'modelName': modelName,
    };
  }

  bool addOrUpdateModel() {
    DBInitializer.instance.db.then((database) async {
      modelId == null
          ? await database.insert('ModelTable', toMap())
          : await database.update('ModelTable', toMap(),
              where: 'ModelId = ?', whereArgs: [modelId]);
      return true;
    });
    return false;
  }
}