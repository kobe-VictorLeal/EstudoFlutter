import 'package:expenses/components/transanction_cell.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 470,
      child: transactions.isEmpty
          ? Column(
              children: [
                SizedBox(height: 20),
                Text(
                  "Nenhuma transação cadastrada",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 20),
                Container(
                  height: 200,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final transaction = transactions[index];
                return TransactionCell(transaction, onRemove);
              },
            ),
    );
  }
}
