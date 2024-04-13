import 'package:auto_route/auto_route.dart';
import 'package:cash_ctrl/application/analytics/analytics_provider.dart';
import 'package:cash_ctrl/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

@RoutePage()
class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AnalyticsProvider>().getAnalytics(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AnalyticsProvider>(
          builder: (BuildContext context, AnalyticsProvider analyticsState,
                  Widget? child) =>
              SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            primary: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SfCircularChart(
                  title: ChartTitle(
                    text: "This Month's Expenditure Analytics",
                    textStyle: context.textTheme.titleMedium,
                  ),
                  selectionGesture: ActivationMode.singleTap,
                  legend: Legend(
                    shouldAlwaysShowScrollbar: true,
                    isVisible: true,
                    alignment: ChartAlignment.center,
                    overflowMode: LegendItemOverflowMode.wrap,
                    isResponsive: true,
                    position: LegendPosition.auto,
                    orientation: LegendItemOrientation.vertical,
                    title: LegendTitle(
                      text: 'Categories',
                      textStyle: context.textTheme.titleMedium,
                    ),
                    toggleSeriesVisibility: true,
                  ),
                  series: <CircularSeries>[
                    DoughnutSeries<ExpenditureAnalyticsData, String>(
                      dataSource: analyticsState
                          .categoryWiseExpenseCurrentMonth?.entries
                          .map((e) => ExpenditureAnalyticsData(e.key, e.value))
                          .toList(),
                      xValueMapper: (ExpenditureAnalyticsData data, _) =>
                          data.label,
                      yValueMapper: (ExpenditureAnalyticsData data, _) =>
                          data.value,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        useSeriesColor: true,
                        connectorLineSettings:
                            ConnectorLineSettings(type: ConnectorType.line),
                        labelAlignment: ChartDataLabelAlignment.middle,
                        labelIntersectAction: LabelIntersectAction.shift,
                      ),
                      // legendIconType: LegendIconType.diamond,
                      dataLabelMapper: (data, index) => "${data.value}",
                      groupMode: CircularChartGroupMode.value,
                      // cornerStyle: CornerStyle.bothCurve,
                      explodeIndex: 0,
                      explodeGesture: ActivationMode.singleTap,
                      explode: true,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SfCartesianChart(
                  primaryXAxis:
                      const CategoryAxis(title: AxisTitle(text: 'Month')),
                  title: ChartTitle(
                    text: "Yearly Expenditure Overview",
                    textStyle: context.textTheme.titleMedium,
                  ),
                  legend: const Legend(
                    toggleSeriesVisibility: true,
                    isResponsive: true,
                    isVisible: true,
                  ),
                  enableAxisAnimation: true,
                  primaryYAxis: const NumericAxis(
                    title: AxisTitle(text: 'Expenditure in thousands'),
                  ),
                  series: <CartesianSeries>[
                    ColumnSeries<ExpenditureAnalyticsData, String>(
                      dataSource: analyticsState.monthWiseExpenseCurrentYear
                          ?.asMap()
                          .entries
                          .map((e) => ExpenditureAnalyticsData(
                              "Jan ${e.key}", (e.value ?? 0) / 1000))
                          .toList(),
                      xValueMapper: (ExpenditureAnalyticsData data, _) =>
                          data.label,
                      yValueMapper: (ExpenditureAnalyticsData data, _) =>
                          data.value,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                      dataLabelMapper: (data, index) =>
                          "${data.value.toStringAsPrecision(3)} k",
                      enableTooltip: true,
                      legendItemText: 'Discrete',
                    ),
                    FastLineSeries<ExpenditureAnalyticsData, String>(
                      dataSource: analyticsState.monthWiseExpenseCurrentYear
                          ?.asMap()
                          .entries
                          .map((e) => ExpenditureAnalyticsData(
                              "Jan ${e.key}",
                              double.parse(
                                      e.value?.toStringAsPrecision(3) ?? "0") /
                                  1000))
                          .toList(),
                      xValueMapper: (ExpenditureAnalyticsData data, _) =>
                          data.label,
                      yValueMapper: (ExpenditureAnalyticsData data, _) =>
                          data.value,
                      enableTooltip: true,
                      legendItemText: 'Trend',
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExpenditureAnalyticsData {
  ExpenditureAnalyticsData(this.label, this.value);

  final String label;
  final double value;
}
