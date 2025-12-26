import 'package:flutter/material.dart';
import 'package:service_desk/models/Transaction.dart';

class TransactionListView extends StatefulWidget {
  const TransactionListView({super.key, required this.serviceId});
  final int? serviceId;
  static const String routeName = '/transaction/list';

  @override
  State<TransactionListView> createState() => _TransactionListViewState();
}

class _TransactionListViewState extends State<TransactionListView> {
  List<Transaction> _transactions = [];
  Future<void> initTransactions() async {
    List<Map<String, dynamic>> transactionMaps =
        await Transaction.getTransactionsByServiceId(widget.serviceId);
    setState(() {
      _transactions = Transaction.fromMap(transactionMaps);
    });
  }

  @override
  void initState() {
    super.initState();
    initTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transaction List')),
      body: Center(
        child: (_transactions.isEmpty)
            ? const Text('No transactions available.')
            : ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                padding: const EdgeInsets.all(5),
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final transaction = _transactions[index];
                  return ListTile(
                    title: Text(transaction.date),
                    subtitle: Text(transaction.amount.toString()),
                  );
                },
              ),
      ),
    );
  }
}
