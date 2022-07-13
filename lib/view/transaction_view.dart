import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  bool apiData = false;
  fetchSMS(int filter) async {
    messages = await telephony.getInboxSms();

    DateTime compare = DateTime.parse(
        (DateTime.now().subtract(Duration(days: filter)).toIso8601String()));
    print(compare);
    List<SmsMessage> messages1 = [];

    for (int i = 0; i < messages.length; i++) {
      (DateTime.fromMillisecondsSinceEpoch(messages[i].date!).isAfter(compare))
          ? messages1.add(messages[i])
          : print("kat gya ${messages[i].date}");
    }

    for (int i = 0; i < messages1.length; i++) {
      if (messages1[i].body!.contains("credited") ||
          messages1[i].body!.contains("deposited") == true) {
        if (regex.hasMatch(messages1[i].body!) == true) {
          match = regex.firstMatch(messages1[i].body!);
          match!.group(4) == null
              ? amount =
                  double.parse(match!.group(1).toString().replaceAll(",", ""))
              : amount =
                  double.parse(match!.group(4).toString().replaceAll(",", ""));
          creditTotal += amount;
        } else {
          null;
        }
      } else if (messages1[i].body!.contains("debited") ||
          messages1[i].body!.contains("spent") ||
          messages1[i].body!.contains("withdrawn") == true) {
        if (regex.hasMatch(messages1[i].body!) == true) {
          match = regex.firstMatch(messages1[i].body!);
          match!.group(4) == null
              ? amount =
                  double.parse(match!.group(1).toString().replaceAll(",", ""))
              : amount =
                  double.parse(match!.group(4).toString().replaceAll(",", ""));
          debitTotal += amount;
        } else {
          null;
        }
      }
    }
    Transactions transactions1 = Transactions(debitTotal, "Total Debited",
        charts.ColorUtil.fromDartColor(Colors.red[300]!));
    Transactions transactions2 = Transactions(creditTotal, "Total Credited",
        charts.ColorUtil.fromDartColor(Colors.green[300]!));
    List<Transactions> myData = [];
    myData.add(transactions1);
    myData.add(transactions2);
    _generateData(myData);
  }

  final Telephony telephony = Telephony.instance;
  RegExp regex = RegExp(
      r'Rs\W+(([0-9]+)\.*([0-9]*)?)\w|INR\W+(([0-9]+(,)?[0-9]+)\.*([0-9]*)?)\w');
  RegExpMatch? match;
  List<SmsMessage> messages = [];
  double creditTotal = 0.0;
  double debitTotal = 0.0;
  double amount = 0.0;

  List<String> transactionType = ["Expense", "Income"];
  String tType = "Expense";
  List filter = [
    "This week",
    "This month",
    "Last 3 months",
    "Last 6 months",
    "This year"
  ];
  String selected = "This week";
  List<charts.Series<Transactions, String>> seriesList = [];
  _generateData(myData) {
    seriesList.add(charts.Series(
        domainFn: (Transactions transaction, _) => transaction.type,
        measureFn: (Transactions transaction, _) => transaction.amount,
        colorFn: (Transactions transaction, _) => transaction.color,
        id: "Transactions",
        data: myData,
        labelAccessorFn: (Transactions transaction, _) =>
            "${transaction.amount}"));
    apiData = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchSMS(7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Transactions")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 06),
          SizedBox(
              height: 38,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filter.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: InkWell(
                          onTap: () {
                            selected = filter[index];

                            setState(() {
                              debitTotal = 0.0;
                              creditTotal = 0.0;
                              amount = 0.0;
                              (filter[index] == "This week")
                                  ? fetchSMS(7)
                                  : (filter[index] == "This month")
                                      ? fetchSMS(30)
                                      : (filter[index] == "Last 3 months")
                                          ? fetchSMS(92)
                                          : (filter[index] == "Last 6 months")
                                              ? fetchSMS(185)
                                              : (filter[index] == "This year")
                                                  ? fetchSMS(365)
                                                  : null;
                            });
                          },
                          child: Container(
                            height: 36,
                            decoration: BoxDecoration(
                              color: filter[index] != selected
                                  ? const Color(0xffe9e9e9)
                                  : const Color(0xff5118AA),
                              borderRadius: BorderRadius.circular(6.93),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 7),
                            child: Text(filter[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: filter[index] != selected
                                        ? const Color(0xff77737c)
                                        : Colors.white)),
                          ),
                        ),
                      );
                    }),
              )),
          SizedBox(height: 05),
          Wrap(
            children: [
              Text(
                "Total Debited = Rs. ${debitTotal.toStringAsFixed(2)}",
                style: TextStyle(
                    fontSize: 16,
                    backgroundColor: Colors.white54,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Total Credited = Rs. ${creditTotal.toStringAsFixed(2)}",
                style: TextStyle(
                    fontSize: 16,
                    backgroundColor: Colors.white54,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Expanded(
            child: Container(
              color: Colors.white54,
              child: apiData
                  ? charts.BarChart(
                      seriesList,
                      animate: true,
                    )
                  : CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}

class Transactions {
  final double amount;
  final String type;
  final charts.Color color;

  Transactions(this.amount, this.type, this.color);
}
