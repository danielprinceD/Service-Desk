import 'package:flutter/material.dart';
import 'package:service_desk/models/Transaction.dart';

class TransactionEditPage extends StatefulWidget {
  const TransactionEditPage({super.key, required this.serviceId});
  final int? serviceId;

  static const String routeName = '/transaction/editpage';

  @override
  State<TransactionEditPage> createState() => _TransactionEditPageState();
}

class _TransactionEditPageState extends State<TransactionEditPage> {
  GlobalKey<FormState> formKey = GlobalKey();

  Transaction? transaction;

  @override
  void initState() {
    super.initState();
    transaction = Transaction(
      serviceId: widget.serviceId!,
      amount: 0,
      note: '',
      paymentType: PaymentType.credit,
      date: DateTime.now().toString().split(' ')[0].replaceAll('-', '/'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transaction Edit')),
      body: Form(
        key: formKey,
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            spacing: 20,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) =>
                    transaction?.amount = double.tryParse(value) ?? 0.0,
                initialValue: transaction?.amount == 0
                    ? ''
                    : transaction?.amount.toString(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Amount is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Notes',
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) => transaction?.note = value,
                initialValue: transaction?.note,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Notes is required';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Transaction Type',
                  border: const OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(
                    value: PaymentType.credit,
                    child: Text('Credit'),
                  ),
                  DropdownMenuItem(
                    value: PaymentType.debit,
                    child: Text('Debit'),
                  ),
                ],
                onChanged: (value) =>
                    transaction?.paymentType = value ?? PaymentType.credit,
                initialValue: transaction?.paymentType,
                validator: (value) {
                  if (value == null) {
                    return 'Transaction type is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Transaction Date',
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) => transaction?.date = value,
                initialValue: transaction?.date,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Transaction date is required';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () => transaction?.addOrUpdateTransaction(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
