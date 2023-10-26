import 'package:flutter/material.dart';
import 'package:flutter_form/src/provider/home/home_provider.dart';
import 'package:flutter_form/src/view/branding/branding_home.dart';
import 'package:flutter_form/src/view/public_opinion/form.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../utils/app_utils.dart';
import '../bookingmodule/booking form/booking_form.dart';
import '../bookingmodule/list_req/requests.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        Provider.of<HomeProvider>(context, listen: false).init();
        return HomeProvider();
      },
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: AppConstants.appSTCColor,
          floatingActionButton: InkWell(
            onTap: () => Provider.of<HomeProvider>(context, listen: false)
                .clearAll(context),
            child: btnLogout(),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: SafeArea(
              child: SingleChildScrollView(
            child: Stack(
              children: [
                Positioned(
                    child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Image.asset(
                      "assets/images/STC_logo.png",
                      opacity: const AlwaysStoppedAnimation(.2),
                    ),
                  ),
                )),
                Padding(
                  padding: AppConstants.all_10,
                  child: Column(
                    children: [
                      Consumer<HomeProvider>(builder: (_, provider, child) {
                        if (provider.vName.isEmpty) {
                          provider.init();
                        }
                        return Padding(
                          padding: AppConstants.leftRight_10,
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Hi ${provider.vName},",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500))),
                        );
                      }),
                      AppConstants.h_10,
                      Padding(
                        padding: AppConstants.leftRight_10,
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text("Welcome!!!",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500))),
                      ),
                      Padding(
                        padding: AppConstants.all_10,
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(" Please choose your Task:",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500))),
                      ),
                      AppConstants.h_10,
                      firstRow(context),
                      AppConstants.h_10,
                      Consumer<HomeProvider>(builder: (_, provider, child) {
                        return secondRow(context, provider);
                      }),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  firstRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () => AppConstants.moveNextstl(context, const FormScreen()),
          child: Padding(
            padding: AppConstants.all_10,
            child: cardItem("Public Survey", "assets/images/ic_survey.png"),
          ),
        ),
        InkWell(
          onTap: () =>
              AppConstants.moveNextstl(context, const BrandingScreen()),
          child: Padding(
            padding: AppConstants.all_10,
            child: cardItem("Branding", "assets/images/ic_branding.png"),
          ),
        ),
      ],
    );
  }

  secondRow(BuildContext context, HomeProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (provider.level.isNotEmpty)
          Selector<HomeProvider, String>(
              selector: (p0, p1) => p1.level,
              builder: (context, provider, child) {
                if (int.parse(provider) >= 1) {
                  return InkWell(
                    onTap: () =>
                        AppConstants.moveNextstl(context, const BookingForm()),
                    child: Padding(
                      padding: AppConstants.all_10,
                      child: cardItem(
                          "Raise a Request", "assets/images/ic_booking.png"),
                    ),
                  );
                } else {
                  return Container();
                }
              }),
        AppConstants.w_5,
        InkWell(
          onTap: () => AppConstants.moveNextstl(context, const MyRequests()),
          child: Padding(
            padding: AppConstants.all_10,
            child: cardItem(
                "Requests \n                ", "assets/images/ic_request.png"),
          ),
        ),
      ],
    );
  }

  btnLogout() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        height: 50,
        decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Center(
            child: Text(
          "Logout",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }

  cardItem(String title, String image) {
    return Column(
      children: [
        Container(
          padding: AppConstants.all_5,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2.5),
              image: DecorationImage(
                  image: AssetImage(image), fit: BoxFit.contain),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          height: 75,
          width: 75,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 150,
            child: Text(title,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500)),
          ),
        )
      ],
    );
  }
}
