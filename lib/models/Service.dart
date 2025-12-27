import 'package:service_desk/controller/db_initializer.dart';
import 'package:service_desk/models/Brand.dart';
import 'package:service_desk/models/Customer.dart';
import 'package:service_desk/models/Model.dart';
import 'package:sqflite/sqflite.dart';

class Service {
  int? serviceId;
  Brand brand;
  Model model;
  String IMEINumber;
  Customer customer;
  double totalAmount;
  String deliveryStatus;
  String date;

  Service({
    this.serviceId,
    required this.brand,
    required this.model,
    required this.IMEINumber,
    required this.customer,
    this.totalAmount = 0.0,
    required this.deliveryStatus,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'ServiceId': serviceId,
      'BrandId': brand.brandId,
      'ModelId': model.modelId,
      'IMEINumber': IMEINumber,
      'CustomerId': customer.customerId,
      'TotalAmount': totalAmount,
      'DeliveryStatus': deliveryStatus,
      'Date': date,
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      serviceId: map['ServiceId'],
      brand: Brand(brandName: map['BrandName'], brandId: map['BrandId']),
      model: Model(modelName: map['ModelName'], modelId: map['ModelId']),
      IMEINumber: map['IMEINumber'],
      customer: Customer(
        customerId: map['CustomerId'],
        customerName: map['CustomerName'],
        mobileNumber: map['MobileNumber'],
      ),
      totalAmount: double.tryParse(map['TotalAmount'].toString()) ?? 0.0,
      deliveryStatus: map['DeliveryStatus'],
      date: map['Date'],
    );
  }

  Future<int?> addOrUpdateService() async {
    final db = await DBInitializer.instance.db;
    final result = await db.transaction((txn) async {
      try {
        if (model.modelId == null) {
          final newModelId = await Model(
            modelName: model.modelName,
          ).addOrUpdateModel(txn);

          if (newModelId == null) {
            throw Exception('Model insert failed');
          }

          model.modelId = newModelId;
        }

        // 2️⃣ Brand
        if (brand.brandId == null) {
          final newBrandId = await Brand(
            brandName: brand.brandName,
          ).addOrUpdateBrand(txn);

          if (newBrandId == null) {
            throw Exception('Brand insert failed');
          }

          brand.brandId = newBrandId;
        }
        // 3️⃣ Customer
        final newCustomerId = await Customer(
          customerName: customer.customerName,
          mobileNumber: customer.mobileNumber,
        ).addorUpdateCustomer(txn);
        if (newCustomerId == null) {
          throw Exception('Customer insert failed');
        }

        customer.customerId = newCustomerId;
        // 4️⃣ Service
        final result = serviceId == null
            ? await txn.insert('ServiceTable', toMap())
            : await txn.update(
                'ServiceTable',
                toMap(),
                where: 'ServiceId = ?',
                whereArgs: [serviceId],
              );

        return result;
      } catch (e) {
        rethrow;
      }
    });
    return result;
  }

  static Future<List<Map<String, dynamic>>> getAllServices() async {
    Database db = await DBInitializer.instance.db;
    List<Map<String, dynamic>> maps = await db.rawQuery('''
              SELECT S.*, C.CustomerName, C.MobileNumber, B.BrandName, M.ModelName
              FROM ServiceTable S
              JOIN CustomerTable C ON S.CustomerID = C.CustomerId
              JOIN BrandTable B ON S.BrandId = B.BrandId
              JOIN ModelTable M ON S.ModelId = M.ModelId
          ''');
    return maps ?? [];
  }

  static Future<Map<String, dynamic>> getServiceById(int? id) async {
    Database db = await DBInitializer.instance.db;
    // with customerID join and brand and model
    List<Map<String, dynamic>> maps = await db.rawQuery(
      '''
        SELECT S.*, C.CustomerName, B.BrandName, M.ModelName , C.MobileNumber
        FROM ServiceTable S
        JOIN CustomerTable C ON S.CustomerID = C.CustomerId
        JOIN BrandTable B ON S.BrandId = B.BrandId
        JOIN ModelTable M ON S.ModelId = M.ModelId
        WHERE S.ServiceId = ?
      ''',
      [id],
    );
    return maps.first;
  }
}
