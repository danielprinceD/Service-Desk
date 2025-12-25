import 'package:flutter/material.dart';
import 'package:service_desk/models/Brand.dart';
import 'package:service_desk/models/Customer.dart';
import 'package:service_desk/models/Model.dart';
import 'package:service_desk/models/Service.dart';
import 'package:service_desk/utils/widgets/Service/ServiceFields.dart';
import '../../../utils/widgets/Service/ServiceFields.dart';
class ServiceEditPage extends StatefulWidget {
  const ServiceEditPage({super.key , this.serviceId});
  
  final int? serviceId;
  static const String routeName = '/service/editpage';

  @override
  State<ServiceEditPage> createState() => _ServiceEditPageState();
}

class _ServiceEditPageState extends State<ServiceEditPage> {

  Service? service;
  final List _brands = Brand.getAllBrand();
  final List _models = Model.getAllModel();
  final List _customers = Customer.getAllModel();

  @override
  void initState() {
    super.initState();
    if(widget.serviceId == null){
      service = Service(brand: Brand(brandName: ''), model: Model(modelName: ''), IMEINumber: '', customer: Customer(customerName:'' , mobilNumber: ''), deliveryStatus: '', date: '');
    }
    else {
      Map<String , dynamic> result = Service.getServiceById(widget.serviceId);
      service = Service.fromMap(result);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.serviceId != null ? const Text('Edit Service') : const Text('Add Service'),
      ),
      body: Form(
          child: ServiceFields.getServiceFields( service , widget ,  _brands , _models , _customers , ElevatedButton(onPressed: ()=>{}, child: Container(child: Text('Submit')) ) 
        )        
      )
    );
  }
}