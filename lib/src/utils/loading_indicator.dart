import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_utils.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key, this.text = '', required this.title})
      : super(key: key);
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    var displayedText = text;

    return Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white12,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _getLoadingIndicator(),
              _getHeading(context, title),
              _getText(displayedText)
            ]));
  }

  Padding _getLoadingIndicator() {
    return const Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
                color: AppConstants.appPrimaryColor, strokeWidth: 3)));
  }

  Widget _getHeading(context, String title) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(
          title,
          style: GoogleFonts.inter(fontSize: 14, color: Colors.black),
          textAlign: TextAlign.center,
        ));
  }

  Text _getText(String displayedText) {
    return Text(
      displayedText,
      style: GoogleFonts.inter(fontSize: 14, color: Colors.black),
      textAlign: TextAlign.center,
    );
  }
}

class DialogBuilder {
  DialogBuilder(this.context);

  final BuildContext context;

  Future showLoadingIndicator(String msg, String title) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              backgroundColor: AppConstants.appSTCColor,
              content: LoadingIndicator(
                text: msg,
                title: title,
              ),
            ));
      },
    );
  }

  void hideOpenDialog() {
    Navigator.of(context).pop();
  }
}
