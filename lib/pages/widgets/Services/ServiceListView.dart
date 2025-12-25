import 'package:flutter/material.dart';
import 'package:service_desk/pages/widgets/Customers/CustomerEditPage.dart';
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
  @override
  void initState() {
    super.initState();
    _services = Service.Service.getAllServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service List'),
      ),
      body: Center(
        child: (_services.isEmpty)
            ? const Text('No services available.')
            : ListView.builder(
                itemCount: _services.length,
                itemBuilder: (context, index) {
                  final service = _services[index];
                  return ListTile(
                    title: Text('Service ID: ${service['id']}'),
                    subtitle: Text('IMEI: ${service['IMEINumber']} - Status: ${service['deliveryStatus']}'),
                  );
                },
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ServiceEditPage.routeName );
        },
      ),
    );
  }
}