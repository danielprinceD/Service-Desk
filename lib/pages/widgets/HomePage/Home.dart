import 'package:flutter/material.dart';
import 'RouteConfig.dart';
import 'package:service_desk/pages/widgets/Services/ServiceListView.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
  
      initialRoute: ServiceListPage.routeName,
      routes: Routeconfig.all(context),

      home: Scaffold(
        appBar: AppBar(
          title: const Text('Service Desk'),
        ),
        body: const Center(
          child: Text('Welcome to the Service Desk App!'),
        ),
      ),
    );
  }
}