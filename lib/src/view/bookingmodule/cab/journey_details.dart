import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form/src/view/bookingmodule/list_req/requests.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../provider/booking/journey_provider.dart';
import '../../../utils/app_utils.dart';
import 'map_screen.dart';

class JourneyDetails extends StatelessWidget {
  const JourneyDetails({super.key, required this.destination});
  final String destination;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => JourneyProvider(),
      child: Scaffold(
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
        body: cabRequest(context),
      ),
    );
  }

  cabRequest(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: Provider.of<JourneyProvider>(context).formKey,
        child: Column(
          children: [
            AppConstants.h_10,
            AppConstants.h_10,
            AppConstants.h_10,
            Consumer<JourneyProvider>(builder: (_, provider, child) {
              if (provider.emp == null) {
                provider.initData();
              }
              return personName(context, provider);
            }),
            Consumer<JourneyProvider>(builder: (_, provider, child) {
              return empCode(context, provider);
            }),
            Consumer<JourneyProvider>(builder: (_, provider, child) {
              return teamName(context, provider);
            }),
            Consumer<JourneyProvider>(builder: (_, provider, child) {
              return managerName(context, provider);
            }),
            Consumer<JourneyProvider>(builder: (_, provider, child) {
              return pickUpPoint(context, provider);
            }),
            Consumer<JourneyProvider>(builder: (_, provider, child) {
              return dName(context, provider);
            }),
            Consumer<JourneyProvider>(builder: (_, provider, child) {
              return dNumber(context, provider);
            }),
            Consumer<JourneyProvider>(builder: (_, provider, child) {
              return vNumber(context, provider);
            }),
            Consumer<JourneyProvider>(builder: (_, provider, child) {
              return selectVTYPE(context, provider);
            }),
            Consumer<JourneyProvider>(builder: (_, provider, child) {
              return uploadPICS(context, provider);
            }),
            Selector<JourneyProvider, String>(
                builder: (_, p, child) {
                  return Consumer<JourneyProvider>(
                      builder: (context, provider, child) {
                    return odoMeterReading(context, provider);
                  });
                },
                selector: ((p0, p1) => p1.odoMeter)),
            AppConstants.h_30,
            Consumer<JourneyProvider>(builder: (context, provider, child) {
              return InkWell(
                onTap: () => provider.updateLat(context, destination),
                child: btn(context, 250, Colors.black, "Start Journey"),
              );
            }),
            AppConstants.h_24
          ],
        ),
      ),
    );
  }

  teamName(BuildContext context, JourneyProvider provider) {
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

  personName(BuildContext context, JourneyProvider provider) {
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

  empCode(BuildContext context, JourneyProvider provider) {
    return Padding(
      padding: AppConstants.all_10,
      child: Row(
        children: [
          Text("Employee Code:",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          AppConstants.w_30,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 50,
            child: TextFormField(
              controller: provider.empCode,
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
                  hintText: "Enter Employee code",
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

  managerName(BuildContext context, JourneyProvider provider) {
    return Padding(
      padding: AppConstants.all_10,
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: Text("Name of Reporting Manager:",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 50,
            child: TextFormField(
              controller: provider.managerName,
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

  pickUpPoint(BuildContext context, JourneyProvider provider) {
    return Padding(
      padding: AppConstants.all_10,
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text("Enter the Pick-up Point:",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
          ),
          AppConstants.w_30,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 50,
            child: TextFormField(
              controller: provider.startingPoint,
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
                  hintText: "Enter Pick-up point",
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

  uploadPICS(BuildContext context, JourneyProvider provider) {
    //log("${provider.pics.length}:lentgh::${provider.index}:index");
    return Card(
      elevation: 10,
      color: AppConstants.appSTCColor,
      child: Padding(
        padding: AppConstants.all_5,
        child: Column(
          children: [
            Text("Upload Pictures",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500)),
            if (provider.img.isNotEmpty) AppConstants.h_10,
            InkWell(
              onTap: () {
                if (provider.img.isEmpty) {
                  provider.getCamera(context);
                } else {
                  AppConstants.showSnackBar(context, "Pictures limit reached");
                }
              },
              child: Container(
                color: Colors.white,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                    ),
                    AppConstants.w_5,
                    Text("Click here to take picture",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            if (provider.img.isNotEmpty)
              SizedBox(
                child: Image.network(provider.img),
              )
          ],
        ),
      ),
    );
  }

  odoMeterReading(BuildContext context, JourneyProvider provider) {
    return Padding(
      padding: AppConstants.all_10,
      child: Row(
        children: [
          SizedBox(
            child: Text("Odo Meter Reading:",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
          ),
          AppConstants.w_5,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 50,
            child: TextFormField(
              controller: provider.odoReading,
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
                  hintText: "Enter ODO meter reading",
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

  selectVTYPE(BuildContext context, JourneyProvider provider) {
    return Padding(
      padding: AppConstants.all_10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text("Vehicle Type:",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500)),
          ),
          AppConstants.w_15,
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
                    value: provider.sVType.isEmpty
                        ? provider.vType.first
                        : provider.sVType,
                    items: provider.vType
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
                    onChanged: (value) => provider.setVType(value.toString())),
              ),
            ),
          ),
        ],
      ),
    );
  }

  dName(BuildContext context, JourneyProvider provider) {
    return Padding(
      padding: AppConstants.all_10,
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text("Driver name",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
          ),
          AppConstants.w_30,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 50,
            child: TextFormField(
              controller: provider.dName,
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
                  hintText: "Enter Driver Name",
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

  dNumber(BuildContext context, JourneyProvider provider) {
    return Padding(
      padding: AppConstants.all_10,
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text("Driver number",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
          ),
          AppConstants.w_30,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 50,
            child: TextFormField(
              controller: provider.dNumber,
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
                  hintText: "Enter Driver Number",
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

  vNumber(BuildContext context, JourneyProvider provider) {
    return Padding(
      padding: AppConstants.all_10,
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text("Vehicle number",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
          ),
          AppConstants.w_30,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 50,
            child: TextFormField(
              controller: provider.vNumber,
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
                  hintText: "Enter Vehicle Number",
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

///Driver Name:
// Driver Mobile Number:
// Vehicle Number:
// Vehicle Type: 
