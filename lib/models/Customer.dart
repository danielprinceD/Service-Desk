import 'package:service_desk/controller/db_initializer.dart';
import 'package:sqflite/sqflite.dart';

class Customer {
  int? customerId;
  String? customerName;
  String? mobileNumber;

  Customer({
    this.customerId,
    required this.customerName,
    required this.mobileNumber,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'CustomerId': customerId,
      'CustomerName': customerName,
      'MobileNumber': mobileNumber,
    };
    return map;
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      customerId: map['CustomerId'],
      customerName: map['CustomerName'],
      mobileNumber: map['MobileNumber'],
    );
  }

  Future<int?> addorUpdateCustomer(Transaction txn) async {
    int newCustomerID = customerId == null
        ? await txn.insert('CustomerTable', toMap())
        : await txn.update(
            'CustomerTable',
            toMap(),
            where: 'CustomerId = ?',
            whereArgs: [customerId],
          );
    return newCustomerID;
  }

  static Future<List> getAllCustomer() async {
    Database db = await DBInitializer.instance.db;
    List models = await db.rawQuery('SELECT * FROM CustomerTable');
    return models ?? [];
  }

  static Future<Map<String, dynamic>> getCustomerById(int? id) async {
    Database db = await DBInitializer.instance.db;
    List<Map<String, dynamic>> maps = await db.query(
      'CustomerTable',
      where: 'CustomerId = ?',
      whereArgs: [id],
    );
    return maps.first;
  }

  static Future<List<Map<String, dynamic>>> getCustomerWithServicesById(
    int? id,
  ) async {
    Database db = await DBInitializer.instance.db;
    List<Map<String, dynamic>> maps = await db.rawQuery(
      '''SELECT S.ServiceId, S.IMEINumber, S.TotalAmount, S.DeliveryStatus, S.Date, C.CustomerId , C.CustomerName, C.MobileNumber , B.BrandName, M.ModelName
      FROM ServiceTable S
      JOIN CustomerTable C ON S.CustomerId = C.CustomerId 
      JOIN BrandTable B ON S.BrandId = B.BrandId
      JOIN ModelTable M ON S.ModelId = M.ModelId
      WHERE C.CustomerId = ?''',
      [id],
    );
    return maps;
  }
}
