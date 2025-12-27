import 'package:flutter/material.dart';
import 'package:service_desk/models/Customer.dart';
import 'package:service_desk/models/Service.dart';
import 'package:service_desk/pages/widgets/Services/ServiceEditPage.dart';
import 'package:service_desk/pages/widgets/Transactions/TransactionEditPage.dart';
import 'package:service_desk/pages/widgets/Transactions/TransactionListView.dart';
import 'package:service_desk/utils/widgets/CustomBottomSheet.dart';
import 'package:service_desk/utils/widgets/CustomSearchBar.dart';

class CustomerFields extends StatefulWidget {
  CustomerFields({
    super.key,
    required this.customer,
    required this.services,
    required this.context,
    required this.initCustomer,
  });

  final Customer customer;
  final List<Service> services;
  final BuildContext context;
  final Function() initCustomer;

  @override
  _CustomerFieldsState createState() => _CustomerFieldsState();
}

class _CustomerFieldsState extends State<CustomerFields> {
  Future<void> onPressAddService(BuildContext context, int customerID) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ServiceEditPage(serviceId: null, customerId: customerID),
      ),
    );
    return result;
  }

  List<Service> _searchServices = [];

  void searchService(String value) {
    setState(() {
      _searchServices = widget.services
          .where(
            (service) =>
                service.IMEINumber.toLowerCase().contains(value.toLowerCase()),
          )
          .toList();
    });
  }

  Future<void> showDeleteDialog(BuildContext context, int serviceId) async {
    return await showDialog(
      context: context,
      builder: (context) => CustomBottomSheet(
        title: 'Delete Service',
        alertMesssage: 'Are you sure you want to delete this service?',
        leftButtonText: 'Cancel',
        rightButtonText: 'Delete',
        leftButtonOnPressed: () {
          Navigator.pop(context);
        },
        rightButtonOnPressed: () async {
          int? result = await Service.deleteService(serviceId);
          if (result == null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Service delete failed')));
            initServicesbyRemove(serviceId);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Service deleted successfully')),
            );
          }
          Navigator.pop(context);
        },
      ),
    );
  }

  void initServices() {
    setState(() {
      _searchServices = widget.services;
    });
  }

  void initServicesbyRemove(int serviceId) {
    setState(() {
      _searchServices = _searchServices
          .where((service) => service.serviceId != serviceId)
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    initServices();
  }

  @override
  Widget build(BuildContext context) {
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
                  Text('${widget.customer.customerName}'),
                  Text('(+91) ${widget.customer.mobileNumber}'),
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
                        'Number of Services: ${widget.services.length}',
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
                          onPressed: () async {
                            await onPressAddService(
                              context,
                              widget.customer.customerId!,
                            );
                            widget.initCustomer();
                          },
                          icon: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                  CustomSearchBar(
                    onChanged: (value) => searchService(value),
                    hintText: 'Search Service with IMEI Number',
                  ),
                  ..._searchServices
                      .map(
                        (service) => ListTile(
                          title: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),

                            child: Column(
                              spacing: 13,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${service.brand.brandName} ${service.model.modelName}',
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        onPressed: () async {
                                          await showDeleteDialog(
                                            context,
                                            service.serviceId!,
                                          );
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          size: 20,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

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
