import 'package:flutter/material.dart';
import 'package:flutter_form/src/model/accomodation_model.dart';
import 'package:flutter_form/src/model/cab_booking_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../model/travel.dart';
import '../../../provider/booking/req_provider.dart';
import '../../../utils/app_utils.dart';
import '../../home/homescreen.dart';
import '../cab/journey_details.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({super.key});

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: ChangeNotifierProvider(
        create: (context) => RequestProvider(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: AppConstants.appSTCColor,
            iconTheme: const IconThemeData(color: Colors.black),
            centerTitle: true,
            leading: InkWell(
              onTap: () =>
                  AppConstants.moveNextClearAll(context, const HomeScreen()),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            title: Text(
              "Requests",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
          body: body(context),
        ),
      ),
    );
  }

  body(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
              child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Padding(
                padding: AppConstants.all_5,
                child: Image.asset(
                  "assets/images/STC_logo.png",
                  opacity: const AlwaysStoppedAnimation(.2),
                ),
              ),
            ),
          )),
          SingleChildScrollView(
            child:
                Consumer<RequestProvider>(builder: (context, provider, child) {
              if (provider.checkReqs) {
                provider.getRequests(context);
              }
              if (provider.reqModel.isNotEmpty) {
                return RefreshIndicator(
                  onRefresh: () => provider.getData(context),
                  child: ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: provider.reqModel.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: AppConstants.all_10,
                          child: Card(
                            child: Padding(
                              padding: AppConstants.all_5,
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "ID: ${provider.reqModel[index].id}",
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            "status : ${provider.reqModel[index].status}",
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    AppConstants.h_10,
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Request Type: ${provider.reqModel[index].typeOfReq}",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Requested Raised Date: ${provider.changeDateFmt(provider.reqModel[index].dateOfRaisedReq!)}",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    if (provider.reqModel[index]
                                        .approvalDetails['dateOfApproval']
                                        .toString()
                                        .isNotEmpty)
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "${provider.reqModel[index].status} Date: ${provider.changeDateFmt(provider.reqModel[index].approvalDetails['dateOfApproval'] ?? "")}",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    Selector<RequestProvider, String>(
                                        builder: (_, p, child) {
                                          if (p == 'Cab Request') {
                                            return cabDetails(
                                                CabBookingModel.fromJson(
                                                    provider.reqModel[index]
                                                        .cabReq!));
                                          } else if (p == 'Accomodation') {
                                            return accomodationDetails(
                                                AccomodationModel.fromJson(
                                                    provider.reqModel[index]
                                                        .accomodation!));
                                          } else if (p == 'Travel') {
                                            return travelDetails(
                                                TravelModel.fromJson(provider
                                                    .reqModel[index].travel!));
                                          } else {
                                            return Container();
                                          }
                                        },
                                        selector: ((p0, p1) =>
                                            p1.reqModel[index].typeOfReq)),
                                    AppConstants.h_10,
                                    if (provider.reqModel[index].approvalDetails
                                        .isNotEmpty)
                                      Selector<RequestProvider, String>(
                                          builder: (_, p, child) {
                                            if (provider
                                                    .reqModel[index].status ==
                                                'Approved') {
                                              if (p.isNotEmpty) {
                                                if (provider.reqModel[index]
                                                        .typeOfReq ==
                                                    "Cab Request") {
                                                  return textSummary(
                                                      "Cab Details:", p);
                                                } else if (provider
                                                        .reqModel[index]
                                                        .typeOfReq ==
                                                    "Accomodation") {
                                                  return textSummary(
                                                      "Hotel Details:", p);
                                                } else if (provider
                                                        .reqModel[index]
                                                        .typeOfReq ==
                                                    "Travel") {
                                                  return textSummary(
                                                      "Ticket Details:", p);
                                                } else {
                                                  return Container();
                                                }
                                              } else {
                                                return textSummary(
                                                    "Approved Details",
                                                    "Details will be updated soon");
                                              }
                                            } else if (provider
                                                    .reqModel[index].status ==
                                                'Rejected') {
                                              return textSummary(
                                                  "Rejection Details:", p);
                                            } else {
                                              return Container();
                                            }
                                          },
                                          selector: ((p0, p1) => p1
                                                  .reqModel[index]
                                                  .approvalDetails[
                                              'approvalDetails'])),
                                    Selector<RequestProvider, String>(
                                        builder: (_, p, child) {
                                          if ((p == '2') &&
                                              provider.reqModel[index].status ==
                                                  'In Process') {
                                            return btns(
                                                context, provider, index);
                                          } else if ((p == '3') &&
                                              provider.reqModel[index].status ==
                                                  'Approved by Admin') {
                                            return btns(
                                                context, provider, index);
                                          } else if ((p == '2') &&
                                              provider.reqModel[index].status ==
                                                  'Approved') {
                                            return InkWell(
                                              onTap: () => provider.enableSave
                                                  ? provider.approvetoMgmt(
                                                      context,
                                                      provider.reqModel[index])
                                                  : provider.onClickApproveBtn(
                                                      context),
                                              child: btn(
                                                  context,
                                                  250,
                                                  Colors.green,
                                                  provider.enableSave
                                                      ? "Save Details"
                                                      : provider
                                                              .reqModel[index]
                                                              .approvalDetails[
                                                                  'approvalDetails']
                                                              .toString()
                                                              .isEmpty
                                                          ? "Update the Details"
                                                          : "Edit the Details"),
                                            );
                                          } else if ((p == '0')) {
                                            if (provider.reqModel[index]
                                                        .status ==
                                                    "Approved" &&
                                                provider
                                                    .reqModel[index]
                                                    .approvalDetails[
                                                        "approval_details"]
                                                    .toString()
                                                    .isNotEmpty) {
                                              return InkWell(
                                                onTap: () =>
                                                    AppConstants.moveNextstl(
                                                        context,
                                                        JourneyDetails(
                                                          destination: provider
                                                                  .reqModel[index]
                                                                  .cabReq![
                                                              'destiantionLocation'],
                                                        )),
                                                child: btn(
                                                    context,
                                                    300,
                                                    Colors.black,
                                                    "Start your Journey"),
                                              );
                                            } else {
                                              return Container();
                                            }
                                          } else {
                                            return Container();
                                          }
                                        },
                                        selector: ((p0, p1) => p1.level)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Center(
                        child: Text(
                          "No requests for you !!",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                );
              }
            }),
          )
        ],
      ),
    );
  }

  textSummary(String title, String subDetails) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            subDetails,
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  cabDetails(CabBookingModel cabBookingModel) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Cab Type: ${cabBookingModel.cabType}",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Person Name: ${cabBookingModel.personName}",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Mobile Number: ${cabBookingModel.mobNum}",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Requested Date: ${cabBookingModel.cabRDate}",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Pick-up Time: ${cabBookingModel.pickUpTime}",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Pick Up Location: ${cabBookingModel.pickUpLocation}",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Destination: ${cabBookingModel.destiantionLocation}",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Approx. KM: ${cabBookingModel.km}",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  accomodationDetails(AccomodationModel accomodationModel) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Cab Type: ${accomodationModel.eMpCode}",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Person Name: ${accomodationModel.personName}",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Mobile Number: ${accomodationModel.mobNum}",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "CheckIN Date&Time: ${accomodationModel.checkInDt}:${accomodationModel.checkInTm}",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "CheckOut Date&Time: ${accomodationModel.checkOutDt}:${accomodationModel.checkOutTm}",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Type Of Movement: ${accomodationModel.movementType}",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Purpose of Visit: ${accomodationModel.purposeOfVisit}",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  travelDetails(TravelModel travelModel) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Employee ID: ${travelModel.empCode}",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Person Name: ${travelModel.personName}",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Mobile Number: ${travelModel.mobNum}",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Age: ${travelModel.age}",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Travelling Date&Time: ${travelModel.travellingDt}:${travelModel.preferredTiming}",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Travelling Details: ${travelModel.locFrom}-${travelModel.destination}",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Mode Of Travel: ${travelModel.modeOfTravel}",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Pickup & Dropping: ${travelModel.pickUpPoint}-${travelModel.droppingPoint}",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  btns(BuildContext context, RequestProvider provider, int index) {
    return Row(
      children: [
        InkWell(
          onTap: () => provider.enableSave
              ? provider.rejectReq(context, provider.reqModel[index])
              : provider.onClickNotesBtn(context),
          child: btn(context, 80, Colors.red,
              provider.enableSave ? "Save Rejection" : "Reject"),
        ),
        AppConstants.w_5,
        InkWell(
          onTap: () =>
              provider.approvetoMgmt(context, provider.reqModel[index]),
          child: btn(
              context,
              250,
              Colors.green,
              provider.reqModel[index].reqLevel == '2'
                  ? "Approve & Send to Management"
                  : (provider.reqModel[index].reqLevel == '3'
                      ? "Approve & Send to Admin"
                      : "")),
        ),
      ],
    );
  }

  btn(BuildContext context, double width, Color? color, String title) {
    return Center(
      child: Container(
        width: width,
        height: 50,
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}


             // Flexible(
                  // child: Container(
                  //     padding: const EdgeInsets.all(10),
                  //     color: Colors.white,
                  //     child: EditableText(
                  //       onChanged: (value) {},
                  //       maxLines: 300, // line limit extendable later
                  //       controller: _contentController,
                  //       focusNode: _contentFocus,
                  //       style: Theme.of(context).textTheme.headline5!,
                  //       cursorColor: Colors.black,
                  //       backgroundCursorColor: Colors.black,
                  //     )))