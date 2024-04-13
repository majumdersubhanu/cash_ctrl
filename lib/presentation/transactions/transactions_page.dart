import 'package:auto_route/auto_route.dart';
import 'package:cash_ctrl/application/transaction/transaction_provider.dart';
import 'package:cash_ctrl/core/extensions.dart';
import 'package:cash_ctrl/domain/transaction/entity/transaction.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

@RoutePage()
class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            verticalDirection: VerticalDirection.down,
            textDirection: TextDirection.ltr,
            textBaseline: TextBaseline.ideographic,
            children: [
              Consumer(
                builder:
                    (BuildContext context, transactionsStatus, Widget? child) {
                  return GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      'Total money you\'ve lent',
                      'Total money you\'ve borrowed'
                    ]
                        .map(
                          (e) => Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const Spacer(),
                                Text(
                                  '350',
                                  style: context.textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 30,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  e,
                                  style: context.textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
              const Gap(40),
              Consumer<TransactionProvider>(
                builder: (BuildContext context, TransactionProvider value,
                    Widget? child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'All Time Transactions',
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                          onPressed: () => _showExportOptions,
                          child: const Text('Export Data')),
                    ],
                  );
                },
              ),
              const Gap(20),
              Consumer<TransactionProvider>(
                builder: (BuildContext context,
                    TransactionProvider transactionsStatus, Widget? child) {
                  return SfDataGrid(
                    allowFiltering: true,
                    source: TransactionDataSource(
                        transactions: transactionsStatus.transactions ?? []),
                    gridLinesVisibility: GridLinesVisibility.horizontal,
                    columnWidthMode: ColumnWidthMode.lastColumnFill,
                    // selectionMode: SelectionMode.multiple,
                    headerGridLinesVisibility: GridLinesVisibility.horizontal,
                    showHorizontalScrollbar: true,
                    allowSorting: true,
                    shrinkWrapRows: true,
                    shrinkWrapColumns: false,
                    isScrollbarAlwaysShown: true,
                    columns: [
                      GridColumn(
                        columnName: 'Title',
                        label: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.centerRight,
                          child: const Text(
                            'Title',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        allowFiltering: false,
                        allowSorting: false,
                      ),
                      GridColumn(
                          columnName: 'Amount',
                          allowSorting: true,
                          allowFiltering: false,
                          label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Amount',
                                overflow: TextOverflow.ellipsis,
                              ))),
                      GridColumn(
                          allowFiltering: false,
                          allowSorting: false,
                          columnName: 'Description',
                          label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Description',
                                overflow: TextOverflow.ellipsis,
                              ))),
                      GridColumn(
                          allowSorting: false,
                          columnName: 'Category',
                          label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.centerRight,
                              child: const Text(
                                'Category',
                                overflow: TextOverflow.ellipsis,
                              ))),
                      GridColumn(
                          allowSorting: false,
                          columnName: 'Type',
                          label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.centerRight,
                              child: const Text(
                                'Type',
                                overflow: TextOverflow.ellipsis,
                              ))),
                      GridColumn(
                          columnWidthMode: ColumnWidthMode.fitByColumnName,
                          columnName: 'Time',
                          label: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.centerRight,
                              child: const Text(
                                'Date',
                                overflow: TextOverflow.ellipsis,
                              ))),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showExportOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.background,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                title: const Text('Export to Excel'),
                leading: const Icon(Ionicons.easel_outline),
                onTap: () {
                  // Implementation for exporting to Excel
                  // Placeholder function call:
                  // showWorkInProgress();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Export as PDF'),
                leading: const Icon(Ionicons.document_outline),
                onTap: () {
                  // Implementation for exporting to PDF
                  // Placeholder function call:
                  // showWorkInProgress();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class TransactionDataSource extends DataGridSource {
  TransactionDataSource({required List<Transaction> transactions}) {
    dataGridRows = transactions
        .map<DataGridRow>(
          (transaction) => DataGridRow(
            cells: [
              DataGridCell(
                  columnName: 'Title', value: transaction.name ?? 'N/A'),
              DataGridCell<double>(
                  columnName: 'Amount',
                  value: double.tryParse(transaction.amount ?? "0")),
              DataGridCell(
                  columnName: 'Description',
                  value: transaction.description ?? 'N/A'),
              DataGridCell(
                  columnName: 'Category',
                  value: transaction.category ?? 'Miscellaneous'),
              DataGridCell(
                  columnName: 'Type', value: transaction.paymentType ?? 'Cash'),
              DataGridCell(
                columnName: 'Time',
                value:
                    Jiffy.parseFromDateTime(DateTime.parse(transaction.date!))
                        .MMMEd,
              ),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: (dataGridCell.columnName == 'Amount')
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}
