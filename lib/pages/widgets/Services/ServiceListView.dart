import 'package:flutter/material.dart';
import 'package:service_desk/pages/widgets/Customers/CustomerViewPage.dart';
import 'package:service_desk/pages/widgets/Services/ServiceEditPage.dart';
import 'package:service_desk/utils/widgets/CustomFloatingActionButton.dart';
import '../../../models/Service.dart' as Service;

class ServiceListPage extends StatefulWidget {
  static const routeName = '/service/list';

  const ServiceListPage({super.key});

  @override
  State<ServiceListPage> createState() => _ServiceListPageState();
}

class _ServiceListPageState extends State<ServiceListPage> {
  List _services = [];

  Future<void> initList() async {
    List serviceList = await Service.Service.getAllServices();
    setState(() {
      _services = serviceList;
    });
  }

  void onClick(BuildContext context, int? index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ServiceEditPage(serviceId: _services[index!]['ServiceId']),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (_services.isEmpty)
            ? const Text('No services available.')
            : ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                padding: const EdgeInsets.all(5),
                itemCount: _services.length,
                itemBuilder: (context, index) {
                  final service = _services[index];
                  return ListTile(
                    onTap: () => {onClick(context, index)},
                    minVerticalPadding: 10,
                    shape: Border.all(width: 2),
                    title: Text(
                      '${index + 1}. Brand - ${service['BrandName'] ?? ''} Model - ${service['ModelName'] ?? ''}',
                    ),
                    subtitle: Row(
                      children: [
                        Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ' IMEI Number : ${service['IMEINumber']} ',
                                ),
                                Text(' Amount : ${service['TotalAmount']} '),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  ' Delivery Status : ${service['DeliveryStatus']} ',
                                ),
                                Text(' Payment Status : Not Paid'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ServiceEditPage.routeName);
        },
      ),
    );
  }
}
