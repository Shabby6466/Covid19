import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailScreen extends StatelessWidget {
  final String name;
  final String updated, cases, deaths, recovered, active, critical, image;

  const DetailScreen(
      {super.key,
      required this.name,
      required this.updated,
      required this.cases,
      required this.deaths,
      required this.recovered,
      required this.active,
      required this.critical,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(image),
          ),
          SizedBox(height: 70.h,),
          ReuseableRow(title: "Updated Data", value: updated),
          ReuseableRow(title: "Cases", value: cases),
          ReuseableRow(title: "Deaths", value: deaths),
          ReuseableRow(title: "Recovered", value: recovered),
          ReuseableRow(title: "Active", value: active),
          ReuseableRow(title: "critical", value: critical),

        ],
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
