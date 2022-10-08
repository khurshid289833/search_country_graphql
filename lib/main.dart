import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:search_country_graphql/views/country_listing_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink("https://countries.trevorblades.com/graphql");
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink, cache: GraphQLCache(),
      ),
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: GraphQLProvider(
        client: client,
        child: CountryListingView(),
      ),
    );
  }
}

