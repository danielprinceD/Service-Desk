import 'package:flutter/material.dart';
import 'package:service_desk/pages/widgets/Services/ServiceListView.dart';

class Routeconfig{
    static Map<String , Widget Function(BuildContext)> all(BuildContext context){
      return {
        ServiceListPage.routeName: (context) => const ServiceListPage(),
        
      };
    }
}