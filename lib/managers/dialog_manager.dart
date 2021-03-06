import 'package:flutter/material.dart';
import 'package:mobile_app/locator.dart';
import 'package:mobile_app/models/dialog_models.dart';
import 'package:mobile_app/services/dialog_service.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({Key key, this.child}) : super(key: key);

  @override
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  final DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
    _dialogService.registerConfirmationDialogListener(_showConfirmationDialog);
    _dialogService.registerProgressDialogListener(_showProgressDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(DialogRequest request) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(
          request.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(request.description),
        actions: <Widget>[
          FlatButton(
            child: Text(
              request.buttonTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              _dialogService.dialogComplete(
                DialogResponse(confirmed: true),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(DialogRequest request) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(
          request.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(request.description),
        actions: <Widget>[
          FlatButton(
            child: Text(
              request.cancelTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              _dialogService.dialogComplete(
                DialogResponse(confirmed: false),
              );
            },
          ),
          FlatButton(
            child: Text(
              request.buttonTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              _dialogService.dialogComplete(
                DialogResponse(confirmed: true),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showProgressDialog(DialogRequest request) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    request.title,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
