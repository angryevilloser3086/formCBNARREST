import 'package:flutter/material.dart';
import 'package:flutter_form/src/utils/shared_pref.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_utils.dart';

class NotesAttachmentModalSheet extends StatefulWidget {
  final Size screenSize;
  final String title;
  const NotesAttachmentModalSheet({
    Key? key,
    required this.screenSize,
    required this.title,
  }) : super(key: key);

  @override
  State<NotesAttachmentModalSheet> createState() =>
      _NotesAttachmentModalSheetState();
}

class _NotesAttachmentModalSheetState extends State<NotesAttachmentModalSheet> {
  final _contentController = TextEditingController();
  final _contentFocus = FocusNode();
  SharedPref sharedPref = SharedPref();

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  init() async {
    if (widget.title == 'Reason for Rejection') {
      var nt = await sharedPref.read('Rejected');
      setState(() {
        _contentController.text = nt;
      });
    }
    if (widget.title == 'Update Approval Details of the Request') {
      var nt = await sharedPref.read('Approved');
      setState(() {
        _contentController.text = nt;
      });
    }
  }

  _buildHeading(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
    );
  }

  _buildCloseButton(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Icon(Icons.close, color: Colors.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        color: AppConstants.appSTCColor,
        height: screenWidth > 700 ? 450 : 350,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildHeading(widget.title),
                  _buildCloseButton(context)
                ],
              ),
              AppConstants.h_5,
              _body(context),
              AppConstants.h_10,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                      child: toButtonOption('Update'),
                      onTap: () {
                        setState(() {
                          if (widget.title == 'Reason for Rejection') {
                            sharedPref.save(
                                'Rejected', _contentController.text);
                            Navigator.pop(context, _contentController.text);
                          }
                          if (widget.title ==
                              'Update Approval Details of the Request') {
                            sharedPref.save(
                                'Approved', _contentController.text);
                            Navigator.pop(context, _contentController.text);
                          }
                        });
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container toButtonOption(String name) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: AppConstants.boxRadius8,
      ),
      height: 35,
      width: 100,
      child: Center(
          child: Text(name,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500))),
    );
  }

  Widget _body(BuildContext ctx) {
    return Container(
        padding: AppConstants.all_5,
        height: MediaQuery.of(context).size.height / 4,
        color: AppConstants.appSTCColor,
        child: SafeArea(
          left: true,
          right: true,
          top: false,
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.white,
                      child: EditableText(
                        onChanged: (value) {},
                        maxLines: 300, // line limit extendable later
                        controller: _contentController,
                        focusNode: _contentFocus,
                        style: Theme.of(context).textTheme.headline5!,
                        cursorColor: Colors.black,
                        backgroundCursorColor: Colors.black,
                      )))
            ],
          ),
        ));
  }
}
