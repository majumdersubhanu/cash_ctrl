import 'dart:math';

import 'package:fit_sync_plus/presentation/widgets/button_widgets.dart';
import 'package:fit_sync_plus/presentation/widgets/card_widgets.dart';
import 'package:fit_sync_plus/presentation/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<int, String> months = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "Ma",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December",
  };

  Map<String, double> dataMap = {
    "Food": 5,
    "Cabs": 3,
    "Groceries": 2,
    "OTT": 4,
    "Electricity": 4,
    "Rent": 9,
    "Misc": 2,
  };

  final data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MediumSemiBoldHeading(
                label:
                    "Insights for the month of ${months[DateTime.now().month]}"),
            const SizedBox(height: 20),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InsightCard(
                    backgroundColour: Colors.red,
                    label: "Spending",
                    icon: Icons.arrow_downward,
                  ),
                  SizedBox(width: 10),
                  InsightCard(
                    backgroundColour: Colors.green,
                    label: "Income",
                    icon: Icons.arrow_upward,
                  ),
                  SizedBox(width: 10),
                  InsightCard(
                    backgroundColour: Colors.amber,
                    label: "Remaining",
                    icon: Icons.shopping_bag,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            PieChart(
              dataMap: dataMap,
              chartRadius: MediaQuery.of(context).size.width / 3.2,
              chartType: ChartType.ring,
              legendOptions:
                  const LegendOptions(legendPosition: LegendPosition.right),
              chartValuesOptions: const ChartValuesOptions(
                showChartValuesInPercentage: true,
                showChartValues: true,
                showChartValuesOutside: true,
                showChartValueBackground: true,
              ),
              centerText: "Expenses",
            ),
            const SizedBox(height: 40),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MediumSemiBoldHeading(label: "Recent transactions"),
                RegularTextButton(label: "See All")
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  // Generate random data for each item
                  String amount =
                      '₹${(Random().nextDouble() * 50 + 10).toStringAsFixed(2)}';
                  String category = getRandomCategory();

                  return Container(
                    margin: const EdgeInsets.only(bottom: 5.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onInverseSurface,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                      enableFeedback: true,
                      title: Text(amount),
                      subtitle: Text(category),
                      leading: const Icon(Icons.fastfood),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(Jiffy.parseFromDateTime(DateTime.now()).MMMEd),
                          const Icon(Icons.money),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getRandomCategory() {
    List<String> categories = [
      'Food',
      'Groceries',
      'Entertainment',
      'Utilities',
      'Dining',
      'Transportation'
    ];
    return categories[Random().nextInt(categories.length)];
  }
}
