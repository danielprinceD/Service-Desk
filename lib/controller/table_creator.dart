

class TableCreator {
   static String _createTable(String tableName, Map<String, String> columns) {
      String columnsDefinition = columns.entries
          .map((entry) => '${entry.key} ${entry.value}')
          .join(', ');
      return 'CREATE TABLE $tableName ($columnsDefinition);';
   }


  static String createCustomerTable(){
    return _createTable('CustomerTable', {
      'CustomerId': 'INTEGER PRIMARY KEY AUTOINCREMENT',
      'CustomerName': 'TEXT',
      'MobilNumber': 'TEXT',
    });
  }

  static String createBrandTable(){
    return _createTable('BrandTable', {
      'BrandId': 'INTEGER PRIMARY KEY AUTOINCREMENT',
      'BrandName': 'TEXT'
    });
  }

  static String createModelTable(){
    return _createTable('ModelTable', {
      'ModelId': 'INTEGER PRIMARY KEY AUTOINCREMENT',
      'ModelName': 'TEXT',
    });
  }

  static String createServiceTable(){
    return _createTable('ServiceTable', {
      'ServiceId': 'INTEGER PRIMARY KEY AUTOINCREMENT',
      'brandId': 'INTEGER References BrandTable(BrandId)',
      'modelId': 'INTEGER References ModelTable(ModelId)',
      'IMEINumber': 'TEXT',
      'CustomerId': 'INTEGER References CustomerTable(CustomerId)',
      'TotalAmount': 'REAL',
      'DeliveryStatus': 'TEXT',
      'Date': 'TEXT',
    }) 
    + addConstraint('fk_service_customer', 'CustomerId', 'CustomerTable', 'CustomerId', 'RESTRICT')
    + addConstraint('fk_service_brand', 'brandId', 'BrandTable', 'BrandId', 'RESTRICT')
    + addConstraint('fk_service_model', 'modelId', 'ModelTable', 'ModelId', 'RESTRICT')
    ;
  }

  static String createTransactionTable(){
    return _createTable('TransactionTable', {
      'TransactionId': 'INTEGER PRIMARY KEY AUTOINCREMENT',
      'ServiceId': 'INTEGER References ServiceTable(ServiceId)',
      'Amount': 'REAL',
      'Note': 'TEXT',
      'PaymentType': 'TEXT',
      'Date': 'TEXT',
    }) 
    + addConstraint('fk_transaction_service', 'ServiceId', 'ServiceTable', 'ServiceId', 'RESTRICT');

  }

  static String addConstraint(String constraintName, String foreignKey, String referencesTable, String referencesColumn, String onDeleteAction) {
    return ' ADD CONSTRAINT $constraintName FOREIGN KEY ($foreignKey) REFERENCES $referencesTable($referencesColumn) ON DELETE $onDeleteAction;';
  }

}