import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<dynamic> categories = [];

  Future<List<dynamic>> loadJson() async {
    String jsonString = await rootBundle.loadString(
      'assets/json/ralm_category.json',
    );
    return json.decode(jsonString);
  }

  @override
  void initState() {
    super.initState();
    getJsonValues();
  }

  Future<void> getJsonValues() async {
    final listCategories = await loadJson();
    for (final category in categories) {
      debugPrint('category: ${category['category_name']}');
    }
    setState(() {
      categories = listCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'R',
                  style: Theme.of(
                    context,
                  ).textTheme.displayLarge?.copyWith(fontSize: 120),
                ),
                Text(
                  'ALM',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 50,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),

            Expanded(
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 80,
                      vertical: 10,
                    ),
                    child: SizedBox(
                      height: 60,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue, // Text color
                          side: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ), // Border color and width
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              50,
                            ), // Rounded corners
                          ),
                        ),
                        child: Text(
                          category['category_name'].toString().toUpperCase(),
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  );
                },
              ),
            ),
            Text('sdf'),
          ],
        ),
      ),
    );
  }
}
