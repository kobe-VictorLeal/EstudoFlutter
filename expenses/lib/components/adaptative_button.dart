import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeButton extends StatelessWidget {
  final String title;
  final Function() action;

  AdaptativeButton({
    required this.title,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(title),
            onPressed: action,
            color: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
          )
        : RaisedButton(
            child: Text(title),
            onPressed: action,
            color: Theme.of(context).colorScheme.primary,
            textColor: Theme.of(context).textTheme.button?.color,
          );
  }
}
