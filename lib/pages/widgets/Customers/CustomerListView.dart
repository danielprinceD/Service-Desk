import 'package:flutter/material.dart';
import 'package:service_desk/models/Customer.dart';
import 'package:service_desk/pages/widgets/Customers/CustomerViewPage.dart';

class CustomerListView extends StatefulWidget {
  const CustomerListView({super.key});

  static const String routeName = '/customer/list';

  @override
  State<CustomerListView> createState() => _CustomerListViewState();
}

class _CustomerListViewState extends State<CustomerListView> {
  List _customers = [];

  Future<void> initList() async {
    List customerList = await Customer.getAllCustomer();
    setState(() {
      _customers = customerList;
    });
  }

  @override
  void initState() {
    super.initState();
    initList();
  }

  void onClickCustomer(BuildContext context, int? index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CustomerEditPage(customerId: _customers[index!]['CustomerId']),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(5),
        child: (_customers.isEmpty)
            ? const Center(child: Text('No customers found'))
            : ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10),
                padding: EdgeInsets.all(5),
                itemCount: _customers.length,
                itemBuilder: (context, index) => ListTile(
                  leading: Icon(Icons.person),
                  onTap: () => {onClickCustomer(context, index)},
                  title: Text(
                    "${index + 1}. Customer Name: ${_customers[index]['CustomerName']}",
                  ),
                  subtitle: Text(
                    "Mobile Number: ${_customers[index]['MobileNumber']}",
                  ),
                  shape: Border.all(width: 2),
                ),
              ),
      ),
    );
  }
}
