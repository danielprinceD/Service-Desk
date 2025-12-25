import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import './table_creator.dart';
class DBInitializer {
  static const String dbName = 'service_desk.db';
  static final DBInitializer instance = DBInitializer._instance();
  static Database? database;

  DBInitializer._instance();

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
    String path = await getDatabasesPath();
    String dbPath = join(path, dbName);
    print( """\n\n\n 
                        Database Location : " + $dbPath + 
          "\n\n\n
    """);
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (newdb, verSion) async {
        await createTables(newdb, verSion);
      },
    );
  }
}