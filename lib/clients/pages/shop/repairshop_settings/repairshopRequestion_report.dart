import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';
import 'package:service_fixing/clients/controllers/report/getRequestRepairController.dart';
import 'package:service_fixing/constants.dart';

class RepairshopRequestReport extends StatefulWidget {
  const RepairshopRequestReport({Key? key}) : super(key: key);

  @override
  State<RepairshopRequestReport> createState() =>
      _RepairshopRequestReportState();
}

class _RepairshopRequestReportState extends State<RepairshopRequestReport> {
  late String _sortColumnName;
  late bool _sortAscending;
  Timer? _timer;
  late TextEditingController _dateRangeController;
  DateTime? _startDate;
  DateTime? _endDate;

  final GetRequestRepairController _getRequestRepairController =
      Get.put(GetRequestRepairController());

  @override
  void initState() {
    super.initState();
    _sortColumnName = 'id';
    _sortAscending = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Timer logic
    });
    _getRequestRepairController.fetchRequestRepairData();
    _startDate = null;
    _endDate = null;
    _dateRangeController = TextEditingController(text: '');
  }

  // start code filter data by date
  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String _formatDateRange(DateTime? startDate, DateTime? endDate) {
    String start = startDate != null ? _formatDate(startDate) : '';
    String end = endDate != null ? _formatDate(endDate) : '';
    return '$start - $end';
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
        _dateRangeController.text = _formatDateRange(_startDate, _endDate);
      });
    }
  }

  List<Map<String, dynamic>> getFilteredRows() {
    if (_startDate == null && _endDate == null) {
      return _getRequestRepairController.requestRepairData;
    } else {
      return _getRequestRepairController.requestRepairData.where((row) {
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
      'ID',
      'sender_name',
      'sender_tel',
      'receiver_name',
      'receiver_tel',
      'message',
      'status',
      'createAt',
      'updateAt'
    ];
    final data = rows.map((row) {
      return [
        row['id'],
        row['sender_name'],
        row['sender_tel'],
        row['receiver_name'],
        row['receiver_tel'],
        row['message'],
        row['status'],
        row['createdAt'],
        row['updatedAt']
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
          'ລາຍງານຮ້ອງຂໍການບໍລິການສ້ອມແປງລົດ',
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
        if (_getRequestRepairController.requestRepairData.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          List<Map<String, dynamic>> filteredRows = getFilteredRows();
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _dateRangeController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'ວັນທີ່ເລີ່ມ - ວັນທີ່ຈົບ',
                            labelStyle: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'phetsarath_ot',
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_month_outlined),
                              onPressed: () => _selectDateRange(context),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 60,
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
                      sortAscending: _sortAscending,
                      columns: [
                        DataColumn(
                          label: const Text('ລະຫັດ'),
                          onSort: (columnIndex, ascending) {
                            setState(() {
                              _sortColumnName = 'id';
                              _sortAscending = ascending;
                            });
                          },
                        ),
                        DataColumn(
                          label: const Text('ຊື່ຜູ້ຮ້ອງຂໍບໍລິການ'),
                          onSort: (columnIndex, ascending) {
                            setState(() {
                              _sortColumnName = 'sender_name';
                              _sortAscending = ascending;
                            });
                          },
                        ),
                        DataColumn(
                          label: const Text('ເບີໂທຜູ້ຮ້ອງຂໍບໍລິການ'),
                          onSort: (columnIndex, ascending) {
                            setState(() {
                              _sortColumnName = 'sender_tel';
                              _sortAscending = ascending;
                            });
                          },
                        ),
                        DataColumn(
                          label: const Text('ຊື່ຜູ້ຮັບຮ້ອງ'),
                          onSort: (columnIndex, ascending) {
                            setState(() {
                              _sortColumnName = 'receiver_name';
                              _sortAscending = ascending;
                            });
                          },
                        ),
                        DataColumn(
                          label: const Text('ເບີໂທຜູ້ຮັບຮ້ອງ'),
                          onSort: (columnIndex, ascending) {
                            setState(() {
                              _sortColumnName = 'receiver_tel';
                              _sortAscending = ascending;
                            });
                          },
                        ),
                        DataColumn(
                          label: const Text('ຂໍ້ຄວາມ'),
                          onSort: (columnIndex, ascending) {
                            setState(() {
                              _sortColumnName = 'message';
                              _sortAscending = ascending;
                            });
                          },
                        ),
                        DataColumn(
                          label: const Text('ສະຖານະ'),
                          onSort: (columnIndex, ascending) {
                            setState(() {
                              _sortColumnName = 'status';
                              _sortAscending = ascending;
                            });
                          },
                        ),
                        DataColumn(
                          label: const Text('createdAt'),
                          onSort: (columnIndex, ascending) {
                            setState(() {
                              _sortColumnName = 'createdAt';
                              _sortAscending = ascending;
                            });
                          },
                        ),
                        DataColumn(
                          label: const Text('updateAt'),
                          onSort: (columnIndex, ascending) {
                            setState(() {
                              _sortColumnName = 'updateAt';
                              _sortAscending = ascending;
                            });
                          },
                        ),
                      ],
                      rows: filteredRows.map((row) {
                        return DataRow(
                          cells: [
                            DataCell(Text(row['id'].toString())),
                            DataCell(Text(row['sender_name'].toString())),
                            DataCell(Text(row['sender_tel'].toString())),
                            DataCell(Text(row['receiver_name'].toString())),
                            DataCell(Text(row['receiver_tel'].toString())),
                            DataCell(Text(row['message'].toString())),
                            DataCell(Text(row['status'].toString())),
                            DataCell(Text(row['createdAt'].toString())),
                            DataCell(Text(row['updatedAt'].toString())),
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
