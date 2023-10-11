import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../provider/booking/booking_provider.dart';
import '../../../utils/app_localization.dart';
import '../../../utils/app_utils.dart';
import '../../home/homescreen.dart';

class BookingForm extends StatelessWidget {
  const BookingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookingProvider(),
      child: Scaffold(
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
            "Raise a Request",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        body: SafeArea(
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
              SingleChildScrollView(
                child: Column(
                  children: [
                    Consumer<BookingProvider>(builder: (_, provider, child) {
                      return typeOfReq(context, provider);
                    }),
                    Selector<BookingProvider, String>(
                        builder: (context, val, child) {
                          if (val == "Cab Request") {
                            return Consumer<BookingProvider>(
                                builder: (_, provider, child) {
                              return typeOfCabReq(context, provider);
                            });
                          } else if (val == "Accomodation") {
                            return Consumer<BookingProvider>(
                                builder: (_, provider, child) {
                              return Container(
                                color: Colors.amber,
                              );
                            });
                          } else {
                            return Container();
                          }
                        },
                        selector: (p0, p1) => p1.sTypeReq),
                    Selector<BookingProvider, String>(
                        builder: (context, val, child) {
                          if (val == "On-Call") {
                            return cabRequest(context);
                          } else if (val == 'Extra Cab') {
                            return Consumer<BookingProvider>(
                                builder: (_, provider, child) {
                              return extraCabBooking(context);
                            });
                          } else if (val == 'Monthly') {
                            return Consumer<BookingProvider>(
                                builder: (_, provider, child) {
                              return Container(
                                height: 200,
                                color: Colors.amber,
                              );
                            });
                          } else {
                            return Container();
                          }
                        },
                        selector: (p0, p1) => p1.sCabType),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  typeOfReq(BuildContext context, BookingProvider provider) {
    return Padding(
      padding: AppConstants.all_10,
      child: Row(
        children: [
          Text("Type of Request:",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          AppConstants.w_20,
          Padding(
            padding: AppConstants.all_5,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: AppConstants.boxBorderDecoration2,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    dropdownColor: Colors.white,
                    borderRadius: AppConstants.boxRadius8,
                    iconDisabledColor: Colors.black,
                    iconEnabledColor: Colors.black,
                    isExpanded: true,
                    value: provider.sTypeReq.isEmpty
                        ? provider.typeOFReq.first
                        : provider.sTypeReq,
                    items: provider.typeOFReq
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: AppConstants.all_5,
                          child: Text(value,
                              style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black)),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) => provider.setReq(value.toString())),
              ),
            ),
          ),
        ],
      ),
    );
  }

  typeOfCabReq(BuildContext context, BookingProvider provider) {
    return Padding(
      padding: AppConstants.all_10,
      child: Row(
        children: [
          Text("Cab Type:",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          AppConstants.w_30,
          Padding(
            padding: AppConstants.all_5,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.55,
              decoration: AppConstants.boxBorderDecoration2,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    dropdownColor: Colors.white,
                    borderRadius: AppConstants.boxRadius8,
                    iconDisabledColor: Colors.black,
                    iconEnabledColor: Colors.black,
                    isExpanded: true,
                    value: provider.sCabType.isEmpty
                        ? provider.typeOFCabReq.first
                        : provider.sCabType,
                    items: provider.typeOFCabReq
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: AppConstants.all_5,
                          child: Text(value,
                              style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black)),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) =>
                        provider.setCabType(value.toString())),
              ),
            ),
          ),
        ],
      ),
    );
  }

  cabRequest(BuildContext context) {
    return Column(
      children: [
        AppConstants.h_10,
        Consumer<BookingProvider>(builder: (_, provider, child) {
          if (provider.cabRDate.isEmpty) {
            provider.initDate();
          }
          return selectDate(_, provider);
        }),
        AppConstants.h_10,
        Consumer<BookingProvider>(builder: (_, provider, child) {
          return teamName(context, provider);
        }),
        AppConstants.h_10,
        Consumer<BookingProvider>(builder: (_, provider, child) {
          return personName(context, provider);
        }),
        Consumer<BookingProvider>(builder: (_, provider, child) {
          return mobileNum(context, provider);
        }),
        Consumer<BookingProvider>(builder: (_, provider, child) {
          return selectTime(context, provider);
        }),
        Consumer<BookingProvider>(builder: (_, provider, child) {
          return pickUp(context, provider);
        }),
        Consumer<BookingProvider>(builder: (_, provider, child) {
          return destinationLoc(context, provider);
        }),
        Consumer<BookingProvider>(builder: (_, provider, child) {
          return purposeOFTrip(context, provider);
        }),
        Consumer<BookingProvider>(builder: (_, provider, child) {
          return approx(context, provider);
        }),
        AppConstants.h_30,
      ],
    );
  }

  extraCabBooking(BuildContext context) {
    return Padding(
      padding: AppConstants.all_10,
      child: Column(
        children: [
          AppConstants.h_10,
          Consumer<BookingProvider>(builder: (_, provider, child) {
            return selectZone(context, provider);
          }),
          AppConstants.h_10,
          Consumer<BookingProvider>(builder: (_, provider, child) {
            return selectPC(context, provider);
          }),
          AppConstants.h_10,
          Consumer<BookingProvider>(builder: (_, provider, child) {
            return teamName(context, provider);
          }),
          AppConstants.h_10,
          Consumer<BookingProvider>(builder: (_, provider, child) {
            return personName(context, provider);
          }),
          Consumer<BookingProvider>(builder: (_, provider, child) {
            return mobileNum(context, provider);
          }),
          Consumer<BookingProvider>(builder: (_, provider, child) {
            return selectTime(context, provider);
          }),
          Consumer<BookingProvider>(builder: (_, provider, child) {
            return pickUp(context, provider);
          }),
          Consumer<BookingProvider>(builder: (_, provider, child) {
            return whomToMeet(context, provider);
          }),
          Consumer<BookingProvider>(builder: (_, provider, child) {
            return approvedBY(context, provider);
          }),
          Consumer<BookingProvider>(builder: (_, provider, child) {
            return destinationLoc(context, provider);
          }),
        ],
      ),
    );
  }

  selectZone(BuildContext context, BookingProvider provider) {
    return Padding(
      padding: AppConstants.all_10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text("${Strings.of(context).zone}:",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500)),
          ),
          AppConstants.h_10,
          Padding(
            padding: AppConstants.all_5,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: AppConstants.boxBorderDecoration2,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    dropdownColor: Colors.white,
                    borderRadius: AppConstants.boxRadius8,
                    iconDisabledColor: Colors.black,
                    iconEnabledColor: Colors.black,
                    isExpanded: true,
                    value: provider.sZones.isEmpty
                        ? provider.zones.first
                        : provider.sZones,
                    items: provider.zones
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: AppConstants.all_10,
                          child: Text(value,
                              style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black)),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) => provider.setZone(value.toString())),
              ),
            ),
          ),
        ],
      ),
    );
  }

  selectPC(BuildContext context, BookingProvider provider) {
    return Padding(
      padding: AppConstants.all_10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text("${Strings.of(context).pC}:",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500)),
          ),
          AppConstants.w_15,
          Padding(
            padding: AppConstants.all_5,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: AppConstants.boxBorderDecoration2,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    dropdownColor: Colors.white,
                    borderRadius: AppConstants.boxRadius8,
                    iconDisabledColor: Colors.black,
                    iconEnabledColor: Colors.black,
                    isExpanded: true,
                    value: provider.sPc.isEmpty
                        ? provider.sendZonePc(provider.sZones).first
                        : provider.sPc,
                    items: provider
                        .sendZonePc(provider.sZones)
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: AppConstants.all_10,
                          child: Text(value,
                              style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black)),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) => provider.setPc(value.toString())),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///Extra Cab request date -
// Team -
// Zone -
// PC -
// Name of employee -
// Employee mobile number:
// Pick up point -
// Whom to meet -
// Purpose of trip -
// Estimated travel km -
// Approved by -

  selectDate(BuildContext context, BookingProvider provider) {
    return Padding(
      padding: AppConstants.all_10,
      child: Row(
        children: [
          Text("Request Date:",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          AppConstants.w_20,
          InkWell(
            onTap: () => provider.showDate(context),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: AppConstants.boxRadius8),
              child: Row(
                children: [
                  AppConstants.w_10,
                  const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.black,
                  ),
                  AppConstants.w_20,
                  Text(provider.cabRDate,
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  teamName(BuildContext context, BookingProvider provider) {
    return Padding(
      padding: AppConstants.all_10,
      child: Row(
        children: [
          Text("Team Name:",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          AppConstants.w_30,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 50,
            child: TextFormField(
              controller: provider.teamName,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textCapitalization: TextCapitalization.characters,
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the Answer';
                }
                return null;
              },
              onEditingComplete: () {
                FocusScope.of(context).nextFocus();
                //addNewPeople.formKey.currentState!.validate();
              },
              textAlign: TextAlign.justify,
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              decoration: InputDecoration(
                  // contentPadding: AppConstants.all_5,
                  fillColor: Colors.white,
                  filled: true,
                  counterStyle: Theme.of(context).textTheme.bodySmall,
                  counterText: "",
                  hintText: "Enter Team Name",
                  errorStyle: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                  hintStyle: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: Colors.black),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8)),
              keyboardType: TextInputType.multiline,
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter
              ],
            ),
          )
        ],
      ),
    );
  }

  personName(BuildContext context, BookingProvider provider) {
    return Padding(
      padding: AppConstants.all_10,
      child: Row(
        children: [
          Text("Name:",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          AppConstants.w_30,
          AppConstants.w_20,
          AppConstants.w_40,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 50,
            child: TextFormField(
              controller: provider.name,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textCapitalization: TextCapitalization.characters,
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the Answer';
                }
                return null;
              },
              onEditingComplete: () {
                FocusScope.of(context).nextFocus();
                //addNewPeople.formKey.currentState!.validate();
              },
              textAlign: TextAlign.justify,
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              decoration: InputDecoration(
                  // contentPadding: AppConstants.all_5,
                  fillColor: Colors.white,
                  filled: true,
                  counterStyle: Theme.of(context).textTheme.bodySmall,
                  counterText: "",
                  hintText: "Enter Name",
                  errorStyle: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                  hintStyle: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: Colors.black),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8)),
              keyboardType: TextInputType.multiline,
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter
              ],
            ),
          )
        ],
      ),
    );
  }

  mobileNum(BuildContext context, BookingProvider provider) {
    return Padding(
      padding: AppConstants.all_10,
      child: Row(
        children: [
          Text("Number:",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          AppConstants.w_30,
          AppConstants.w_40,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 50,
            child: TextFormField(
              controller: provider.number,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textCapitalization: TextCapitalization.characters,
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the Answer';
                }
                return null;
              },
              onEditingComplete: () {
                FocusScope.of(context).nextFocus();
                //addNewPeople.formKey.currentState!.validate();
              },
              textAlign: TextAlign.justify,
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              decoration: InputDecoration(
                  // contentPadding: AppConstants.all_5,
                  fillColor: Colors.white,
                  filled: true,
                  counterStyle: Theme.of(context).textTheme.bodySmall,
                  counterText: "",
                  hintText: "Enter Number",
                  errorStyle: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                  hintStyle: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: Colors.black),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8)),
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          )
        ],
      ),
    );
  }

  selectTime(BuildContext context, BookingProvider provider) {
    return Padding(
      padding: AppConstants.all_10,
      child: Row(
        children: [
          Text("Pick-up Time:",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          AppConstants.w_20,
          InkWell(
            onTap: () => provider.selectTimer(context),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: AppConstants.boxRadius8),
              child: Row(
                children: [
                  AppConstants.w_10,
                  const Icon(
                    Icons.punch_clock_outlined,
                    color: Colors.black,
                  ),
                  AppConstants.w_20,
                  Text(provider.time,
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  pickUp(BuildContext context, BookingProvider provider) {
    return Padding(
      padding: AppConstants.all_10,
      child: Row(
        children: [
          Text("Pickup Point:",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          AppConstants.w_30,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 50,
            child: TextFormField(
              controller: provider.pickUpLocation,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textCapitalization: TextCapitalization.characters,
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the Answer';
                }
                return null;
              },
              onEditingComplete: () {
                FocusScope.of(context).nextFocus();
                //addNewPeople.formKey.currentState!.validate();
              },
              textAlign: TextAlign.justify,
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              decoration: InputDecoration(
                  // contentPadding: AppConstants.all_5,
                  fillColor: Colors.white,
                  filled: true,
                  counterStyle: Theme.of(context).textTheme.bodySmall,
                  counterText: "",
                  hintText: "Enter Pick-up Point",
                  errorStyle: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                  hintStyle: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: Colors.black),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8)),
              keyboardType: TextInputType.multiline,
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter
              ],
            ),
          )
        ],
      ),
    );
  }

  destinationLoc(BuildContext context, BookingProvider provider) {
    return Padding(
      padding: AppConstants.all_10,
      child: Row(
        children: [
          Text("Destination :",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          AppConstants.w_30,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 50,
            child: TextFormField(
              controller: provider.destination,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textCapitalization: TextCapitalization.characters,
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the Answer';
                }
                return null;
              },
              onEditingComplete: () {
                FocusScope.of(context).nextFocus();
                //addNewPeople.formKey.currentState!.validate();
              },
              textAlign: TextAlign.justify,
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              decoration: InputDecoration(
                  // contentPadding: AppConstants.all_5,
                  fillColor: Colors.white,
                  filled: true,
                  counterStyle: Theme.of(context).textTheme.bodySmall,
                  counterText: "",
                  hintText: "Enter Destination",
                  errorStyle: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                  hintStyle: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: Colors.black),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8)),
              keyboardType: TextInputType.multiline,
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter
              ],
            ),
          )
        ],
      ),
    );
  }

  purposeOFTrip(BuildContext context, BookingProvider provider) {
    return Padding(
      padding: AppConstants.all_10,
      child: Row(
        children: [
          Text("Purpose of Trip:",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          AppConstants.w_30,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 50,
            child: TextFormField(
              controller: provider.purposeOfTrip,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textCapitalization: TextCapitalization.characters,
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the Answer';
                }
                return null;
              },
              onEditingComplete: () {
                FocusScope.of(context).nextFocus();
                //addNewPeople.formKey.currentState!.validate();
              },
              textAlign: TextAlign.justify,
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              decoration: InputDecoration(
                  // contentPadding: AppConstants.all_5,
                  fillColor: Colors.white,
                  filled: true,
                  counterStyle: Theme.of(context).textTheme.bodySmall,
                  counterText: "",
                  hintText: "Enter Purpose of Trip",
                  errorStyle: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                  hintStyle: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: Colors.black),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8)),
              keyboardType: TextInputType.multiline,
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter
              ],
            ),
          )
        ],
      ),
    );
  }

  approx(BuildContext context, BookingProvider provider) {
    return Padding(
      padding: AppConstants.all_10,
      child: Row(
        children: [
          Text("Approx KM:",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          AppConstants.w_30,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 50,
            child: TextFormField(
              controller: provider.destination,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textCapitalization: TextCapitalization.characters,
              autofocus: true,
              maxLength: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the Answer';
                }
                return null;
              },
              onEditingComplete: () {
                FocusScope.of(context).nextFocus();
                //addNewPeople.formKey.currentState!.validate();
              },
              textAlign: TextAlign.justify,
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              decoration: InputDecoration(
                  // contentPadding: AppConstants.all_5,
                  fillColor: Colors.white,
                  filled: true,
                  counterStyle: Theme.of(context).textTheme.bodySmall,
                  counterText: "",
                  hintText: "Enter KM",
                  errorStyle: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                  hintStyle: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: Colors.black),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8)),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          )
        ],
      ),
    );
  }

  whomToMeet(BuildContext context, BookingProvider provider) {
    return Padding(
      padding: AppConstants.all_10,
      child: Row(
        children: [
          Text("Whom to Meet:",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          AppConstants.w_10,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 50,
            child: TextFormField(
              controller: provider.whomTOMeet,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textCapitalization: TextCapitalization.characters,
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the Answer';
                }
                return null;
              },
              onEditingComplete: () {
                FocusScope.of(context).nextFocus();
                //addNewPeople.formKey.currentState!.validate();
              },
              textAlign: TextAlign.justify,
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              decoration: InputDecoration(
                  // contentPadding: AppConstants.all_5,
                  fillColor: Colors.white,
                  filled: true,
                  counterStyle: Theme.of(context).textTheme.bodySmall,
                  counterText: "",
                  hintText: "Enter Purpose of Trip",
                  errorStyle: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                  hintStyle: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: Colors.black),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8)),
              keyboardType: TextInputType.multiline,
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter
              ],
            ),
          )
        ],
      ),
    );
  }

  approvedBY(BuildContext context, BookingProvider provider) {
    return Padding(
      padding: AppConstants.all_10,
      child: Row(
        children: [
          Text("Approved By: ",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          AppConstants.w_20,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 50,
            child: TextFormField(
              controller: provider.whomTOMeet,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textCapitalization: TextCapitalization.characters,
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the Answer';
                }
                return null;
              },
              onEditingComplete: () {
                FocusScope.of(context).nextFocus();
                //addNewPeople.formKey.currentState!.validate();
              },
              textAlign: TextAlign.justify,
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              decoration: InputDecoration(
                  // contentPadding: AppConstants.all_5,
                  fillColor: Colors.white,
                  filled: true,
                  counterStyle: Theme.of(context).textTheme.bodySmall,
                  counterText: "",
                  hintText: "Enter Purpose of Trip",
                  errorStyle: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                  hintStyle: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: Colors.black),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: AppConstants.boxRadius8)),
              keyboardType: TextInputType.multiline,
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter
              ],
            ),
          )
        ],
      ),
    );
  }
}
