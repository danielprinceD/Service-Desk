
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:service_desk/models/Service.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:service_desk/pages/widgets/Services/ServiceEditPage.dart';
import 'package:service_desk/utils/widgets/CustomDropDown.dart';

class ServiceFields {
    
    static Widget getServiceFields( Service? service , ServiceEditPage serviceEditPage  , List? brands , List? models , List? customers , Widget button ) {
      return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(

            child: Column(
              spacing: 15,
              children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'IMEI Number',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => service?.IMEINumber = value,
                    initialValue: service?.IMEINumber,

                  ),
                  
                  DropdownSearch<Map<String, dynamic>>(
                    mode: Mode.custom,
                    items: (filter, cs) => brands?.map((brand)=>{
                      'BrandName' : brand['BrandName'],
                      'BrandId' : brand['BrandId']
                    }).toList() ?? [],

                    compareFn: (a, b) => a['BrandId'] == b['BrandId'],

                    popupProps: PopupProps.menu(
                      showSearchBox: true,

                      searchFieldProps: TextFieldProps(
                        onChanged: (value) {        
                          final exists = brands?.any((b) =>
                              b['BrandName'].toString().toLowerCase() ==
                              value.toLowerCase()) ?? false;

                          if (!exists && value.trim().isNotEmpty) {
                            service?.brand.brandName = value;
                          }

                        },

                      ),

                      itemBuilder: (context, item, isDisabled, isSelected) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(item['BrandName']),
                        );
                      },
                    ),

                    dropdownBuilder: (context, selectedItem) {
                      return CustomDropDown(child: Text( service?.brand.brandName.isEmpty == true ? 'Select brand' : service!.brand.brandName  ));
                    },

                    onChanged: (value) {
                      if (value != null) { 
                        service?.brand.brandName = value['BrandName'];
                        service?.brand.brandId = value['BrandId'];
                      }
                    },
                  ),

                  DropdownSearch<Map<String, dynamic>>(
                    mode: Mode.custom,

                    items: (filter, cs) => models?.map((model)=>{
                      'ModelName' : model['ModelName'],
                      'ModelId' : model['ModelId']
                    }).toList() ?? [],

                    compareFn: (a, b) => a['ModelName'] == b['ModelId'],

                    popupProps: PopupProps.menu(
                      showSearchBox: true,

                      searchFieldProps: TextFieldProps(
                        onChanged: (value) {
                          
                          final exists = models?.any((b) =>
                              b['ModelName'].toString().toLowerCase() ==
                              value.toLowerCase()) ?? false;

                          if (!exists && value.trim().isNotEmpty) {
                            service?.model.modelName = value;
                          }

                        },

                      ),

                      itemBuilder: (context, item, isDisabled, isSelected) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(item['ModelName']),
                        );
                      },
                    ),

                    dropdownBuilder: (context, selectedItem) {
                      return CustomDropDown(child: Text( service?.model.modelName.isEmpty == true ? 'Select Model' : service!.model.modelName  ));
                    },

                    onChanged: (value) {
                      if (value != null) {
                        service?.brand.brandName = value['ModelName'];
                        service?.brand.brandId = value['ModelId'];
                      }
                    },
                  ),
                  

                  DropdownSearch<Map<String, dynamic>>(
                    mode: Mode.custom,

                    items: (filter, cs) => customers?.map((customer)=>{
                      'customerName' : customer['customerName'],
                      'customerId' : customer['customerId']
                    }).toList() ?? [],

                    compareFn: (a, b) => a['customerId'] == b['customerId'],

                    popupProps: PopupProps.menu(
                      showSearchBox: true,

                      searchFieldProps: TextFieldProps(
                        onChanged: (value) {
                          
                          final exists = customers?.any((b) =>
                              b['customerName'].toString().toLowerCase() ==
                              value.toLowerCase()) ?? false;

                          if (!exists && value.trim().isNotEmpty) {
                            service?.customer.customerName = value;
                          }

                        },

                      ),

                      itemBuilder: (context, item, isDisabled, isSelected) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(item['customerName']),
                        );
                      },
                    ),

                    dropdownBuilder: (context, selectedItem) {
                      return CustomDropDown(child: Text( service?.customer.customerName?.isEmpty == true ? 'Select Customer' : service!.customer.customerName!  ));
                    },

                    onChanged: (value) {
                      if (value != null) {
                        service?.brand.brandName = value['customerName'];
                        service?.brand.brandId = value['customerId'];
                      }
                    },
                  )

                  ,TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Mobile Number',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.numberWithOptions(),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    maxLength: 10,
                    onChanged: (value){
                      service?.customer.mobilNumber = value;
                    },
                    validator: (value){
                      if(value == null || value.isEmpty ){
                        return "Phone Number cannot be Empty";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow( RegExp(r'^\d*\.?\d*$'))
                    ],
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Amount Field cannot be empty";
                      }
                    },
                    onChanged: (value)=>service?.amount = double.parse(value) ,
                  ),
                  TextFormField(
                    decoration:  const InputDecoration(
                      labelText: 'Date',
                      border: OutlineInputBorder(),
                      hint: Text('yyyy-mm-dd')
                    ),
                    initialValue: service?.date,
                    validator: (value){
                      if(value == null || value.isEmpty ){
                        return "Date Field cannot be Empty";
                      }
                      return null;
                    },
                    onChanged: (value)=>service?.date = value,
                  ),
                  button
                ]
            ),
          )
);
      
    }
}