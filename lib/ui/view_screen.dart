import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pertamina_test/helper/appBar_cust.dart';
import 'package:pertamina_test/helper/db_helper.dart';
import 'package:pertamina_test/helper/search_textfield.dart';
import 'package:pertamina_test/helper/table_helper.dart';

class ViewDataScreen extends StatefulWidget {
  const ViewDataScreen({super.key});

  @override
  State<ViewDataScreen> createState() => _ViewDataScreenState();
}

class _ViewDataScreenState extends State<ViewDataScreen> {
  TextEditingController searchCo = TextEditingController();
  List<Map<String, dynamic>> allData = [];
  List<Map<String, dynamic>> match = [];
  int z = 1;
  String no = '';
  int id = 0;
  String itemName = '';
  String barcode = '';
  Timer? searchOnStoppedTyping;

  void getData() async {
    final data = await HaiSql.getItem();

    setState(() {
      allData = data;
      match = allData;
    });
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  void _onEnterforFindDetailSearch(String value) {
    setState(() {
      searchCo.text = value;
      match = allData.where((data) {
        var itemNameMatch = data['item_name']!
            .toLowerCase()
            .contains(searchCo.text.toLowerCase());
        var itemBarcodeMatch = data['item_barcode']!
            .toLowerCase()
            .contains(searchCo.text.toLowerCase());

        var idMatch = data["id"]!.toString().contains((searchCo.text));

        return itemNameMatch || itemBarcodeMatch || idMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: viewAppBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //floatingActionButton: floatButCust(height, context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: height,
        width: width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: height * 0.07,
                      width: width,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: SearchTextField(
                              controller: searchCo,
                              hint: 'Search Data',
                              suffix: Icons.search,
                              inputType: null,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: 60,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey),
                                  onPressed: () {
                                    _onEnterforFindDetailSearch(searchCo.text);
                                  },
                                  child: Text('Search')),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: match.isNotEmpty,
                      child: TableHelper(
                        allData: match,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
