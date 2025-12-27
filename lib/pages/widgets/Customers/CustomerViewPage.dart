import 'package:flutter/material.dart';
import 'package:service_desk/models/Customer.dart';
import 'package:service_desk/models/Service.dart';
import 'package:service_desk/utils/widgets/Customer/CustomerFields.dart';

class CustomerEditPage extends StatefulWidget {
  const CustomerEditPage({super.key, required this.customerId});
  final int? customerId;

  static const String routeName = '/customer/editpage';

  @override
  State<CustomerEditPage> createState() => _CustomerEditPageState();
}

class _CustomerEditPageState extends State<CustomerEditPage> {
  GlobalKey<FormState> formKey = GlobalKey();

  Customer? customer;
  List<Service> _services = [];
  Future<void> initCustomer() async {
    Map<String, dynamic> customerMap = await Customer.getCustomerById(
      widget.customerId,
    );
    List<Map<String, dynamic>> services =
        await Customer.getCustomerWithServicesById(widget.customerId);
    setState(() {
      customer = Customer.fromMap(customerMap);
      _services = services.map((service) => Service.fromMap(service)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    initCustomer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.customerId != null
            ? const Text('View Customer')
            : const Text('Add Customer'),
      ),
      body: Form(
        key: formKey,

        child: customer != null
            ? Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CustomerFields(
                  customer: customer!,
                  services: _services,
                  context: context,
                  initCustomer: initCustomer,
                ),
              )
            : Text("No Data Found"),
      ),
    );
  }
}
