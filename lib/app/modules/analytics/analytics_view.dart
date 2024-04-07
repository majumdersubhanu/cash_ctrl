import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'analytics_controller.dart';

class AnalyticsView extends GetView<AnalyticsController> {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          primary: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Analytics',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              Obx(
                () => SfCircularChart(
                  title: ChartTitle(
                    text: "This Month's Expenditure Analytics",
                    textStyle: Get.theme.textTheme.titleMedium,
                  ),
                  selectionGesture: ActivationMode.singleTap,
                  legend: Legend(
                    shouldAlwaysShowScrollbar: true,
                    isVisible: true,
                    alignment: ChartAlignment.center,
                    overflowMode: LegendItemOverflowMode.wrap,
                    isResponsive: true,
                    position: LegendPosition.right,
                    orientation: LegendItemOrientation.vertical,
                    title: LegendTitle(
                      text: 'Categories',
                      textStyle: Get.theme.textTheme.titleMedium,
                    ),
                    toggleSeriesVisibility: true,
                  ),
                  series: <CircularSeries>[
                    DoughnutSeries<ExpenditureAnalyticsData, String>(
                      dataSource: controller.monthlyAnalyticsData.value,
                      xValueMapper: (ExpenditureAnalyticsData data, _) =>
                          data.label,
                      yValueMapper: (ExpenditureAnalyticsData data, _) =>
                          data.value,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        useSeriesColor: true,
                        overflowMode: OverflowMode.shift,
                        alignment: ChartAlignment.center,
                        connectorLineSettings:
                            ConnectorLineSettings(type: ConnectorType.line),
                        labelAlignment: ChartDataLabelAlignment.middle,
                        labelIntersectAction: LabelIntersectAction.shift,
                      ),
                      legendIconType: LegendIconType.diamond,
                      dataLabelMapper: (data, index) => "${data.value}%",
                      // explode: controller.monthlyAnalyticsData.length >= 2,
                      // enableTooltip: true,
                      // explodeIndex: 0,
                      // explodeGesture: ActivationMode.singleTap,
                      groupMode: CircularChartGroupMode.value,
                      cornerStyle: CornerStyle.bothFlat,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Yearly Expenditure Analytics Chart
              Obx(
                () => SfCartesianChart(
                  primaryXAxis:
                      const CategoryAxis(title: AxisTitle(text: 'Month')),
                  title: ChartTitle(
                    text: "Yearly Expenditure Overview",
                    textStyle: Get.theme.textTheme.titleMedium,
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
                      dataSource: controller.yearlyAnalyticsData.value,
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
                      dataSource: controller.yearlyAnalyticsData.value,
                      xValueMapper: (ExpenditureAnalyticsData data, _) =>
                          data.label,
                      yValueMapper: (ExpenditureAnalyticsData data, _) =>
                          data.value,
                      enableTooltip: true,
                      legendItemText: 'Trend',
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

class ExpenditureAnalyticsData {
  ExpenditureAnalyticsData(this.label, this.value);

  final String label;
  final double value;
}
