

import 'package:service_desk/controller/db_initializer.dart';
import 'package:sqflite/sqflite.dart';

class Customer{
  int? customerId;
  String? customerName;
  String? mobileNumber;

  Customer({this.customerId, required this.customerName, required this.mobileNumber});

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'CustomerId': customerId,
      'CustomerName': customerName,
      'MobileNumber': mobileNumber,
    };
    return map;
  }

  factory Customer.fromMap(Map<String, dynamic> map){
    return Customer(
      customerId: map['CustomerId'],
      customerName: map['CustomerName'],
      mobileNumber: map['MobileNumber'],
    );
  }

  Future<int?> addorUpdateCustomer(Transaction txn) async {
    int newCustomerID = customerId == null ? 
        await txn.insert('CustomerTable', toMap()) : 
        await txn.update('CustomerTable', toMap(), 
          where: 'CustomerId = ?', whereArgs: [customerId]);
    return newCustomerID;
  }

  static Future<List> getAllCustomer() async {
    Database db = await DBInitializer.instance.db;
    List models = await db.query('CustomerTable');
    return models ?? [];
  }

}