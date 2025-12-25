
import 'package:flutter/material.dart';
import 'package:service_desk/models/Service.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:service_desk/pages/widgets/Services/ServiceEditPage.dart';
import 'package:service_desk/utils/widgets/CustomDropDown.dart';

class ServiceFields {
    
    static Widget getServiceFields( Service? service , ServiceEditPage serviceEditPage  , List brands , List models , List customers , Widget button ) {
      return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16.0,
            children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'IMEI Number',
            border: OutlineInputBorder(),
          ),
        ),
        
        DropdownSearch<Map<String, dynamic>>(
          mode: Mode.custom,

          items: (filter, cs) => brands.map((brand)=>{
            'brandName' : brand['brandName'],
            'brandId' : brand['brandId']
          }).toList(),

          compareFn: (a, b) => a['brandId'] == b['brandId'],

          popupProps: PopupProps.menu(
            showSearchBox: true,

            searchFieldProps: TextFieldProps(
              onChanged: (value) {
                
                final exists = brands.any((b) =>
                    b['brandName'].toString().toLowerCase() ==
                    value.toLowerCase());

                if (!exists && value.trim().isNotEmpty) {
                  service?.brand.brandName = value;
                }

              },

            ),

            itemBuilder: (context, item, isDisabled, isSelected) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Text(item['brandName']),
              );
            },
          ),

          dropdownBuilder: (context, selectedItem) {
            return CustomDropDown(child: Text( service?.brand.brandName.isEmpty == true ? 'Select brand' : service!.brand.brandName  ));
          },

          onChanged: (value) {
            if (value != null) {
              service?.brand.brandName = value['brandName'];
              service?.brand.brandId = value['brandId'];
            }
          },
        ),

        DropdownSearch<Map<String, dynamic>>(
          mode: Mode.custom,

          items: (filter, cs) => brands.map((brand)=>{
            'modelName' : brand['modelName'],
            'modelId' : brand['modelId']
          }).toList(),

          compareFn: (a, b) => a['modelName'] == b['modelId'],

          popupProps: PopupProps.menu(
            showSearchBox: true,

            searchFieldProps: TextFieldProps(
              onChanged: (value) {
                
                final exists = models.any((b) =>
                    b['modelName'].toString().toLowerCase() ==
                    value.toLowerCase());

                if (!exists && value.trim().isNotEmpty) {
                  service?.model.modelName = value;
                }

              },

            ),

            itemBuilder: (context, item, isDisabled, isSelected) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Text(item['brandName']),
              );
            },
          ),

          dropdownBuilder: (context, selectedItem) {
            return CustomDropDown(child: Text( service?.model.modelName.isEmpty == true ? 'Select Model' : service!.model.modelName  ));
          },

          onChanged: (value) {
            if (value != null) {
              service?.brand.brandName = value['modelName'];
              service?.brand.brandId = value['modelId'];
            }
          },
        ),
        

        DropdownSearch<Map<String, dynamic>>(
          mode: Mode.custom,

          items: (filter, cs) => customers.map((customer)=>{
            'customerName' : customer['customerName'],
            'customerId' : customer['customerId']
          }).toList(),

          compareFn: (a, b) => a['customerId'] == b['customerId'],

          popupProps: PopupProps.menu(
            showSearchBox: true,

            searchFieldProps: TextFieldProps(
              onChanged: (value) {
                
                final exists = customers.any((b) =>
                    b['customerName'].toString().toLowerCase() ==
                    value.toLowerCase());

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
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Amount',
            border: OutlineInputBorder(),
          ),
        ),
        InputDatePickerFormField(
           keyboardType: TextInputType.datetime ,
           firstDate: DateTime.fromMicrosecondsSinceEpoch(0) ,
           lastDate: DateTime(2500),
           initialDate: DateTime.now(),
        ),
        button
      ]
          )
);
      
    }
}