import 'package:service_desk/controller/db_initializer.dart';
import 'package:sqflite/sqflite.dart';

enum PaymentType { credit, debit }

class Transaction {
  int? transactionId;
  int serviceId;
  double amount;
  String note;
  PaymentType paymentType;
  String date;
  Transaction({
    this.transactionId,
    required this.serviceId,
    required this.amount,
    required this.note,
    required this.paymentType,
    required this.date,
  });

  static List<Transaction> fromMap(List<Map<String, dynamic>> transactionMaps) {
    return transactionMaps
        .map(
          (map) => Transaction(
            transactionId: map['TransactionId'],
            serviceId: map['ServiceId'],
            amount: map['Amount'],
            note: map['Note'],
            paymentType:
                PaymentType.values[map['PaymentType'] == 1 ? 1 : 0],
            date: map['Date'],
          ),
        )
        .toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'transactionId': transactionId,
      'serviceId': serviceId,
      'amount': amount,
      'note': note,
      'PaymentType': paymentType.index,
      'date': date,
    };
  }

  Future<int?> addOrUpdateTransaction() async {
    Database db = await DBInitializer.instance.db;
    int result = transactionId == null
        ? await db.insert('TransactionTable', toMap())
        : await db.update(
            'TransactionTable',
            toMap(),
            where: 'TransactionId = ?',
            whereArgs: [transactionId],
          );
    return result;
  }

  static Future<List<Map<String, dynamic>>> getTransactionsByServiceId(
    int? serviceId,
  ) async {
    Database db = await DBInitializer.instance.db;
    List<Map<String, dynamic>> transactions = await db.rawQuery(
      ''' SELECT * FROM TransactionTable
          WHERE ServiceId = ?''',
      [serviceId],
    );
    return transactions;
  }
}
