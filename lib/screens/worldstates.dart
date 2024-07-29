import 'package:covid_tracker/colors.dart';
import 'package:covid_tracker/model/WorldStatesApi.dart';
import 'package:covid_tracker/model/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final mycolorList = <Color>[
    MyColors.blue,
    MyColors.green,
    MyColors.red,
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(30.r),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                FutureBuilder(
                    future: statesServices.worldStatesRecord(),
                    builder: (context, AsyncSnapshot<WorldStatesApi> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: SpinKitFadingCircle(
                            color: Colors.black,
                            size: 50.0.sp,
                            controller: _controller,
                          ),
                        );
                      } else {
                        return Column(children: [
                          PieChart(
                            dataMap: {
                              "Total":
                                  double.parse(snapshot.data!.cases.toString()),
                              "Recovered": double.parse(
                                  snapshot.data!.recovered.toString()),
                              "Deaths": double.parse(
                                  snapshot.data!.deaths.toString()),
                            },
                            chartType: ChartType.ring,
                            colorList: const [
                              MyColors.blue,
                              MyColors.green,
                              MyColors.red,
                            ],
                            chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true),
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left),
                            animationDuration:
                                const Duration(milliseconds: 1200),
                          ),
                          SizedBox(
                            height: 60.h,
                          ),
                          Card(
                            child: Column(
                              children: [
                                ReuseableRow(
                                    title: "Total",
                                    value: double.parse(
                                            snapshot.data!.cases.toString())
                                        .toString()),
                                ReuseableRow(
                                    title: "Recovered",
                                    value: double.parse(
                                            snapshot.data!.recovered.toString())
                                        .toString()),
                                ReuseableRow(
                                    title: "Death",
                                    value: double.parse(
                                            snapshot.data!.deaths.toString())
                                        .toString()),
                                ReuseableRow(
                                    title: "Active",
                                    value: double.parse(
                                            snapshot.data!.active.toString())
                                        .toString()),
                                ReuseableRow(
                                    title: "Critical",
                                    value: double.parse(
                                            snapshot.data!.critical.toString())
                                        .toString()),
                                ReuseableRow(
                                    title: "Today Cases",
                                    value: double.parse(snapshot
                                            .data!.todayCases
                                            .toString())
                                        .toString()),
                                ReuseableRow(
                                    title: "Today Deaths",
                                    value: double.parse(snapshot
                                            .data!.todayDeaths
                                            .toString())
                                        .toString()),
                                ReuseableRow(
                                    title: "Today Recovered",
                                    value: double.parse(snapshot
                                            .data!.todayRecovered
                                            .toString())
                                        .toString()),
                              ],
                            ),
                          ),
                          SizedBox(height: 30.h),
                          GestureDetector(
                            onTap: () {
                              context.pushNamed('countries');
                            },
                            child: Container(
                              height: 65.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22.r),
                                color: MyColors.green.withOpacity(0.9),
                              ),
                              child: Center(
                                child: Text(
                                  "Track Countries",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                          )
                        ]);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  final String title, value;

  const ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0).r,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.labelLarge,
        )
      ]),
    );
  }
}
