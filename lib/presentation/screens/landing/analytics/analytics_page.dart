import 'dart:math';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:fit_sync_plus/presentation/widgets/button_widgets.dart';
import 'package:fit_sync_plus/presentation/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class AnalyticsPage extends StatelessWidget {
  AnalyticsPage({
    super.key,
  });

  final data = [
    34.71,
    20.89,
    63.52,
    11.98,
    87.43,
    50.26,
    96.14,
    32.75,
    54.89,
    17.36,
    69.02,
    41.57,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MediumSemiBoldHeading(
                label: "Analytics for the year ${DateTime.now().year}"),
            const SizedBox(height: 20),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Sparkline(
                data: data,
                pointsMode: PointsMode.all,
                pointSize: 5.0,
                fillMode: FillMode.none,
                kLine: const ['max', 'min'],
                pointColor: Colors.amber,
                enableGridLines: true,
                gridLinelabelPrefix: "₹ ",
              ),
            ),
            const SizedBox(height: 20),
            const MediumSemiBoldHeading(label: "Transactions"),
            const ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                RegularTextButton(label: 'All Time'),
                RegularTextButton(label: 'Last Month'),
                RegularTextButton(label: 'This Year'),
              ],
            ),
            PaginatedDataTableWidget(),
          ],
        ),
      ),
    );
  }
}

class PaginatedDataTableWidget extends StatelessWidget {
  final List<DataRow> _dataRows = generateRandomData(20);

  PaginatedDataTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      columns: const [
        DataColumn(label: Text('Date')),
        DataColumn(label: Text('Amount')),
        DataColumn(label: Text('Category')),
        DataColumn(label: Text('Payment Method')),
      ],
      showFirstLastButtons: true,
      source: _ExpenseDataSource(_dataRows),
      rowsPerPage: 5, // Set the number of rows per page
    );
  }

  static List<DataRow> generateRandomData(int rowCount) {
    List<DataRow> dataRows = [];

    for (int i = 0; i < rowCount; i++) {
      dataRows.add(DataRow(
        cells: [
          DataCell(Text(generateRandomDate())),
          DataCell(Text(generateRandomAmount())),
          DataCell(Text(generateRandomCategory())),
          DataCell(Text(generateRandomPaymentMethod())),
        ],
      ));
    }

    return dataRows;
  }

  static String generateRandomDate() {
    DateTime now = DateTime.now();
    DateTime randomDate = DateTime(
        now.year, now.month - Random().nextInt(12), Random().nextInt(30) + 1);
    return "${randomDate.day}-${randomDate.month}-${randomDate.year}";
  }

  static String generateRandomAmount() {
    double randomAmount = Random().nextDouble() * 1000;
    return '₹${randomAmount.toStringAsFixed(2)}';
  }

  static String generateRandomCategory() {
    List<String> categories = [
      'Groceries',
      'Entertainment',
      'Utilities',
      'Dining',
      'Transportation'
    ];
    return categories[Random().nextInt(categories.length)];
  }

  static String generateRandomPaymentMethod() {
    List<String> paymentMethods = [
      'Cash',
      'Credit Card',
      'Debit Card',
      'Online Transfer'
    ];
    return paymentMethods[Random().nextInt(paymentMethods.length)];
  }
}

class _ExpenseDataSource extends DataTableSource {
  final List<DataRow> _dataRows;

  _ExpenseDataSource(this._dataRows);

  @override
  DataRow getRow(int index) {
    return _dataRows[index];
  }

  @override
  int get rowCount => _dataRows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
