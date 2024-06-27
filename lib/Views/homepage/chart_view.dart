import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart' show NumberFormat, DateFormat;
import '../../Controllers/homepage/line_chart_controller.dart';

class LineChartWidget extends StatefulWidget {
  final LineChartController controller;

  const LineChartWidget({required this.controller});

  @override
  _LineChartWidgetState createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late SfCartesianChart _chart;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _animationController.forward();

    // Call the fetchData method with the appropriate arguments
    widget.controller.fetchData('your_device_id_here', () {
      setState(() {
        // This callback is executed when the data is fetched and needs a widget rebuild.
      });
    });
  }

  void resetZoom() {
    setState(() {
      _chart.zoomPanBehavior.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    _chart = SfCartesianChart(
      backgroundColor: Colors.white,
      plotAreaBackgroundColor: Color(0xFFF7F9FD),

      // Primary X-axis
      primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat('HH:mm'),

      ),

      primaryYAxis: NumericAxis(
        numberFormat: NumberFormat('#'),
        desiredIntervals: 12,
        // Total number of custom values
        interval: 10,
        // Interval between custom values
        minimum: -20,
        // Minimum value on the y-axis
        maximum: 50,
        majorTickLines: MajorTickLines(color: Color(0xFF80DBF0)),
        // Set tickline color to blue
        labelStyle: TextStyle(color: Color(0xFF80DBF0)), // Set label color to blue
      ),

      // Add secondary y-axis for humidity
      axes: <ChartAxis>[
        NumericAxis(
          numberFormat: NumberFormat('#'),
          desiredIntervals: 12,
          interval: 20,
          minimum: 0,
          // Adjust the minimum value based on your data
          maximum: 100,
          // Adjust the maximum value based on your data
          opposedPosition: true,
          // Position the axis on the right side
          majorGridLines: MajorGridLines(width: 0),
          name: 'secondary',
          majorTickLines: MajorTickLines(color: Color(0xFF2874E5)),
          // Set tickline color to blue
          labelStyle: TextStyle(color: Color(0xFF2874E5)), // Set label color to blue
        ),
      ],

      zoomPanBehavior: ZoomPanBehavior(
        maximumZoomLevel: 0.5,
        enablePinching: true,
        enableDoubleTapZooming: true,
        enablePanning: true,
        // Disable the default reset on double-tap behavior
      ),
      legend: Legend(
        isVisible: true,
        position: LegendPosition.bottom,
        orientation: LegendItemOrientation.horizontal,
        overflowMode: LegendItemOverflowMode.scroll,
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <ChartSeries>[
        LineSeries<DataPoint, DateTime>(
          dataSource: List.generate(
              widget.controller.model.tempsData.length,
                  (index) =>
                  DataPoint(widget.controller.model.tempsData[index], widget.controller.model.humiditeData[index])),
          xValueMapper: (DataPoint data, _) => data.x,
          yValueMapper: (DataPoint data, _) => data.y,
          color: Color(0xFF2874E5),
          name: 'Humidity',
          yAxisName: 'secondary',
        ),
        LineSeries<DataPoint, DateTime>(
          dataSource: List.generate(
              widget.controller.model.tempsData.length,
                  (index) =>
                  DataPoint(widget.controller.model.tempsData[index], widget.controller.model.temperatureData[index])),
          xValueMapper: (DataPoint data, _) => data.x,
          yValueMapper: (DataPoint data, _) => data.y,
          color: Color(0xFF80DBF0),
          name: 'Temperature',
        ),
      ],


    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  InkWell(
                    onTap: () {
                      // Perform your refresh logic here
                    },
                    child: Text(
                      'DAY',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        color: Color(0xFF26326A),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      // Perform your refresh logic here
                    },
                    child: Text(
                      'WEEK',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        color: Color(0xFF26326A),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      // Perform your refresh logic here
                    },
                    child: Text(
                      'MONTH',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        color: Color(0xFF26326A),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      // Perform your refresh logic here
                    },
                    child: Text(
                      'YEAR',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        color: Color(0xFF26326A),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(width: 100),
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Color(0xFF26326A),
                    ),
                    onPressed: resetZoom,
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.06),
                    child: Text(
                      "°C",
                      style: TextStyle(color: Color(0xFF80DBF0)),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width *
                                0.07), // 10% of the screen width
                        child: Text(
                          "%",
                          style: TextStyle(color: Color(0xFF2874E5)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Center(
                    child: _chart,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class DataPoint {
  final DateTime x;
  final double y;

  DataPoint(this.x, this.y);
}

