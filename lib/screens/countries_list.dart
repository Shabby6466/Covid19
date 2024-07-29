import 'package:covid_tracker/screens/detail_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:covid_tracker/model/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0).r,
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search with Country name",
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                future: statesServices.Countrieslistrecord(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.black54,
                          highlightColor: Colors.black12,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  height: 50.h,
                                  width: 50.w,
                                  color: Colors.grey,
                                ),
                                title: Container(
                                  height: 10.h,
                                  width: 89.w,
                                  color: Colors.grey,
                                ),
                                subtitle: Container(
                                  height: 20.h,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("ErrorL ${snapshot.error}"),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No data available"),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String title = snapshot.data![index]['country'];

                        if (searchController.text.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0).r,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                  name: snapshot.data![index]
                                                          ['country']
                                                      .toString(),
                                                  updated: snapshot.data![index]
                                                          ['updated']
                                                      .toString(),
                                                  cases: snapshot.data![index]
                                                          ['cases']
                                                      .toString(),
                                                  deaths: snapshot.data![index]
                                                          ['deaths']
                                                      .toString(),
                                                  recovered: snapshot
                                                      .data![index]['recovered']
                                                      .toString(),
                                                  active: snapshot.data![index]
                                                          ['active']
                                                      .toString(),
                                                  critical: snapshot
                                                      .data![index]['critical']
                                                      .toString(),
                                                  image: snapshot.data![index]
                                                          ['countryInfo']
                                                          ['flag']
                                                      .toString(),
                                                )));
                                  },
                                  child: ListTile(
                                    leading: Image(
                                        height: 80.h,
                                        width: 80.w,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag'])),
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (title
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0).r,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                  name: snapshot.data![index]
                                                          ['country']
                                                      .toString(),
                                                  updated: snapshot.data![index]
                                                          ['updated']
                                                      .toString(),
                                                  cases: snapshot.data![index]
                                                          ['cases']
                                                      .toString(),
                                                  deaths: snapshot.data![index]
                                                          ['deaths']
                                                      .toString(),
                                                  recovered: snapshot
                                                      .data![index]['recovered']
                                                      .toString(),
                                                  active: snapshot.data![index]
                                                          ['active']
                                                      .toString(),
                                                  critical: snapshot
                                                      .data![index]['critical']
                                                      .toString(),
                                                  image: snapshot.data![index]
                                                          ['countryInfo']
                                                          ['flag']
                                                      .toString(),
                                                )));
                                  },
                                  child: ListTile(
                                    leading: Image(
                                        height: 80.h,
                                        width: 80.w,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag'])),
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
