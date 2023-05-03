

import 'dart:async';
import 'package:crypto_quest/main.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// class DialogService {

//   dialogErrore(){}
//   dialogSuccess(){}
//   dataDiaog(){}
// }


// Completer _myCompleter = Completer();

// Future startSomething(){
//   return _myCompleter.future;
// }

// void _endSomething(){
//   _myCompleter.complete();
// }

// var myValue = await startSomething();
// print('Something completed');  

class DialogService {
  Function? _showDialogListener;
  Completer? _dialogCompleter;
  DialogService();
  /// Registers a callback function. Typically to show the dialog
  DialogService.registerDialogListener(Function showDialogListener) {
    _showDialogListener = showDialogListener;
  }
  /// Registers a callback function. Typically to show the dialog
  void registerDialogListener(Function showDialogListener) {
    _showDialogListener = showDialogListener;
  }
  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  Future showDialog() {
    _dialogCompleter = Completer();
    _showDialogListener!();
    return _dialogCompleter!.future;
  }
  /// Completes the _dialogCompleter to resume the Future's execution call
  void dialogComplete() {
    _dialogCompleter!.complete();
    _dialogCompleter = null;
  }
}



class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({Key? key, required this.child}) : super(key: key);
  _DialogManagerState createState() => _DialogManagerState();
}
class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = locator<DialogService>();
  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
  void _showDialog() {
    Alert(
        context: context,
        title: "FilledStacks",
        desc: "My tutorials show realworld structures.",
        closeFunction: () => _dialogService.dialogComplete(),
        buttons: [
          DialogButton(
            child: Text('Ok'),
            onPressed: () {
              _dialogService.dialogComplete();
              Navigator.of(context).pop();
            },
          )
        ]).show();
  }
}