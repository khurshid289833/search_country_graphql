import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:search_country_graphql/controller/search_controller.dart';
import 'country_details_view.dart';

class CountryListingView extends StatelessWidget {
  CountryListingView({Key? key}) : super(key: key);
  final SearchController _searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      builder: ((controller) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              elevation: 0.3,
              title: Container(
                height: 40,
                decoration: const BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.white30,
                      blurRadius: 15.0,
                      offset: Offset(0.0, 0.0),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: TextField(
                  controller: _searchController.searchController,
                  keyboardType: TextInputType.text,
                  onChanged: (value){
                    _searchController.searchCountryByCode();
                  },
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Search country",
                    hintStyle: const TextStyle(color: Colors.black45,fontSize: 16),
                    contentPadding: const EdgeInsets.only(top: 10,left: 16),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Query(
            options: QueryOptions(
              document: gql(_searchController.isSearching?_searchController.searchCountry:_searchController.fetchAll),
            ),
            builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
              if (result.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (result.data == null) {
                return const Center(
                  child: Text("No Data Found !"),
                );
              }
              return _searchController.isSearching?
              result.data!["country"]!=null?
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryDetailsView(
                    name: result.data!["country"]["name"],
                    emoji: result.data!["country"]["emoji"],
                    capital: result.data!["country"]["capital"],
                  )));
                  //--------------OR-----------------------
                  // Get.to(()=>
                  //     CountryDetailsView(
                  //       name: result.data!["country"]["name"],
                  //       emoji: result.data!["country"]["emoji"],
                  //       capital: result.data!["country"]["capital"],
                  //     )
                  // );
                },
                child: ListTile(
                  horizontalTitleGap: 0,
                  dense: true,
                  leading: Text(result.data!["country"]["emoji"]),
                  title: Text(result.data!["country"]["name"]),
                ),
              ):const Center(
                child: Text("Please enter proper country code"),
              ):
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Filter by language",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Switch(
                          value: _searchController.isFiltering,
                          onChanged: (value){
                            if(value){
                              _searchController.showBottomSheet();
                            }else{
                              _searchController.isFiltering = value;
                              _searchController.update();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      itemCount: result.data!["countries"]!=null?result.data!["countries"].length:0,
                      itemBuilder: (BuildContext context, int index) {
                        if(_searchController.isFiltering){
                          return result.data!["countries"][index]["languages"].length>0 && _searchController.language.contains(result.data!["countries"][index]["languages"][0]["name"])?
                            InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryDetailsView(
                                name: result.data!["countries"][index]["name"],
                                emoji: result.data!["countries"][index]["emoji"],
                                capital: result.data!["countries"][index]["capital"],
                              )));
                            },
                            child: ListTile(
                              horizontalTitleGap: 0,
                              dense: true,
                              leading: Text(result.data!["countries"][index]["emoji"]),
                              title: Text(result.data!["countries"][index]["name"]),
                            ),
                          ):const Offstage();
                        }else{
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryDetailsView(
                                name: result.data!["countries"][index]["name"],
                                emoji: result.data!["countries"][index]["emoji"],
                                capital: result.data!["countries"][index]["capital"],
                              )));
                            },
                            child: ListTile(
                              horizontalTitleGap: 0,
                              dense: true,
                              leading: Text(result.data!["countries"][index]["emoji"]),
                              title: Text(result.data!["countries"][index]["name"]),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}

