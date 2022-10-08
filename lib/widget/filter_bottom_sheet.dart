import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_country_graphql/controller/search_controller.dart';



class FilterBottomSheet extends StatelessWidget {
  FilterBottomSheet({Key? key}) : super(key: key);
  final SearchController _searchController = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      builder: ((controller) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 25),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Filter by language",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text("English"),
                  Checkbox(
                    value: _searchController.checkBoxValueEnglish,
                    onChanged: (newValue) {
                      _searchController.checkBoxValueEnglish = newValue!;
                      _searchController.update();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    activeColor: Colors.white,
                    checkColor: Colors.blue,
                    side: MaterialStateBorderSide.resolveWith((states) => const BorderSide(width: 2.0, color: Colors.blue),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("Spanish"),
                  Checkbox(
                    value: _searchController.checkBoxValueSpanish,
                    onChanged: (newValue) {
                      _searchController.checkBoxValueSpanish = newValue!;
                      _searchController.update();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    activeColor: Colors.white,
                    checkColor: Colors.blue,
                    side: MaterialStateBorderSide.resolveWith((states) => const BorderSide(width: 2.0, color: Colors.blue),
                    ),
                  ),
                ],
              ), //Chec
              Row(
                children: [
                  const Text("Hindi"),
                  Checkbox(
                    value: _searchController.checkBoxValueHindi,
                    onChanged: (newValue) {
                      _searchController.checkBoxValueHindi = newValue!;
                      _searchController.update();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    activeColor: Colors.white,
                    checkColor: Colors.blue,
                    side: MaterialStateBorderSide.resolveWith((states) => const BorderSide(width: 2.0, color: Colors.blue),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("Bengali"),
                  Checkbox(
                    value: _searchController.checkBoxValueBengali,
                    onChanged: (newValue) {
                      _searchController.checkBoxValueBengali = newValue!;
                      _searchController.update();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    activeColor: Colors.white,
                    checkColor: Colors.blue,
                    side: MaterialStateBorderSide.resolveWith((states) => const BorderSide(width: 2.0, color: Colors.blue),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  child: const Text("Apply"),
                  onPressed: (){
                    if(_searchController.checkBoxValueEnglish ||
                        _searchController.checkBoxValueSpanish ||
                        _searchController.checkBoxValueHindi ||
                        _searchController.checkBoxValueBengali){
                      _searchController.language.clear();
                      if(_searchController.checkBoxValueEnglish){
                        _searchController.language.add("English");
                      }
                      if(_searchController.checkBoxValueSpanish){
                        _searchController.language.add("Spanish");
                      }
                      if(_searchController.checkBoxValueHindi){
                        _searchController.language.add("Hindi");
                      }
                      if(_searchController.checkBoxValueBengali){
                        _searchController.language.add("Bengali");
                      }
                      _searchController.isFiltering = true;
                      _searchController.update();
                      Get.back();
                    }else{
                      Get.snackbar(
                          "Please select language",
                          "",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.blue,
                          colorText:  Colors.white
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
