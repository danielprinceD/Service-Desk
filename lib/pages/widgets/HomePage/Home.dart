import 'package:flutter/material.dart';
import 'package:service_desk/pages/widgets/Customers/CustomerListView.dart';
import 'package:service_desk/pages/widgets/Services/ServiceListView.dart';
import 'package:service_desk/utils/widgets/CustomBottomavigationBar.dart';
import 'RouteConfig.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const String routeName = '/';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: Home.routeName,
      routes: Routeconfig.all(context),

      home: Scaffold(
        appBar: AppBar(
          title: [
            Text('Customer List'),
            Text('Service Desk'),
            Text('Service List'),
          ][_currentIndex],
        ),
        body: [
          CustomerListView(),
          Center(child: Text('Welcome to the Service Desk App!')),
          ServiceListPage(),
        ][_currentIndex],
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
