

import 'package:service_desk/controller/db_initializer.dart';

enum TransactionType { credit , debit }

class Transaction {
  final int? transactionId;
  final int serviceId;
  final String transactionDate;
  final double amount;
  final String notes;
  final TransactionType transactionType;
  final String date;
  Transaction({
    this.transactionId,
    required this.serviceId,
    required this.transactionDate,
    required this.amount,
    required this.notes,
    required this.transactionType,
    required this.date,
  });

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      transactionId: map['transactionId'],
      serviceId: map['serviceId'],
      transactionDate: map['transactionDate'],
      amount: map['amount'],
      notes: map['notes'],
      transactionType: TransactionType.values[map['transactionType']],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'transactionId': transactionId,
      'serviceId': serviceId,
      'transactionDate': transactionDate,
      'amount': amount,
      'notes': notes,
      'transactionType': transactionType.index,
      'date': date,
    };
  }

  bool addOrUpdateTransaction() {
    DBInitializer.instance.db.then((database) async {
      transactionId == null
          ? await database.insert('TransactionTable', toMap())
          : await database.update('TransactionTable', toMap(),
              where: 'TransactionId = ?', whereArgs: [transactionId]);
      return true;
    });
    return false;
  }
  

}