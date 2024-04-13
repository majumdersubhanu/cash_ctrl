import 'package:auto_route/auto_route.dart';
import 'package:cash_ctrl/application/analytics/analytics_provider.dart';
import 'package:cash_ctrl/application/transaction/transaction_provider.dart';
import 'package:cash_ctrl/core/enums.dart';
import 'package:cash_ctrl/core/extensions.dart';
import 'package:cash_ctrl/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            textBaseline: TextBaseline.ideographic,
            children: [
              DashboardAnalytics(),
              Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                      onPressed: () => context.pushRoute(BorrowMoneyRoute()),
                      child: Text("Lend Money")),
                  OutlinedButton(
                      onPressed: () => context.pushRoute(BorrowMoneyRoute()),
                      child: Text("Borrow Money")),
                ],
              ),
              Gap(20),
              RecentTransactions(),
            ],
          ),
        ),
      ),
    );
  }
}

class RecentTransactions extends StatefulWidget {
  const RecentTransactions({
    super.key,
  });

  @override
  State<RecentTransactions> createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<TransactionProvider>().fetchTransactions(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Transactions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () {},
              child: Text('View more'.toTitleCase),
            ),
          ],
        ),
        const Gap(20),
        Consumer<TransactionProvider>(
          builder: (BuildContext context, transactionState, Widget? child) =>
              ListView.separated(
            itemCount: (transactionState.transactions?.length ?? 0) > 5
                ? 5
                : transactionState.transactions?.length ?? 0,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              String? paymentMode =
                  transactionState.transactions?[index].paymentType;

              String? paymentCategory =
                  transactionState.transactions?[index].category;

              // print(paymentCategory);

              IconData? paymentIconData = getPaymentModeIcon(
                  getPaymentModeEnumValue(paymentMode?.toTitleCase ?? ''));
              IconData? categoryIconData = getCategoryIcon(
                  getExpenseCategoryEnumValue(
                      paymentCategory?.toTitleCase ?? ''));

              return GestureDetector(
                onTap: () => context.showWorkInProgress(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textBaseline: TextBaseline.ideographic,
                    children: [
                      Icon(
                        categoryIconData,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactionState
                                    .transactions?[index].name?.toTitleCase ??
                                'N/A',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w900),
                          ),
                          Text(Jiffy.parseFromDateTime(DateTime.parse(
                                  transactionState.transactions?[index].date ??
                                      'N/A'))
                              .yMMMdjm)
                        ],
                      ),
                      Text(
                        transactionState.transactions?[index].amount ?? 'N/A',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontWeight: FontWeight.w900,
                                color: transactionState.transactions?[index]
                                            .transactionType ==
                                        'income'
                                    ? Colors.green
                                    : Colors.red),
                      ),
                      Icon(
                        paymentIconData,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Gap(10),
          ),
        ),
      ],
    );
  }
}

class DashboardAnalyticsContainer extends StatelessWidget {
  final Widget info;
  final String label;

  const DashboardAnalyticsContainer({
    super.key,
    required this.info,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Spacer(),
          info,
          const Spacer(),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

class DashboardAnalyticsData {
  DashboardAnalyticsData(this.label, this.isLoading, [this.value]);

  final String label;
  final LoadingStatus isLoading;
  final String? value;
}

class DashboardAnalytics extends StatefulWidget {
  const DashboardAnalytics({super.key});

  @override
  State<DashboardAnalytics> createState() => _DashboardAnalyticsState();
}

class _DashboardAnalyticsState extends State<DashboardAnalytics> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AnalyticsProvider>().getAnalytics(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AnalyticsProvider>(
      builder: (BuildContext context, analyticsState, _) => GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          DashboardAnalyticsData(
            'Total expenditure for ${Jiffy.now().MMMM}',
            analyticsState.loadingStatus,
            analyticsState.loadingStatus == LoadingStatus.loaded
                ? analyticsState.totalExpenseCurrentMonth?.toStringAsFixed(2) ??
                    "N/A"
                : null,
          ),
          DashboardAnalyticsData(
            'Total income for ${Jiffy.now().MMMM}',
            analyticsState.loadingStatus,
            analyticsState.loadingStatus == LoadingStatus.loaded
                ? analyticsState.totalIncomeCurrentMonth?.toStringAsFixed(2) ??
                    "N/A"
                : null,
          ),
          DashboardAnalyticsData(
            'Total expenditure for ${Jiffy.now().year}',
            analyticsState.loadingStatus,
            analyticsState.loadingStatus == LoadingStatus.loaded
                ? analyticsState.totalExpenseCurrentYear?.toStringAsFixed(2) ??
                    "N/A"
                : null,
          ),
          DashboardAnalyticsData(
            'Total expenditure of all time',
            analyticsState.loadingStatus,
            analyticsState.loadingStatus == LoadingStatus.loaded
                ? analyticsState.totalExpenseAllTime?.toStringAsFixed(2) ??
                    "N/A"
                : null,
          ),
        ].map((data) {
          return DashboardAnalyticsContainer(
            label: data.label,
            info: data.isLoading == LoadingStatus.loading || data.value == null
                ? const CircularProgressIndicator()
                : Text(
                    data.value!,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
          );
        }).toList(),
      ),
    );
  }
}
