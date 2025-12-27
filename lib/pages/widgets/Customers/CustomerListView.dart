import 'package:flutter/material.dart';
import 'package:service_desk/models/Customer.dart';
import 'package:service_desk/pages/widgets/Customers/CustomerViewPage.dart';
import 'package:service_desk/utils/widgets/CustomSearchBar.dart';

class CustomerListView extends StatefulWidget {
  const CustomerListView({super.key});

  static const String routeName = '/customer/list';

  @override
  State<CustomerListView> createState() => _CustomerListViewState();
}

class _CustomerListViewState extends State<CustomerListView> {
  List _customers = [];
  List _searchCustomers = [];

  Future<void> initList() async {
    List customerList = await Customer.getAllCustomer();
    setState(() {
      _customers = customerList;
      _searchCustomers = customerList;
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
        builder: (context) => CustomerEditPage(
          customerId: _searchCustomers[index!]['CustomerId'],
        ),
      ),
    );
  }

  void searchCustomer(String value) {
    setState(() {
      _searchCustomers = _customers
          .where(
            (customer) =>
                customer['CustomerName'].toLowerCase().contains(
                  value.toLowerCase(),
                ) ||
                customer['MobileNumber'].toLowerCase().contains(
                  value.toLowerCase(),
                ),
          )
          .toList();
    });
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
              onChanged: searchCustomer,
              hintText: "Enter Customer Name or Mobile Number",
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: _searchCustomers.length,
                itemBuilder: (context, index) => ListTile(
                  leading: Icon(Icons.person),
                  title: Text("${_searchCustomers[index]['CustomerName']}"),
                  subtitle: Text(
                    "+91 ${_searchCustomers[index]['MobileNumber']}",
                  ),
                  onTap: () => {onClickCustomer(context, index)},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
