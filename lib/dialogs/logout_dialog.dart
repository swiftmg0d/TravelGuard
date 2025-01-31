import 'package:flutter/material.dart';
import 'package:travel_guard/widgets/logout/logout_dialog_cancel_button.dart';
import 'package:travel_guard/widgets/logout/logout_dialog_confirm_button.dart';
import 'package:travel_guard/widgets/logout/logout_dialog_logo.dart';
import 'package:travel_guard/widgets/logout/logout_dialog_subtitle.dart';
import 'package:travel_guard/widgets/logout/logout_dialog_title.dart';

class LogoutDialog extends StatefulWidget {
  const LogoutDialog({super.key});

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 244, 251, 250),
      content: Stack(
        children: <Widget>[
          LogOutDialogTitle(),
          LogOutDialogSubTitle(),
          LogOutDialogLogo(),
          Container(
            padding: EdgeInsets.only(top: 250),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LogOutDialogCancelButton(),
                LogOutDialogConfirmButton()
              ],
            ),
          )
        ],
      ),
    );
  }
}
