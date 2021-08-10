import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HabitsDatabase{

  setDatabase() async{
    String databasePath = await getDatabasesPath();
    String path = join(databasePath,"habits_db");
    Database database = await openDatabase(path,version: 1,onCreate: (Database db,int version)async{
      await db.execute("CREATE TABLE Habits (id INTEGER PRIMARY KEY, name TEXT, amount TEXT, time INTEGER, notifyId INTEGER)");
    });
    return database;
  }

}