import 'package:flutter/material.dart';

import 'package:service_desk/pages/widgets/Services/ServiceListView.dart';
import 'package:service_desk/pages/widgets/Services/ServiceDetailsPage.dart';
import 'package:service_desk/pages/widgets/Services/ServiceEditPage.dart';
import 'package:service_desk/pages/widgets/Customers/CustomerListView.dart';
import 'package:service_desk/pages/widgets/Customers/CustomerDetailsPage.dart';
import 'package:service_desk/pages/widgets/Transactions/TransactionDetailsPage.dart';

class Routeconfig {
  static Map<String, Widget Function(BuildContext)> all(BuildContext context) {
    return {
      // Service
      ServiceListPage.routeName: (context) => ServiceListPage(),
      ServiceDetailsPage.routeName: (context) => ServiceDetailsPage(),
      ServiceEditPage.routeName: (context) => ServiceEditPage(),

      // Customer
      CustomerListView.routeName: (context) => CustomerListView(),
      CustomerDetailsPage.routeName: (context) => CustomerDetailsPage(),

      // Transaction
      TransactionDetailsPage.routeName: (context) => TransactionDetailsPage(),
    };
  }
}
