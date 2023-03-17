import 'package:sqflite/sqflite.dart' as hiSql;

class HaiSql {
//createDatabase

  static Future<void> generateTable(hiSql.Database database) async {
    await database.execute("""
CREATE TABLE item(
id INTEGER PRIMARY KEY
AUTOINCREMENT NOT NULL,
item_name TEXT,
item_barcode TEXT
)
""");
  }

  static Future<hiSql.Database> db() async {
    return hiSql.openDatabase('item.db', version: 1,
        onCreate: (hiSql.Database database, int version) async {
      await generateTable(database);
    });
  }

// create data

  static Future<int> createData(String item_name, String item_barcode) async {
    final db = await HaiSql.db();
    final data = {'item_name': item_name, 'item_barcode': item_barcode};
    return await db.insert('item', data);
  }

// get data

  static Future<List<Map<String, dynamic>>> getItem() async {
    final db = await HaiSql.db();
    return db.query('item');
  }

  static Future<void> insertList(List<Map<String, dynamic>> list) async {
    final db = await HaiSql.db();

    await db.transaction((txn) async {
      for (var map in list) {
        await txn.insert('item', map);
      }
    });

    await db.close();
  }

  static Future<void> updateDataItem(
      int id, String item_name, String item_barcode) async {
    final db = await HaiSql.db();

    final table = 'item';
    final newData = {'item_name': item_name, 'item_barcode': item_barcode};

    await db.update(table, newData, where: 'id = $id');

    await db.close();
  }

  static Future<void> deleteDataItem(int id) async {
    final db = await HaiSql.db();

    final table = 'item';

    await db.delete(table, where: 'id = $id');

    await db.close();
  }
}
