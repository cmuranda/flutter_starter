import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'fulfilment_model.dart';

class FulfilmentResultsView extends StatelessWidget{
  FulfilmentResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title:
        const Text("Take Up Results"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: GridView.count(
            crossAxisCount: 2,
          children: getFulfilmentViews(),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: OutlinedButton(
            onPressed: (){},
          style: OutlinedButton.styleFrom(
              minimumSize: const Size(200, 50),
              side: const BorderSide(
                  width: 3,
                  color: Colors.orange
              )
          ),
            child: const Text(
                "Continue"
            ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  final Map<String, IconData> fulfilmentIcons = {
    "KYC": Icons.badge_outlined,
    "Living Status": Icons.health_and_safety_outlined,
    "Fraud": Icons.lock_clock_outlined,
    "Duplicate ID": Icons.group_outlined
  };

  List<Widget> getFulfilmentViews() {
    var fulfilments = fulfilmentFromJson(mockFulfilmentApiResult);
    List<FulfilmentResult> results = fulfilments.fulfilmentResults;

     return results.map((fulfilmentResult) {
      return Card(
        color: fulfilmentResult.passed? Colors.green.shade50 : Colors.red.shade50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                    fulfilmentIcons[fulfilmentResult.checkName]!,
                  size: 50,
                ),
              )
              ,
              Text(
                  fulfilmentResult.checkName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25
                ),
              ),
              const Expanded(child: Text("")),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(fulfilmentResult.passed? "Passed": "Failed"),
                ),
              )
            ],
          ),
      );
    }).toList();
  }
}