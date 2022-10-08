import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_country_graphql/widget/filter_bottom_sheet.dart';


class SearchController extends GetxController{

  ///Filter related data
  bool isFiltering = false;
  List<String> language = [];
  bool checkBoxValueEnglish = false;
  bool checkBoxValueHindi = false;
  bool checkBoxValueSpanish = false;
  bool checkBoxValueBengali = false;

  ///Search related data
  String searchCountry = "";
  final TextEditingController searchController =  TextEditingController();
  bool isSearching = false;
  Timer? _throttle;

  void searchCountryByCode(){
    if (_throttle?.isActive??false) _throttle?.cancel();
    _throttle = Timer(const Duration(milliseconds: 500), () {
      if(searchController.text.isNotEmpty){
          isSearching = true;
          update();
          searchCountry = """
          query Query {
           country(code: "${searchController.text.toUpperCase()}") {
           name
           capital  
           emoji
         }
        }
      """;
      }else{
        isSearching = false;
        update();
      }
    });
  }


  void showBottomSheet() {
    Get.bottomSheet(
      DraggableScrollableSheet(
        initialChildSize: 0.47,
        minChildSize: 0.47,
        maxChildSize: 0.47,
        builder: (_, controller) {
          return FilterBottomSheet();
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
    );
  }

  ///Fetch all country list
  final String fetchAll = """
  { 
    countries {
      name
      emoji
      capital
      languages {
        name
      }
    }
  }
""";

}