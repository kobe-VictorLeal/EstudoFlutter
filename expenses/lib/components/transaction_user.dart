import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:expenses/models/transaction.dart';

class TransactionUser extends StatelessWidget {
  final _transactions = [
    Transaction(
      id: "t1",
      title: "Novo tênis de corrida",
      value: 210,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Conta de Luz",
      value: 135.42,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionList(_transactions),
        TransactionForm(),
      ],
    );
  }
}
