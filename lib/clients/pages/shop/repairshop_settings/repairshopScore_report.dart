import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';
import 'package:service_fixing/clients/controllers/report/getScoreRapairshopController.dart';
import 'package:service_fixing/constants.dart';

class RepairshopScoreReport extends StatefulWidget {
  const RepairshopScoreReport({Key? key}) : super(key: key);

  @override
  State<RepairshopScoreReport> createState() => _RepairshopScoreReportState();
}

class _RepairshopScoreReportState extends State<RepairshopScoreReport> {
  late String _sortColumnName;
  late bool _sortAscending;
  Timer? _timer;
  late TextEditingController _dateRangeController;
  DateTime? _startDate;
  DateTime? _endDate;

  final GetScoreRepairshopController _repairshopScoreController =
      Get.put(GetScoreRepairshopController());

  @override
  void initState() {
    super.initState();
    _sortColumnName = 'id';
    _sortAscending = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Timer logic
    });
    _repairshopScoreController.fetchScoreRepairshopData();
    _startDate = null;
    _endDate = null;
    _dateRangeController = TextEditingController(text: '');
  }

  List<Map<String, dynamic>> getFilteredRows() {
    if (_startDate == null && _endDate == null) {
      return _repairshopScoreController.repairScoreData;
    } else {
      return _repairshopScoreController.repairScoreData.where((row) {
        DateTime createdAt = DateTime.parse(row['createdAt']);
        bool isInDateRange = true;
        if (_startDate != null && _endDate != null) {
          isInDateRange =
              createdAt.isAfter(_startDate!) && createdAt.isBefore(_endDate!);
        } else if (_startDate != null) {
          isInDateRange = createdAt.isAfter(_startDate!);
        } else if (_endDate != null) {
          isInDateRange = createdAt.isBefore(_endDate!);
        }

        return isInDateRange;
      }).toList();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _dateRangeController.dispose();
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _printDataTable() async {
    List<Map<String, dynamic>> rows = getFilteredRows();
    final ByteData fontData =
        await rootBundle.load('assets/fonts/phetsarath_ot.ttf');
    final Uint8List fontBytes = fontData.buffer.asUint8List();
    final ttf = pw.Font.ttf(fontBytes.buffer.asByteData());
    final pdf = pw.Document();
    final headers = [
      'ລະຫັດ',
      'ຊື່ຮ້ານສ້ອມແປງ',
      'ຄະແນນເກດຣ',
    ];
    final data = rows.map((row) {
      return [
        row['shop_id'],
        row['shop_name'],
        row['average'],
      ];
    }).toList();

    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.TableHelper.fromTextArray(
          headers: headers,
          data: data,
          border: pw.TableBorder.all(color: PdfColors.black, width: 0.5),
          headerStyle: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold),
          cellStyle: pw.TextStyle(font: ttf),
          headerDecoration: const pw.BoxDecoration(
            color: PdfColors.grey300,
          ),
          cellHeight: 30,
          cellAlignments: {
            for (var i = 0; i < headers.length; i++) i: pw.Alignment.centerLeft,
          },
          cellPadding: const pw.EdgeInsets.all(4),
          oddRowDecoration: const pw.BoxDecoration(
            color: PdfColors.grey100,
          ),
        );
      },
    ));

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ລາຍງານຄະແນນຮ້ານສ້ອມແປງ',
          style: TextStyle(
            fontFamily: 'phetsarath_ot',
          ),
        ),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Obx(() {
        if (_repairshopScoreController.repairScoreData.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/empty-box.png',
                  width: 200,
                  fit: BoxFit.cover,
                ),
                const Text('ຍັງບໍ່ມີຂໍ້ມູນລາຍງານນີ້',
                    style: TextStyle(fontSize: 14)),
              ],
            ),
          );
        } else {
          List<Map<String, dynamic>> filteredRows = getFilteredRows();
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // SizedBox(
                      //   height: 50,
                      //   width: 100,
                      //   child: OutlinedButton(
                      //     style: OutlinedButton.styleFrom(
                      //       padding: const EdgeInsets.symmetric(
                      //           vertical: 12, horizontal: 16),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //     ),
                      //     onPressed: (){
                      //       // to pdf
                      //     },
                      //     child: Row(
                      //       children: [
                      //         Image.asset(
                      //           'assets/images/pdf.png',
                      //         ),
                      //         const SizedBox(width: 10),
                      //         const Text(
                      //           'PDF',
                      //           style: TextStyle(color: Colors.black54),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 50,
                        width: 100,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: _printDataTable,
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/printer.png',
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'ພິມ',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // const Divider(height: 3),
                  const DividerWithShadow(),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      sortColumnIndex: _sortColumnName == 'shop_id'
                          ? 0
                          : _sortColumnName == 'shop_name'
                              ? 1
                              : 2,
                      sortAscending: _sortAscending,
                      columns: [
                        DataColumn(
                          label: const Text('ລະຫັດ'),
                          onSort: (columnIndex, ascending) {
                            setState(() {
                              _sortColumnName = 'shop_id';
                              _sortAscending = ascending;
                            });
                          },
                        ),
                        DataColumn(
                          label: const Text('ຊື່ຮ້ານສ້ອມແປງ'),
                          onSort: (columnIndex, ascending) {
                            setState(() {
                              _sortColumnName = 'shop_name';
                              _sortAscending = ascending;
                            });
                          },
                        ),
                        DataColumn(
                          label: const Text('ຄະແນນເກດຣ'),
                          onSort: (columnIndex, ascending) {
                            setState(() {
                              _sortColumnName = 'average';
                              _sortAscending = ascending;
                            });
                          },
                        ),
                      ],
                      rows: filteredRows.map((row) {
                        return DataRow(
                          cells: [
                            DataCell(Text(row['shop_id'].toString())),
                            DataCell(Text(row['shop_name'].toString())),
                            DataCell(Text(row['average'].toString())),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}

class DividerWithShadow extends StatelessWidget {
  const DividerWithShadow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1.5),
          ),
        ],
      ),
      child: const Divider(
        height: 3,
        color: Colors.grey, // Divider c
      ),
    );
  }
}
