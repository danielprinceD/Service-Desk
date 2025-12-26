import 'package:flutter/material.dart';
import 'package:service_desk/models/Customer.dart';
import 'package:service_desk/models/Service.dart';
import 'package:service_desk/pages/widgets/Customers/CustomerViewPage.dart';
import 'package:service_desk/pages/widgets/Transactions/TransactionEditPage.dart';
import 'package:service_desk/pages/widgets/Transactions/TransactionListView.dart';

class CustomerFields {
  static Widget getCustomerFields(
    Customer customer,
    List<Service> services,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Customer Name: ${customer.customerName}'),
              Text('Mobile Number: ${customer.mobileNumber}'),
              Text(
                'Services: ${services.length}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Column(
                spacing: 10,
                children: services
                    .map(
                      (service) => ListTile(
                        title: Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Column(
                            spacing: 13,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Brand: ${service.brand.brandName}'),
                              Text('Model: ${service.model.modelName}'),
                              Text('IMEI Number: ${service.IMEINumber}'),
                              Text('Total Amount: ${service.totalAmount}'),
                              Text(
                                'Delivery Status: ${service.deliveryStatus}',
                              ),
                              Text('Date: ${service.date}'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 15,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TransactionEditPage(
                                                serviceId: service.serviceId,
                                              ),
                                        ),
                                      );
                                    },
                                    child: Icon(Icons.add),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TransactionListView(
                                                serviceId: service.serviceId,
                                              ),
                                        ),
                                      );
                                    },
                                    child: Icon(Icons.view_list),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
