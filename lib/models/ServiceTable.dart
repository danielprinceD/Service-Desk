import 'package:service_desk/controller/db_initializer.dart';

class Service {
  final int? serviceId;
  final int brandId;
  final int modelId;
  final String IMEINumber;
  final String customerID;
  final double amount;
  final String deliveryStatus;
  final String date;
  
  Service({
    this.serviceId,
    required this.brandId,
    required this.modelId,
    required this.IMEINumber,
    required this.customerID,
    this.amount = 0.0,
    required this.deliveryStatus,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': serviceId,
      'brandId': brandId,
      'modelId': modelId,
      'IMEINumber': IMEINumber,
      'customerID': customerID,
      'amount': amount,
      'deliveryStatus': deliveryStatus,
      'date': date,
    };
  }

  bool addOrUpdateService() {
    DBInitializer.instance.db.then((database) async {
      serviceId == null
          ? await database.insert('ServiceTable', toMap())
          : await database.update('ServiceTable', toMap(),
              where: 'ServiceId = ?', whereArgs: [serviceId]);
      return true;
    });
    return false;
  }

}