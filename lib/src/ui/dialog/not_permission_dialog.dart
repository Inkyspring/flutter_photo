import 'package:flutter/material.dart';
import 'package:photo/src/provider/i18n_provider.dart';

class NotPermissionDialog extends StatefulWidget {
  final I18NPermissionProvider provider;

  const NotPermissionDialog(this.provider);

  @override
  _NotPermissionDialogState createState() => _NotPermissionDialogState();
}

class _NotPermissionDialogState extends State<NotPermissionDialog> {
  @override
  Widget build(BuildContext context) {
    var provider = widget.provider;
    return AlertDialog(
      title: Text(provider.titleText,style: TextStyle(color: provider.titleColor, fontSize: provider.titleFontSize)),
      actions: <Widget>[
        FlatButton(
          onPressed: _onCancel,
          child: Text(provider.cancelText,style: TextStyle(color: provider.cancelColor, fontSize: provider.cancelFontSize)),
        ),
        FlatButton(
          onPressed: _onSure,
          child: Text(provider.sureText,style: TextStyle(color: provider.sureColor, fontSize: provider.sureFontSize)),
        ),
      ],
    );
  }

  void _onCancel() {
    Navigator.pop(context);
  }

  void _onSure() {
    Navigator.pop(context, true);
  }
}
