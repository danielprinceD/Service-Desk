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
  List? _brands;
  List? _models;
  
  List? _customers;

  Future<void> initVariables()async{
    List modelResult = await Model.getAllModel();
    _customers = Customer.getAllCustomer();
    _brands = Brand.getAllBrand();
    setState(() {
      _models = modelResult;
      _brands = _brands;
    });
    
  }

  @override
  void initState() {
    super.initState();
    if(widget.serviceId == null){

      initVariables();

      service = Service(brand: Brand(brandName: ''), model: Model(modelName: ''), IMEINumber: '', customer: Customer(customerName:'' , mobilNumber: ''), deliveryStatus: '', date: DateTime.now().toString().split(' ')[0].replaceAll( '-', '/'));

    }
    else {
      Map<String , dynamic> result = Service.getServiceById(widget.serviceId);
      service = Service.fromMap(result);
    }
    
  }

  @override
  Widget build(BuildContext context) {

    GlobalKey<FormState> formKey = GlobalKey();

    void _onSubmit(){
      if(!formKey.currentState!.validate()){
        return;
      }
      print(service?.toMap());
      service?.addOrUpdateService();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Service Added Successfully"))
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: widget.serviceId != null ? const Text('Edit Service') : const Text('Add Service'),
      ),
      body: Form(
          key: formKey ,
          child: ServiceFields.getServiceFields( service , widget ,  _brands , _models , _customers , 
            ElevatedButton(onPressed: _onSubmit , 
              child: Container(child: Text('Submit')) 
            ) 
        )        
      )
    );
  }
}