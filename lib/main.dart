import 'package:flutter/material.dart';
import 'package:service_desk/controller/db_initializer.dart';
import './pages/widgets/HomePage/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBInitializer.instance.initializeDB();
  runApp(const Home());
}
