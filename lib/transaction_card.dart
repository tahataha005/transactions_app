import 'package:flutter/material.dart';
import 'package:transactions_app/transaction_entity.dart';

class TransactionCard extends StatelessWidget {
  final TransactionEntity transaction;
  final Function(TransactionEntity) onDismissed;

  const TransactionCard({
    super.key,
    required this.transaction,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(transaction.id.toString()),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: transaction.income ? Colors.green : Colors.red,
          child: Text(
            transaction.title[0].toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(transaction.title),
        subtitle: Text(transaction.description),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(transaction.time.toIso8601String().substring(0, 10)),
            Text(
              "\$${transaction.price}",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      onDismissed: (d) {
        onDismissed(transaction);
      },
    );
  }
}
