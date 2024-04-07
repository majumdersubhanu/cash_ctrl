import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jiffy/jiffy.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../core/extensions.dart';
import '../../data/models/expense_model.dart';
import 'lending_controller.dart';

class LendingView extends GetView<LendingController> {
  const LendingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          controller: controller.scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            verticalDirection: VerticalDirection.down,
            textDirection: TextDirection.ltr,
            textBaseline: TextBaseline.ideographic,
            children: [
              Text(
                'Transactions',
                style: Get.theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Gap(40),
              Text(
                'Hey 👋, here\'s your latest stats',
                style: Get.theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(20),
              GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          color: Get.theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Spacer(),
                            Text(
                              '350',
                              style: Get.theme.textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              e,
                              style: Get.theme.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
              const Gap(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Time Expenses',
                    style: Get.theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                      onPressed: () => Get.bottomSheet(
                          backgroundColor: Get.theme.colorScheme.background,
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: const Text('Export to Excel'),
                                leading: const Icon(Ionicons.easel_outline),
                                onTap: () {
                                  context.showWIP();
                                  Get.back();
                                },
                              ),
                              ListTile(
                                title: const Text('Export as PDF'),
                                leading: const Icon(Ionicons.document_outline),
                                onTap: () {
                                  context.showWIP();
                                  Get.back();
                                },
                              ),
                            ],
                          )),
                      child: const Text('Export Data')),
                ],
              ),
              const Gap(20),
              Obx(
                () => RefreshIndicator(
                  onRefresh: () => controller.subscribeToExpenseStreams(),
                  child: SfDataGrid(
                    allowFiltering: true,
                    source: controller.expenseDataSource.value,
                    gridLinesVisibility: GridLinesVisibility.horizontal,
                    columnWidthMode: ColumnWidthMode.lastColumnFill,
                    selectionMode: SelectionMode.multiple,
                    headerGridLinesVisibility: GridLinesVisibility.horizontal,
                    showHorizontalScrollbar: true,
                    allowSorting: true,
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpenseDataSource extends DataGridSource {
  ExpenseDataSource({required List<Expense> expenses}) {
    dataGridRows = expenses
        .map<DataGridRow>(
          (expense) => DataGridRow(
            cells: [
              DataGridCell(
                  columnName: 'Title',
                  value: expense.transaction?.title ?? 'N/A'),
              DataGridCell<double>(
                  columnName: 'Amount',
                  value: expense.transaction?.amount ?? 0),
              DataGridCell(
                  columnName: 'Description',
                  value: expense.transaction?.description ?? 'N/A'),
              DataGridCell(
                  columnName: 'Category',
                  value:
                      expense.transaction?.paymentCategory ?? 'Miscellaneous'),
              DataGridCell(
                  columnName: 'Type',
                  value: expense.transaction?.paymentType ?? 'Cash'),
              DataGridCell(
                columnName: 'Time',
                value:
                    Jiffy.parseFromDateTime(expense.createdAt!.toDate()).MMMEd,
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
