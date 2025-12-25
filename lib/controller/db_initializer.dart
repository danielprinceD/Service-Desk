import 'package:sqflite/sqflite.dart';
import './table_creator.dart';
class DBInitializer {
  static const String dbName = 'service_desk.db';
  static final DBInitializer instance = DBInitializer._instance();
  DBInitializer._instance();

  static Database? database;

  Future<Database> get db async {
    database ??= await initializeDB();
    return database!;
  }

  Future createTables(Database db, int version) async {
    await db.execute(TableCreator.createCustomerTable());
    await db.execute(TableCreator.createBrandTable());
    await db.execute(TableCreator.createModelTable());
    await db.execute(TableCreator.createServiceTable());
    await db.execute(TableCreator.createTransactionTable());
  }

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath() + dbName;
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await createTables(db, version);
      },
    );
  }
}