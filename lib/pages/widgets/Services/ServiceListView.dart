import 'package:flutter/material.dart';
import 'package:service_desk/pages/widgets/Services/ServiceEditPage.dart';
import 'package:service_desk/utils/widgets/CustomFloatingActionButton.dart';
import '../../../models/Service.dart' as Service;
import 'package:service_desk/utils/widgets/CustomSearchBar.dart';

class ServiceListPage extends StatefulWidget {
  static const routeName = '/service/list';

  const ServiceListPage({super.key});

  @override
  State<ServiceListPage> createState() => _ServiceListPageState();
}

class _ServiceListPageState extends State<ServiceListPage> {
  List _services = [];
  List _searchServices = [];

  Future<void> initList() async {
    List serviceList = await Service.Service.getAllServices();
    setState(() {
      _services = serviceList;
      _searchServices = _services;
    });
  }

  Future<void> onClick(BuildContext context, int? index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ServiceEditPage(serviceId: _searchServices[index!]['ServiceId']),
      ),
    );
    return result;
  }

  void searchService(String value) {
    setState(() {
      _searchServices = _services
          .where(
            (service) => service['IMEINumber'].toLowerCase().contains(
              value.toLowerCase(),
            ),
          )
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    initList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          children: [
            CustomSearchBar(
              onChanged: (value) => searchService(value),
              hintText: "Enter IMEI Number",
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: _searchServices.length,
                itemBuilder: (context, index) {
                  final service = _searchServices[index];
                  return ListTile(
                    key: ValueKey(index),
                    onTap: () async {
                      await onClick(context, index);
                    },
                    contentPadding: EdgeInsets.all(10),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.phone_android),
                    ),
                    title: Text(
                      "IMEI: ${service['IMEINumber']}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Wrap(
                      direction: Axis.vertical,
                      children: [
                        Text(
                          "${service['CustomerName']} (+91 ${service['MobileNumber']})",
                        ),
                        Wrap(
                          children: [
                            Text(
                              "${service['BrandName']} ${service['ModelName']}",
                            ),
                          ],
                        ),
                        Text("Total Amount: ${service['TotalAmount']}"),
                        Text("${service['Date']}"),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, ServiceEditPage.routeName);
          initList();
        },
      ),
    );
  }
}
