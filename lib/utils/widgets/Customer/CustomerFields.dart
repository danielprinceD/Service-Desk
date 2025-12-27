import 'package:flutter/material.dart';
import 'package:service_desk/models/Customer.dart';
import 'package:service_desk/models/Service.dart';
import 'package:service_desk/pages/widgets/Services/ServiceEditPage.dart';
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                spacing: 10,
                direction: Axis.vertical,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(Icons.person, size: 70),
                  Text('${customer.customerName}'),
                  Text('(+91) ${customer.mobileNumber}'),
                ],
              ),
              Column(
                spacing: 10,
                children: [
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 10,
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        'Number of Services: ${services.length}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ServiceEditPage(
                                  serviceId: null,
                                  customerId: customer.customerId,
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                  ...services
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
