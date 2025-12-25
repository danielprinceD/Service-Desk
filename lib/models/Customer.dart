

import 'package:service_desk/controller/db_initializer.dart';

class Customer{
  int? customerId;
  String? customerName;
  String? mobilNumber;

  Customer({this.customerId, required this.customerName, required this.mobilNumber});

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'CustomerId': customerId,
      'CustomerName': customerName,
      'MobilNumber': mobilNumber,
    };
    return map;
  }

  factory Customer.fromMap(Map<String, dynamic> map){
    return Customer(
      customerId: map['CustomerId'],
      customerName: map['CustomerName'],
      mobilNumber: map['MobilNumber'],
    );
  }

  int? addorUpdateCustomer() {
    DBInitializer.instance.db.then((database) async {
      int newCustomerID = customerId == null ? 
        await database.insert('CustomerTable', toMap()) : 
        await database.update('CustomerTable', toMap(), 
          where: 'CustomerId = ?', whereArgs: [customerId]);
      return newCustomerID;
    });
    return null;
  }

  static List getAllModel(){
     DBInitializer.instance.db.then((database) async {
      List models = await database.query('CustomerTable');
        return models.isNotEmpty ? models : [];
     });
     return [];
  }

}