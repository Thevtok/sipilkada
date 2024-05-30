import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/statistik/app_colors.dart';

import '../theme.dart';

class BarChartSample7 extends StatefulWidget {
  final List dataList;
  final List<double> data;
  const BarChartSample7(
      {super.key, required this.dataList, required this.data});

  @override
  State<BarChartSample7> createState() => _BarChartSample7State();
}

class _BarChartSample7State extends State<BarChartSample7> {
  double adjustMaxY(List<double> data) {
    final maxValue = data.reduce((curr, next) => curr > next ? curr : next);
    final adjustedMaxValue = maxValue * 1.2; // Contoh penyesuaian sebesar 20%
    return adjustedMaxValue;
  }

  double adjustMinY(List<double> data) {
    final minValue = data.reduce((curr, next) => curr < next ? curr : next);
    final adjustedMinValue = minValue * 0.8; // Contoh penyesuaian sebesar 20%
    return adjustedMinValue;
  }

  BarChartGroupData generateBarGroup(
      int x, Color color, double value, String nama) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 20,
        ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
  }

  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.gray100,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Padding(
        padding: const EdgeInsets.only(left: 30,right: 30),
        child: AspectRatio(
          aspectRatio: 1.2,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceBetween,
              borderData: FlBorderData(
                show: true,
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: AppColors.borderColor.withOpacity(0.2),
                  ),
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                leftTitles: AxisTitles(
                  drawBelowEverything: true,
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 70,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: AppTheme.primary,
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 60,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: IconWidget(
                          nama: widget.dataList[index].nama,
                          color: widget.dataList[index].color,
                          isSelected: touchedGroupIndex == index,
                        ),
                      );
                    },
                  ),
                ),
                rightTitles: const AxisTitles(),
                topTitles: const AxisTitles(),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: AppColors.contentColorRed.withOpacity(0.2),
                  strokeWidth: 1,
                ),
              ),
              barGroups: widget.dataList.asMap().entries.map((e) {
                final index = e.key;
                final data = e.value;
                return generateBarGroup(
                    index, data.color, data.value, data.nama);
              }).toList(),
              maxY: adjustMaxY(widget.data),
              barTouchData: BarTouchData(
                enabled: true,
                handleBuiltInTouches: false,
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (group) => Colors.transparent,
                  tooltipMargin: 0,
                  getTooltipItem: (
                    BarChartGroupData group,
                    int groupIndex,
                    BarChartRodData rod,
                    int rodIndex,
                  ) {
                    return BarTooltipItem(
                      rod.toY.toString(),
                      TextStyle(
                        fontWeight: FontWeight.bold,
                        color: rod.color,
                        fontSize: 18,
                        shadows: const [
                          Shadow(
                            color: Colors.black26,
                            blurRadius: 12,
                          )
                        ],
                      ),
                    );
                  },
                ),
                touchCallback: (event, response) {
                  if (event.isInterestedForInteractions &&
                      response != null &&
                      response.spot != null) {
                    setState(() {
                      touchedGroupIndex = response.spot!.touchedBarGroupIndex;
                    });
                  } else {
                    setState(() {
                      touchedGroupIndex = -1;
                    });
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BarData {
  const BarData(
    this.color,
    this.value,
    this.nama,
  );
  final Color color;
  final double value;
  final String nama;
}

class IconWidget extends ImplicitlyAnimatedWidget {
  const IconWidget({
    super.key,
    required this.color,
    required this.isSelected,
    required this.nama,
  }) : super(duration: const Duration(milliseconds: 300));
  final Color color;
  final bool isSelected;
  final String nama;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _IconWidgetState();
}

class _IconWidgetState extends AnimatedWidgetBaseState<IconWidget> {
  Tween<double>? _rotationTween;

  @override
  Widget build(BuildContext context) {
    final rotation = math.pi * 4 * _rotationTween!.evaluate(animation);
    final scale = 1 + _rotationTween!.evaluate(animation) * 0.5;
    return Transform(
      transform: Matrix4.rotationZ(rotation).scaled(scale, scale),
      origin: const Offset(14, 14),
      child: Column(
        children: [
          Icon(
            widget.isSelected ? Icons.face_retouching_natural : Icons.face,
            color: widget.color,
            size: 28,
          ),
          Text(
            widget.nama,
            style: const TextStyle(color: AppTheme.nearlyBlack),
          )
        ],
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _rotationTween = visitor(
      _rotationTween,
      widget.isSelected ? 1.0 : 0.0,
      (dynamic value) => Tween<double>(
        begin: value as double,
        end: widget.isSelected ? 1.0 : 0.0,
      ),
    ) as Tween<double>?;
  }
}
