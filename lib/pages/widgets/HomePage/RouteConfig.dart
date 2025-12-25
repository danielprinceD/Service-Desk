import 'package:flutter/material.dart';

import 'package:service_desk/pages/widgets/Services/ServiceListView.dart';
import 'package:service_desk/pages/widgets/Services/ServiceDetailsPage.dart';
import 'package:service_desk/pages/widgets/Services/ServiceEditPage.dart';

import 'package:service_desk/pages/widgets/Customers/CustomerListView.dart';
import 'package:service_desk/pages/widgets/Customers/CustomerEditPage.dart';
import 'package:service_desk/pages/widgets/Customers/CustomerDetailsPage.dart';

import 'package:service_desk/pages/widgets/Transactions/TransactionListView.dart';
import 'package:service_desk/pages/widgets/Transactions/TransactionEditPage.dart';
import 'package:service_desk/pages/widgets/Transactions/TransactionDetailsPage.dart'; 

class Routeconfig{
    static Map<String , Widget Function(BuildContext)> all(BuildContext context){
      return {
        // Service 
        ServiceListPage.routeName: (context) => const ServiceListPage(),
        ServiceDetailsPage.routeName: (context) => const ServiceDetailsPage(),
        ServiceEditPage.routeName: (context) => const ServiceEditPage(),

        // Customer 
        CustomerListView.routeName: (context) => const CustomerListView(),
        CustomerDetailsPage.routeName: (context) => const CustomerDetailsPage(),
        CustomerEditPage.routeName: (context) => const CustomerEditPage(),

        // Transaction
        TransactionListView.routeName: (context) => const TransactionListView(),
        TransactionDetailsPage.routeName: (context) => const TransactionDetailsPage(),
        TransactionEditPage.routeName: (context) => const TransactionEditPage(),
        
      };
    }
}