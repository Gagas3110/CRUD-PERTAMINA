import 'package:flutter/material.dart';
import 'package:pertamina_test/helper/db_helper.dart';
import 'package:pertamina_test/ui/view_screen.dart';

class FormScreen extends StatefulWidget {
  final String mode;
  final String id;
  final String itemName;
  final String barcode;
  const FormScreen(
      {super.key,
      required this.id,
      required this.itemName,
      required this.barcode,
      required this.mode});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController itemNameCo = TextEditingController();
  TextEditingController barcodeCo = TextEditingController();
  TextEditingController idCo = TextEditingController();
  List<Map<String, dynamic>> multipleList = [];
  final keys = GlobalKey<FormState>();

  Future<void> multipleData() async {
    await HaiSql.insertList(multipleList);
  }

  Future<void> addData() async {
    await HaiSql.createData(itemNameCo.text, barcodeCo.text);
  }

  Future<void> editData() async {
    await HaiSql.updateDataItem(
        int.parse(widget.id), itemNameCo.text, barcodeCo.text);
  }

  Future<void> deleteData() async {
    await HaiSql.deleteDataItem(int.parse(widget.id));
  }

  @override
  void initState() {
    super.initState();
    idCo.text = widget.id;
    itemNameCo.text = widget.itemName;
    barcodeCo.text = widget.barcode;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: formAppBar(),
      body: Container(
        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
        height: height,
        width: width,
        child: Form(
          key: keys,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: widget.mode != 'add',
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text('ItemID ')),
                        Expanded(
                          child: TextFormField(
                            controller: idCo,
                            enabled: false,
                            decoration: InputDecoration(
                              label: Text(''),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(2)),
                              filled: true, //<-- SEE HERE
                              fillColor: Colors.grey.shade400,
                            ),
                            validator: (value) {
                              if (value?.isNotEmpty != true) {
                                return 'Mandatory, fill this field';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10)
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(child: Text('ItemName ')),
                  Expanded(
                    child: TextFormField(
                      controller: itemNameCo,
                      decoration: InputDecoration(
                        label: Text(''),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2)),
                      ),
                      validator: (value) {
                        if (value?.isNotEmpty != true) {
                          return 'Mandatory, fill this field';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: Text('Barcode  ')),
                  Expanded(
                    child: TextFormField(
                      controller: barcodeCo,
                      decoration: InputDecoration(
                        label: Text(''),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2)),
                      ),
                      validator: (value) {
                        if (value?.isNotEmpty != true) {
                          return 'Mandatory, fill this field';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Column(
                children: [
                  Visibility(
                    visible: widget.mode == 'add',
                    child: Row(
                      children: [
                        Center(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey),
                              onPressed: () {
                                if (keys.currentState!.validate()) {
                                  Map<String, dynamic> newMap = {
                                    "item_name": itemNameCo.text,
                                    "item_barcode": barcodeCo.text
                                  };

                                  multipleList.add(newMap);

                                  setState(() {
                                    itemNameCo.clear();
                                    barcodeCo.clear();
                                    multipleList.length;
                                  });
                                }
                              },
                              child: Text('Add')),
                        ),
                        SizedBox(width: 10),
                        Text(
                            'Jumlah Barang Sementara = ${multipleList.length}'),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Visibility(
                        visible:
                            widget.mode == 'add' && multipleList.length != 0,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey),
                            onPressed: () async {
                              await multipleData();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewDataScreen()));
                            },
                            child: Text('Simpan Semua Barang')),
                      ),
                      Visibility(
                        visible: widget.mode == 'edit',
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            onPressed: () async {
                              if (keys.currentState!.validate()) {
                                await editData();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ViewDataScreen()));
                              }
                            },
                            child: Text('Update')),
                      ),
                      Visibility(
                        visible: widget.mode == 'delete',
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () async {
                              if (keys.currentState!.validate()) {
                                await deleteData();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ViewDataScreen()));
                              }
                            },
                            child: Text('Delete')),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar formAppBar() {
    return AppBar(
      title: Center(
          child: Text(widget.mode == 'add'
              ? 'Form Add Screen'
              : widget.mode == 'edit'
                  ? 'Form Edit Screen'
                  : 'Form Delete Screen')),
      elevation: 0,
      backgroundColor: Colors.grey,
    );
  }
}
