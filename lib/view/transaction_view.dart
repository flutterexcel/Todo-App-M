import 'package:flutter/material.dart';

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  List<String> transactionType = ["Expense", "Income"];
  String tType = "Expense";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transactions")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Container(
              color: Colors.lightGreen,
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: Row(
                children: [
                  DropdownButton(
                      value: tType,
                      items: transactionType.map((String e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          tType = newValue!;
                        });
                      }),
                  const SizedBox(
                    width: 240,
                  ),
                  const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.refresh_sharp,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.lightBlue,
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ListView(
              padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Material(
                    borderOnForeground: true,
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(60),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        child: const Text(
                          "All",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(60),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        child: const Text(
                          "Today",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(60),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        child: const Text(
                          "This week",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(60),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        child: const Text(
                          "This month",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.lime,
            ),
          )
        ],
      ),
    );
  }
}
