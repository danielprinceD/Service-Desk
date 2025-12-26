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
    List customerResult = await Customer.getAllCustomer();
    List brandResult = await Brand.getAllBrand();
    setState(() {
      _models = modelResult;
      _customers = customerResult;
      _brands = brandResult;
    });

    if(widget.serviceId != null){
      Map<String , dynamic> serviceList = await Service.getServiceById(widget.serviceId);
      setState(() {
        service = Service.fromMap(serviceList);
      });
    }
    
  }

  @override
  void initState() {
    super.initState();

    initVariables();
    if(widget.serviceId == null) { 
      service = Service(brand: Brand(brandName: ''), model: Model(modelName: ''), IMEINumber: '', customer: Customer(customerName:'' , mobileNumber: ''), deliveryStatus: '', date: DateTime.now().toString().split(' ')[0].replaceAll( '-', '/') , totalAmount: 0.0);
    }

  }

  @override
  Widget build(BuildContext context) {

    GlobalKey<FormState> formKey = GlobalKey();

    void onSubmit(context) async {
      if (!formKey.currentState!.validate()) return;

      try {
        final result = await service?.addOrUpdateService();
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Service Added Successfully")),
        );
      } catch (err) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(err.toString())),
        );
      }
      
    }


    return Scaffold(
      appBar: AppBar(
        title: widget.serviceId != null ? const Text('Edit Service') : const Text('Add Service'),
      ),
      body: Form(
          key: formKey ,
          child: service != null ? ServiceFields.getServiceFields( service , widget ,  _brands , _models , _customers , 
            ElevatedButton(onPressed: ()=>onSubmit(context) , 
              child: Container(child: Text('Submit')) 
            ) 
        ) : Text("No Data Found")        
      )
    );
  }
}