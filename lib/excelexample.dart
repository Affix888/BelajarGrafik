import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;


class ExcelExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CSV Viewer',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<dynamic>> data = [];
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final String csvData =
        await rootBundle.loadString('data/datapenjualan.csv');
    List<List<dynamic>> csvTable = CsvToListConverter().convert(csvData);
    setState(() {
      data = csvTable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CSV Viewer'),
      ),
      body: Center(
        child: data.isEmpty
            ? CircularProgressIndicator()
            : DataTable(
                columns: _getColumns(),
                rows: _getRows(),
              ),
      ),
    );
  }

  List<DataColumn> _getColumns() {
    return data[0]
        .map<DataColumn>((column) => DataColumn(label: Text(column.toString())))
        .toList();
  }

  List<DataRow> _getRows() {
    return data
        .sublist(1)
        .map<DataRow>((row) => DataRow(
              cells: row
                  .map<DataCell>((cell) => DataCell(Text(cell.toString())))
                  .toList(),
            ))
        .toList();
  }
}
