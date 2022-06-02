import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:todo_app/utils/google_authentication.dart';

class Charts extends StatefulWidget {
  const Charts({Key? key}) : super(key: key);

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  int key = 0;

  late List<Task> _task = [];

  Map<String, double> getCategoryData() {
    Map<String, double> catMap = {};
    for (var item in _task) {
      // print(item.category);
      if (catMap.containsKey(item.category) == false) {
        catMap[item.category] = 1;
      } else {
        catMap.update(item.category, (int) => catMap[item.category]! + 1);
        // test[item.category] = test[item.category]! + 1;
      }
      //  print(catMap);
    }
    return catMap;
  }

  Widget pieChartExampleOne() {
    return PieChart(
      key: ValueKey(key),
      dataMap: getCategoryData(),
      initialAngleInDegree: 0,
      animationDuration: const Duration(milliseconds: 2000),
      chartType: ChartType.ring,
      chartRadius: MediaQuery.of(context).size.width / 2.5,
      ringStrokeWidth: 32,
      // colorList: colorList,
      chartLegendSpacing: 45,
      chartValuesOptions: const ChartValuesOptions(
          showChartValuesOutside: true,
          showChartValuesInPercentage: true,
          showChartValueBackground: true,
          showChartValues: true,
          chartValueStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      centerText: 'Categories',
      legendOptions: const LegendOptions(
          showLegendsInRow: true,
          showLegends: true,
          legendShape: BoxShape.circle,
          legendPosition: LegendPosition.bottom,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> taskStream = FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('mytasks')
        .snapshots();

    void getTaskfromSnapshot(snapshot) {
      if (snapshot.docs.isNotEmpty) {
        _task = [];
        for (int i = 0; i < snapshot.docs.length; i++) {
          var a = snapshot.docs[i];
          // print(a.data());
          Task exp = Task.fromJson(a.data());
          _task.add(exp);
          // print(exp);
        }
      }
    }

    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text("Pie Chart")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              StreamBuilder<Object>(
                stream: taskStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  final data = snapshot.requireData;
                  // print("Data: $data");
                  getTaskfromSnapshot(data);

                  return pieChartExampleOne();
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child:
                        Icon(Icons.fact_check_outlined, color: Colors.white)),
                ElevatedButton(
                    onPressed: null,
                    child: const Icon(Icons.done, color: Colors.white))
              ],
            ),
            color: Colors.black,
            height: 55,
            width: MediaQuery.of(context).size.width));
  }
}

class Task {
  String category;
  String title;
  String time;
  Task({required this.category, required this.time, required this.title});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      time: json['time'],
      category: json['category'],
      title: json['title'],
    );
  }
}
