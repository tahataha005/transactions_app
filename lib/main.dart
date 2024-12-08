import 'dart:math';

import 'package:flutter/material.dart';
import 'package:transactions_app/transaction_card.dart';
import 'package:transactions_app/transaction_entity.dart';

void main() {
  runApp(const TransactionsCalculator());
}

class TransactionsCalculator extends StatelessWidget {
  const TransactionsCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (ctx) => const HomeScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final dateController = TextEditingController();

  bool income = false;

  String calculateTotal() {
    final total = transactions.fold(0.0, (acc, current) {
      return current.income ? acc + current.price : acc - current.price;
    });

    return total.toStringAsFixed(2);
  }

  final List<TransactionEntity> transactions = [
    TransactionEntity(
        id: 1,
        title: "Grocery",
        description: "Month's grocery items",
        income: false,
        time: DateTime(2024, 5, 10),
        price: 50),
    TransactionEntity(
      id: 2,
      title: "Gaming",
      description: "2 hours gaming",
      income: false,
      time: DateTime(2024, 5, 10),
      price: 15,
    ),
    TransactionEntity(
      id: 3,
      title: "Salary",
      description: "Monthly job salary",
      income: true,
      time: DateTime(2024, 5, 10),
      price: 550,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Home Screen",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          elevation: 50,
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              height: 100,
              child: Row(
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(fontSize: 36),
                  ),
                  const Spacer(),
                  Text(
                    calculateTotal(),
                    style: const TextStyle(
                        fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return TransactionCard(
                    transaction: transactions[index],
                    onDismissed: (transaction) {
                      setState(() {
                        transactions.removeWhere((t) => t.id == transaction.id);
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (ctx) {
                  return Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15,
                          spreadRadius: 10,
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          TextField(
                            controller: titleController,
                            decoration: const InputDecoration(
                              hintText: "Title",
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: descriptionController,
                            decoration: const InputDecoration(
                              hintText: "Description",
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: (MediaQuery.of(context).size.width / 2) -
                                    30,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: priceController,
                                  decoration: const InputDecoration(
                                    hintText: "Price",
                                  ),
                                ),
                              ),
                              const Spacer(),
                              const Text("Income"),
                              const SizedBox(
                                width: 10,
                              ),
                              Switch(
                                value: income,
                                onChanged: (value) {
                                  setState(() {
                                    income = value;
                                  });
                                },
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: const Text("Create"),
                              onPressed: () {
                                final id = Random(123);

                                final transaction = TransactionEntity(
                                  id: id.nextInt(1),
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  time: DateTime.now(),
                                  income: income,
                                  price: double.parse(priceController.text),
                                );

                                setState(() {
                                  transactions.add(transaction);
                                });

                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
