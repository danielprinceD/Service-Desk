import 'package:service_desk/controller/db_initializer.dart';
import 'package:service_desk/models/Brand.dart';
import 'package:service_desk/models/Customer.dart';
import 'package:service_desk/models/Model.dart';

class Service {
  int? serviceId;
  Brand brand;
  Model model;
  String IMEINumber;
  Customer customer;
  double amount;
  String deliveryStatus;
  String date;
  
  Service({
    this.serviceId,
    required this.brand,
    required this.model,
    required this.IMEINumber,
    required this.customer,
    this.amount = 0.0,
    required this.deliveryStatus,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': serviceId,
      'brandId': brand.brandId,
      'modelId': model.modelId,
      'IMEINumber': IMEINumber,
      'customerId': customer.customerId ,
      'amount': amount,
      'deliveryStatus': deliveryStatus,
      'date': date,
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      serviceId: map['id'],
      brand: Brand(brandName: map['brandName'] , brandId: map['brandId']),
      model: Model(modelName: map['modelName'] , modelId: map['modelId']),
      IMEINumber: map['IMEINumber'],
      customer: Customer( customerId: map['customerID'] , customerName:  map['customerName'] , mobilNumber:  map['mobileNumber']),
      amount: map['amount'] ,
      deliveryStatus: map['deliveryStatus'],
      date: map['date'],
    );
  }

  int? addOrUpdateService() {
    DBInitializer.instance.db.then((database) async {

      if(model.modelId == null){
        int? newModelId = Model(modelName: model.modelName).addOrUpdateModel();
        model.modelId = newModelId;
        if(newModelId == null){
          return null;
        }
      }
      if(brand.brandId == null){
        int? newBrandId = Brand(brandName: brand.brandName).addOrUpdateBrand();
        brand.brandId = newBrandId;
        if(newBrandId == null){
          return null;
        }
      }

      if(customer.customerId == null){
        int? newCustomerId = Customer(customerName: customer.customerName, mobilNumber: customer.mobilNumber).addorUpdateCustomer();
        customer.customerId = newCustomerId;
        if(newCustomerId == null){
          return null;
        }
      }

      int? result = serviceId == null
          ? await database.insert('ServiceTable', toMap())
          : await database.update('ServiceTable', toMap(),
              where: 'ServiceId = ?', whereArgs: [serviceId]);
      return result;
    });
    return null;
  }

   static List<Map<String, dynamic>> getAllServices() {
    DBInitializer.instance.db.then((database) async {
      List<Map<String, dynamic>> maps =
          await database.query('ServiceTable');
      return maps;
    });
    return [];
  }

  static Map<String , dynamic> getServiceById(int? id) {
    DBInitializer.instance.db.then((database) async {
      // with customerID join and brand and model
      List<Map<String, dynamic>> maps = await database.rawQuery('''
        SELECT S.*, C.CustomerName, B.brandName, M.modelName 
        FROM ServiceTable S
        JOIN CustomerTable C ON S.customerID = C.CustomerId
        JOIN BrandTable B ON S.brandId = B.brandId
        JOIN ModelTable M ON S.modelId = M.modelId
        WHERE S.ServiceId = ?
      ''', [id]);
      if (maps.isNotEmpty) {
        return maps.first;
      }
    });
    return {};
  }

}