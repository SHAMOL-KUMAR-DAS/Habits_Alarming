import 'package:flutter/material.dart';

class Snackbar {
  ///for snack bar
  showSnack(BuildContext context, String message,
      GlobalKey<ScaffoldState> _scaffoldKey, Function undo) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        // behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        action: undo != null
            ? SnackBarAction(
                textColor:
                    Theme.of(_scaffoldKey.currentState.context).primaryColor,
                label: "Undo",
                onPressed: () => undo,
              )
            : null,
      ),
    );
  }
  // void showSnack(String message, GlobalKey<ScaffoldState> _scaffoldKey,
  //     Function undo) =>
  //     _scaffoldKey.currentState.showSnackBar(
  //       SnackBar(
  //         content: Text(message),
  //         action: undo != null ? SnackBarAction(
  //           textColor: Theme.of(_scaffoldKey.currentState.context).primaryColor,
  //           label: "Undo",
  //           onPressed: () => undo,
  //         ):null,
  //       ),
  //     );
}
