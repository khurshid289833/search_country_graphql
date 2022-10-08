import 'package:flutter/material.dart';

class CountryDetailsView extends StatelessWidget {
  final String name,emoji,capital;
  const CountryDetailsView({Key? key, required this.name, required this.emoji, required this.capital}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Country Details",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Center(
              child: Text(
                emoji,
                style: const TextStyle(
                  fontSize: 150,
                ),
              ),
            ),
            Text(
              "Country : $name",
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Capital : $capital",
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
