import 'package:covid_tracker/utils/colors.dart';
import 'package:covid_tracker/utils/injection.dart';
import 'package:covid_tracker/model/WorldStatesApi.dart';
import 'package:covid_tracker/model/states_services.dart';
import 'package:covid_tracker/navigation/NavigationRoutes.dart';
import 'package:covid_tracker/navigation/NavigationServices.dart';
import 'package:covid_tracker/utils/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  Ticker? _ticker;
  late final AnimationController _controller;
  final StatesServices _statesServices = GetIt.instance<StatesServices>();

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((Duration elapsed) {
      // Your ticker callback code here
    });
    _ticker?.start();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _ticker?.dispose();
    _controller.dispose();
    super.dispose();
  }

  final mycolorList = <Color>[
    MyColors.blue,
    MyColors.green,
    MyColors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(30.r),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Align(
                    alignment: AlignmentDirectional.topStart,
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
                      },
                      child: Container(
                        height: 40,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(16)),
                        child: Center(
                          child: Icon(
                              color: Colors.white,
                              size: 25,
                              Icons.light_mode_rounded),
                        ),
                      ),
                    )),
                FutureBuilder(
                    future: _statesServices.worldStatesRecord(),
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
                              locator<NavigationService>().navigateToNamed(
                                  context, Navigationroutes.countriesList);
                              // navigationService.navigateToNamed(
                              //     context, Navigationroutes.countriesList);
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
