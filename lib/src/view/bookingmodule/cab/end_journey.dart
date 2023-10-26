import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_utils.dart';
import '../list_req/requests.dart';

class EndJourney extends StatelessWidget {
  const EndJourney({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppConstants.appSTCColor,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          leading: InkWell(
            onTap: () =>
                AppConstants.moveNextClearAll(context, const MyRequests()),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Journey Details",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
    );
  }
}
