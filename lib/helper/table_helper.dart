import 'package:flutter/material.dart';
import 'package:pertamina_test/ui/form_screen.dart';

class TableHelper extends StatelessWidget {
  final List<Map<String, dynamic>> allData;

  const TableHelper({
    super.key,
    required this.allData,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(
          label: Text('No'),
        ),
        DataColumn(
          label: Text('ItemID'),
        ),
        DataColumn(
          label: Text('ItemName'),
        ),
        DataColumn(
          label: Text('Barcode'),
        ),
        DataColumn(
          label: Text('Edit'),
        ),
        DataColumn(
          label: Text('Delete'),
        ),
      ],
      rows: allData
          .map((e) => DataRow(cells: [
                DataCell(Text(e['id'].toString())),
                DataCell(Text(e['id'].toString())),
                DataCell(Text(e['item_name'] ?? '')),
                DataCell(Text(e['item_barcode'] ?? '')),
                DataCell(IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormScreen(
                              mode: 'edit',
                              id: e['id'].toString(),
                              itemName: e['item_name'] ?? '',
                              barcode: e['item_barcode'] ?? '',
                            ),
                          ));
                    },
                    icon: Icon(Icons.edit))),
                DataCell(IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormScreen(
                              mode: 'delete',
                              id: e['id'].toString(),
                              itemName: e['item_name'] ?? '',
                              barcode: e['item_barcode'] ?? '',
                            ),
                          ));
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))),
              ]))
          .toList(),
    );
  }
}
