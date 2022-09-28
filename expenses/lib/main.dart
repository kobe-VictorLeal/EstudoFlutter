import 'package:expenses/components/chart.dart';
import 'package:flutter/cupertino.dart';
import '/components/transaction_form.dart';
import '/components/transaction_list.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import 'package:expenses/models/transaction.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    return MaterialApp(
      home: MyHomePage(),
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        textTheme: theme.textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            button: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        appBarTheme: theme.appBarTheme.copyWith(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;

  final List<Transaction> _transactions = [
    Transaction(
      id: "t0",
      title: "Conta antiga",
      value: 212,
      date: DateTime.now().subtract(Duration(days: 33)),
    ),
    Transaction(
      id: "t1",
      title: "Novo tênis de corrida",
      value: 210,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: "t2",
      title: "Conta de Luz",
      value: 135.42,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: "t3",
      title: "Conta antiga",
      value: 212,
      date: DateTime.now().subtract(Duration(days: 33)),
    ),
    Transaction(
      id: "t4",
      title: "Novo tênis de corrida",
      value: 210,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: "t5",
      title: "Conta de Luz",
      value: 135.42,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime? date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date ?? DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) {
        return transaction.id == id;
      });
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  Widget _getIconButton(Function() fn, IconData icon) {
    return Platform.isIOS ? GestureDetector(onTap: fn, child: Icon(icon)) : IconButton(icon: Icon(icon), onPressed: fn);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool _isLandscape = mediaQuery.orientation == Orientation.landscape;
    final actions = [
      if (_isLandscape)
        _getIconButton(
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
          _showChart ? Icons.list : Icons.show_chart,
        ),
      _getIconButton(
        () => _openTransactionFormModal(context),
        Icons.add,
      )
    ];

    final PreferredSizeWidget appBar;
    if (Platform.isIOS) {
      appBar = CupertinoNavigationBar(
        middle: Text('Despesas Pessoais'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: actions,
        ),
      );
    } else {
      appBar = AppBar(
        title: Text(
          "Gastos da Semana",
          style: TextStyle(
            fontSize: 20 * mediaQuery.textScaleFactor,
          ),
        ),
        actions: actions,
      );
    }

    final availableHeight = MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top;
    final bodyPage = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Exibir Gráfico"),
                Switch.adaptive(
                  activeColor: Theme.of(context).accentColor,
                  value: _showChart,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
                ),
              ],
            ),
          if (_showChart || !_isLandscape)
            Container(
              height: availableHeight * (_isLandscape ? 0.7 : 0.3),
              child: Chart(_recentTransactions),
            ),
          if (!_showChart || !_isLandscape)
            Container(
              height: availableHeight * (_isLandscape ? 1 : 0.7),
              child: TransactionList(_transactions, _removeTransaction),
            ),
        ],
      ),
    );

    return Platform.isIOS && false
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Despesas Pessoais'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_isLandscape)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Exibir Gráfico"),
                        Switch.adaptive(
                          activeColor: Theme.of(context).accentColor,
                          value: _showChart,
                          onChanged: (value) {
                            setState(() {
                              _showChart = value;
                            });
                          },
                        ),
                      ],
                    ),
                  if (_showChart || !_isLandscape)
                    Container(
                      height: availableHeight * (_isLandscape ? 0.7 : 0.3),
                      child: Chart(_recentTransactions),
                    ),
                  if (!_showChart || !_isLandscape)
                    Container(
                      height: availableHeight * (_isLandscape ? 1 : 0.7),
                      child: TransactionList(_transactions, _removeTransaction),
                    ),
                ],
              ),
            ),
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _openTransactionFormModal(context),
                  ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          );
  }
}
