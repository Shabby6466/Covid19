import 'package:covid_tracker/navigation/NavigationServices.dart';
import 'package:covid_tracker/navigation/navigation_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DetailScreen extends StatelessWidget {
  final NavigationData data;
  const DetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final GoRouterState state = GoRouterState.of(context);
    final NavigationService _navigationservice = NavigationServiceImpl();
    print(data);

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              _navigationservice.goBack(context);
            },
            child: const Icon(Icons.arrow_back)),
        title: Text(data.name ?? "Details Screen"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(data.image ?? "no image"),
            ),
            SizedBox(
              height: 70.h,
            ),
            ReuseableRow(
                title: "Updated Data", value: data.updated ?? "Loading"),
            ReuseableRow(title: "Cases", value: data.cases ?? "Loading"),
            ReuseableRow(title: "Deaths", value: data.deaths ?? "Loading"),
            ReuseableRow(
                title: "Recovered", value: data.recovered ?? 'Loading'),
            ReuseableRow(title: "Active", value: data.active ?? "Loading"),
            ReuseableRow(title: "critical", value: data.critical ?? "Loading"),
          ],
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
