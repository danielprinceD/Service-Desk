import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:service_desk/models/Brand.dart';
import 'package:service_desk/models/Service.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:service_desk/pages/widgets/Services/ServiceEditPage.dart';
import 'package:service_desk/utils/widgets/CustomDropDown.dart';

class ServiceFields extends StatefulWidget {
  const ServiceFields({
    super.key,
    required this.service,
    required this.serviceEditPage,
    required this.brands,
    required this.models,
    required this.customers,
    required this.button,
  });
  final Service? service;
  final ServiceEditPage serviceEditPage;
  final List? brands;
  final List? models;
  final List? customers;
  final Widget button;

  @override
  State<ServiceFields> createState() => _ServiceFieldsState();
}

class _ServiceFieldsState extends State<ServiceFields> {
  TextEditingController initialValueController = TextEditingController();
  @override
  void initState() {
    super.initState();
    initialValueController.text = widget.service?.customer.mobileNumber ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22.0, 30.0, 22.0, 25.0),
      child: SingleChildScrollView(
        child: Column(
          spacing: 15,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'IMEI Number',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => widget.service?.IMEINumber = value,
              initialValue: widget.service?.IMEINumber,
              validator: (value) => value == null || value.isEmpty
                  ? 'IMEI Number is required'
                  : null,
            ),

            DropdownSearch<Map<String, dynamic>>(
              mode: Mode.form,
              validator: (value) => value == null || value.isEmpty == true
                  ? 'Brand is required'
                  : null,
              items: (filter, cs) =>
                  widget.brands
                      ?.map(
                        (brand) => {
                          'BrandName': brand['BrandName'],
                          'BrandId': brand['BrandId'],
                        },
                      )
                      .toList() ??
                  [],

              compareFn: (a, b) => a['BrandId'] == b['BrandId'],

              popupProps: PopupProps.menu(
                showSearchBox: true,

                searchFieldProps: TextFieldProps(
                  onChanged: (value) {
                    final exists =
                        widget.brands?.any(
                          (b) =>
                              b['BrandName'].toString().toLowerCase() ==
                              value.toLowerCase(),
                        ) ??
                        false;

                    if (!exists && value.trim().isNotEmpty) {
                      widget.service?.brand.brandName = value;
                      widget.service?.brand.brandId = null;
                    }
                  },
                ),

                itemBuilder: (context, item, isDisabled, isSelected) {
                  return Container(
                    padding: EdgeInsets.all(3),
                    child: ListTile(
                      leading: Icon(Icons.phone_android_outlined),
                      title: Text(item['BrandName']),
                    ),
                  );
                },
              ),

              dropdownBuilder: (context, selectedItem) {
                return CustomDropDown(
                  child: Text(
                    widget.service?.brand.brandName.isEmpty == true
                        ? 'Select brand'
                        : widget.service!.brand.brandName,
                  ),
                );
              },

              onChanged: (value) {
                if (value != null) {
                  widget.service?.brand.brandName = value['BrandName'];
                  widget.service?.brand.brandId = value['BrandId'];
                }
              },
            ),

            DropdownSearch<Map<String, dynamic>>(
              mode: Mode.form,
              validator: (value) => value == null || value.isEmpty == true
                  ? 'Model is required'
                  : null,
              items: (filter, cs) =>
                  widget.models
                      ?.map(
                        (model) => {
                          'ModelName': model['ModelName'],
                          'ModelId': model['ModelId'],
                        },
                      )
                      .toList() ??
                  [],

              compareFn: (a, b) => a['ModelName'] == b['ModelId'],

              popupProps: PopupProps.menu(
                showSearchBox: true,

                searchFieldProps: TextFieldProps(
                  onChanged: (value) {
                    final exists =
                        widget.models?.any(
                          (b) =>
                              b['ModelName'].toString().toLowerCase() ==
                              value.toLowerCase(),
                        ) ??
                        false;

                    if (!exists && value.trim().isNotEmpty) {
                      widget.service?.model.modelName = value;
                      widget.service?.model.modelId = null;
                    }
                  },
                ),

                itemBuilder: (context, item, isDisabled, isSelected) {
                  return Container(
                    padding: EdgeInsets.all(3),
                    child: ListTile(
                      leading: Icon(Icons.phone_android_outlined),
                      title: Text(item['ModelName']),
                    ),
                  );
                },
              ),

              dropdownBuilder: (context, selectedItem) {
                return CustomDropDown(
                  child: Text(
                    widget.service?.model.modelName.isEmpty == true
                        ? 'Select Model'
                        : widget.service!.model.modelName,
                  ),
                );
              },

              onChanged: (value) {
                if (value != null) {
                  widget.service?.model.modelName = value['ModelName'];
                  widget.service?.model.modelId = value['ModelId'];
                }
              },
            ),

            DropdownSearch<Map<String, dynamic>>(
              mode: Mode.form,
              validator: (value) =>
                  widget.service?.customer.customerName == null ||
                      value?.isEmpty == true
                  ? 'Customer is required'
                  : null,
              items: (filter, cs) =>
                  widget.customers
                      ?.map(
                        (customer) => {
                          'CustomerName': customer['CustomerName'],
                          'CustomerId': customer['CustomerId'],
                          'MobileNumber': customer['MobileNumber'],
                        },
                      )
                      .toList() ??
                  [],

              compareFn: (a, b) => a['CustomerId'] == b['CustomerId'],

              popupProps: PopupProps.menu(
                showSearchBox: true,

                searchFieldProps: TextFieldProps(
                  onChanged: (value) {
                    final exists =
                        widget.customers?.any(
                          (b) =>
                              b['CustomerName'].toString().toLowerCase() ==
                              value.toLowerCase(),
                        ) ??
                        false;

                    if (!exists && value.trim().isNotEmpty) {
                      widget.service?.customer.customerName = value;
                      widget.service?.customer.customerId = null;
                    }
                  },
                ),

                itemBuilder: (context, item, isDisabled, isSelected) {
                  return Container(
                    padding: EdgeInsets.all(3),
                    child: ListTile(
                      leading: Icon(Icons.person_outline),
                      title: Text(item['CustomerName']),
                      subtitle: Text('+91 ${item['MobileNumber']}'),
                    ),
                  );
                },
              ),

              dropdownBuilder: (context, selectedItem) {
                return CustomDropDown(
                  child: Text(
                    widget.service?.customer.customerName?.isEmpty == true
                        ? 'Select Customer'
                        : widget.service!.customer.customerName!,
                  ),
                );
              },

              onChanged: (value) {
                if (value != null) {
                  widget.service?.customer.customerName = value['CustomerName'];
                  widget.service?.customer.customerId = value['CustomerId'];
                  setState(() {
                    initialValueController.text = value['MobileNumber'];
                  });
                }
              },
            ),
            TextFormField(
              controller: initialValueController,
              decoration: InputDecoration(
                labelText: 'Mobile Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 10,
              onChanged: (value) {
                setState(() {
                  widget.service?.customer.mobileNumber = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Phone Number cannot be Empty";
                }
                if (value.length != 10) {
                  return "Phone Number must be 10 digits";
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: widget.service?.totalAmount == 0.0
                  ? ''
                  : widget.service?.totalAmount.toString(),
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Amount Field cannot be empty";
                }
              },
              onChanged: (value) =>
                  widget.service?.totalAmount = double.tryParse(value) ?? 0.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Date',
                border: OutlineInputBorder(),
                hint: Text('yyyy-mm-dd'),
              ),
              initialValue: widget.service?.date,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Date Field cannot be Empty";
                }
                return null;
              },
              onChanged: (value) => widget.service?.date = value,
            ),
            widget.button,
          ],
        ),
      ),
    );
  }
}
