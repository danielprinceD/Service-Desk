import 'package:flutter/material.dart';
import 'package:service_desk/models/Brand.dart';
import 'package:service_desk/models/Customer.dart';
import 'package:service_desk/models/Model.dart';
import 'package:service_desk/models/Service.dart';
import 'package:service_desk/utils/widgets/CustomSubmitButton.dart';
import 'package:service_desk/utils/widgets/Service/ServiceFields.dart';

class ServiceEditPage extends StatefulWidget {
  const ServiceEditPage({super.key, this.serviceId, this.customerId});

  final int? serviceId;
  final int? customerId;
  static const String routeName = '/service/editpage';

  @override
  State<ServiceEditPage> createState() => _ServiceEditPageState();
}

class _ServiceEditPageState extends State<ServiceEditPage> {
  Service? service;
  List? _brands;
  List? _models;

  List? _customers;

  Future<void> initVariables() async {
    List modelResult = await Model.getAllModel();
    List customerResult = await Customer.getAllCustomer();
    List brandResult = await Brand.getAllBrand();
    setState(() {
      _models = modelResult;
      _customers = customerResult;
      _brands = brandResult;
    });

    if (widget.serviceId != null) {
      Map<String, dynamic> serviceList = await Service.getServiceById(
        widget.serviceId,
      );
      setState(() {
        service = Service.fromMap(serviceList);
      });
    }
  }

  Future<void> initCustomer() async {
    Map<String, dynamic> customerMap = await Customer.getCustomerById(
      widget.customerId,
    );
    setState(() {
      service?.customer = Customer.fromMap(customerMap);
    });
  }

  @override
  void initState() {
    super.initState();

    initVariables();
    if (widget.serviceId == null) {
      service = Service(
        brand: Brand(brandName: ''),
        model: Model(modelName: ''),
        IMEINumber: '',
        customer: Customer(customerName: '', mobileNumber: ''),
        deliveryStatus: '',
        date: DateTime.now().toString().split(' ')[0].replaceAll('-', '/'),
        totalAmount: 0.0,
      );
      if (widget.customerId != null) {
        initCustomer();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    service = null;
    _brands = null;
    _models = null;
    _customers = null;
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
        Navigator.pop(context);
      } catch (err) {
        if (!mounted) return;

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(err.toString())));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: widget.serviceId != null
            ? const Text('Edit Service')
            : const Text('Add Service'),
      ),
      body: Form(
        key: formKey,
        child: service != null
            ? ServiceFields(
                service: service,
                serviceEditPage: widget,
                brands: _brands,
                models: _models,
                customers: _customers,
                button: CustomSubmitButton(onPressed: () => onSubmit(context)),
              )
            : Text("No Data Found"),
      ),
    );
  }
}
