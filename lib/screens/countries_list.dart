import 'package:covid_tracker/utils/injection.dart';
import 'package:covid_tracker/navigation/NavigationRoutes.dart';
import 'package:covid_tracker/navigation/NavigationServices.dart';
import 'package:covid_tracker/navigation/navigation_data.dart';
import 'package:get_it/get_it.dart';
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
  final TextEditingController searchController = TextEditingController();
  final StatesServices _statesServices = GetIt.instance<StatesServices>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => locator<NavigationService>()
                .navigateToNamed(context, Navigationroutes.worldStates),
            child: Icon(Icons.arrow_back_ios)),
      ),
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
                child: FutureBuilder<List<dynamic>>(
                  future: _statesServices.Countrieslistrecord(),
                  builder: (context, snapshot) {
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
                        child: Text("Error: ${snapshot.error}"),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("No data available"),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data![index];
                          final String title = data['country'];

                          if (searchController.text.isEmpty ||
                              title.toLowerCase().contains(
                                  searchController.text.toLowerCase())) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0).r,
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      final detailsData = NavigationData(
                                        name: data['country'].toString(),
                                        updated: data['updated'].toString(),
                                        cases: data['cases'].toString(),
                                        deaths: data['deaths'].toString(),
                                        recovered: data['recovered'].toString(),
                                        active: data['active'].toString(),
                                        critical: data['critical'].toString(),
                                        image: data['countryInfo']['flag'],
                                      );
                                      locator<NavigationService>().navigateTo(
                                          context,
                                          Navigationroutes.detailScreen,
                                          extra: detailsData);
                                    },
                                    child: ListTile(
                                      leading: Image(
                                        height: 80.h,
                                        width: 80.w,
                                        image: NetworkImage(
                                            data['countryInfo']['flag']),
                                      ),
                                      title: Text(data['country']),
                                      subtitle: Text(data['cases'].toString()),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
