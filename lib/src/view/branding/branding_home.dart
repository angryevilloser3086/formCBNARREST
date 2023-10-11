import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form/src/view/home/homescreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/branding/brand_provider.dart';
import '../../utils/app_localization.dart';
import '../../utils/app_utils.dart';

class BrandingScreen extends StatelessWidget {
  const BrandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BrandProvider(),
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
            "Branding",
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
                    opacity: const AlwaysStoppedAnimation(.5),
                  ),
                ),
              )),
              SingleChildScrollView(
                child: Column(
                  children: [
                    AppConstants.h_10,
                    Consumer<BrandProvider>(builder: (_, provider, child) {
                      if (provider.vName.text.isEmpty) {
                        provider.init();
                      }
                      return p3VNAME(context, "Name of the ACM", provider);
                    }),
                    AppConstants.h_10,
                    Consumer<BrandProvider>(builder: (_, provider, child) {
                      return p3VMail(context, "Mail of the ACM", provider);
                    }),
                    AppConstants.h_10,
                    Consumer<BrandProvider>(builder: (_, provider, child) {
                      return selectZone(context, provider);
                    }),
                    Consumer<BrandProvider>(builder: (_, provider, child) {
                      return selectPC(context, provider);
                    }),
                    Consumer<BrandProvider>(builder: (_, provider, child) {
                      return selectAC(context, provider);
                    }),
                    Consumer<BrandProvider>(builder: (_, provider, child) {
                      return selectBrandingType(context, provider);
                    }),
                    Selector<BrandProvider, String>(
                        builder: (context, val, child) {
                          if (val == "Posters") {
                            return Consumer<BrandProvider>(
                                builder: (_, provider, child) {
                              return nooFPosters(context, provider);
                            });
                          } else if (val == "Wall Painting") {
                            return Consumer<BrandProvider>(
                                builder: (_, provider, child) {
                              return siteType(context, provider);
                            });
                          } else if (val == 'Hoarding') {
                            return Consumer<BrandProvider>(
                                builder: (_, provider, child) {
                              return hoardingDetails(context, provider);
                            });
                          } else {
                            return Container();
                          }
                        },
                        selector: (p0, p1) => p1.typeOfBranding),
                    Selector<BrandProvider, String>(
                        builder: (context, val, child) {
                          if (val == "Private Property") {
                            return Consumer<BrandProvider>(
                                builder: (_, provider, child) {
                              if (provider.typeOfBranding == "Wall Painting") {
                                return wallPainting(context, provider);
                              } else {
                                return Container();
                              }
                            });
                          } else {
                            return Container();
                          }
                        },
                        selector: (p0, p1) => p1.siteType),
                    Consumer<BrandProvider>(builder: (_, provider, child) {
                      return getLocation(context, provider);
                    }),
                    Selector<BrandProvider, String>(
                        builder: (context, val, child) {
                          if (val == 'Posters') {
                            return Consumer<BrandProvider>(
                                builder: (_, provider, child) {
                              return landmark(context, provider);
                            });
                          } else {
                            return Container();
                          }
                        },
                        selector: (p0, p1) => p1.typeOfBranding),
                    Consumer<BrandProvider>(builder: (_, provider, child) {
                      return uploadPICS(context, provider);
                    }),
                    Selector<BrandProvider, String>(
                        builder: (context, val, child) {
                          if (val == 'Posters') {
                            return Consumer<BrandProvider>(
                                builder: (_, provider, child) {
                              return siteType(context, provider);
                            });
                          } else {
                            return Container();
                          }
                        },
                        selector: (p0, p1) => p1.typeOfBranding),
                    Consumer<BrandProvider>(builder: (_, provider, child) {
                      return areaType(context, provider);
                    }),
                    AppConstants.h_30,
                    Selector<BrandProvider, bool>(
                        builder: (context, val, child) {
                          if (val) {
                            return Consumer<BrandProvider>(
                                builder: (_, provider, child) {
                              return InkWell(
                                onTap: () => provider.submitDetails(context),
                                child: btn(context, "Submit"),
                              );
                            });
                          } else {
                            return Container();
                          }
                        },
                        selector: (p0, p1) => p1.enableBTN),
                    AppConstants.h_30,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  p3VNAME(BuildContext context, String title, BrandProvider provider) {
    return Card(
      elevation: 10,
      color: AppConstants.appSTCColor,
      child: Padding(
        padding: AppConstants.all_5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(title,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: 75,
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                controller: provider.vName,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textCapitalization: TextCapitalization.sentences,
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
                    hintText: "Enter Answer",
                    errorStyle: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.red),
                    hintStyle: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: Colors.black),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppConstants.appBgLite),
                        borderRadius: AppConstants.boxRadius8),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppConstants.appBgLite),
                        borderRadius: AppConstants.boxRadius8),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppConstants.appBgLite),
                        borderRadius: AppConstants.boxRadius8)),
                keyboardType: TextInputType.multiline,

                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter
                ],
                //controller: addNewPeople.fnameController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  p3VMail(BuildContext context, String title, BrandProvider provider) {
    return Card(
      color: AppConstants.appSTCColor,
      elevation: 10,
      child: Padding(
        padding: AppConstants.all_5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(title,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: 75,
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                controller: provider.vMail,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textCapitalization: TextCapitalization.sentences,
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
                    hintText: "Enter Answer",
                    errorStyle: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.red),
                    hintStyle: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: Colors.black),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppConstants.appBgLite),
                        borderRadius: AppConstants.boxRadius8),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppConstants.appBgLite),
                        borderRadius: AppConstants.boxRadius8),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppConstants.appBgLite),
                        borderRadius: AppConstants.boxRadius8)),
                keyboardType: TextInputType.multiline,

                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter
                ],
                //controller: addNewPeople.fnameController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  selectZone(BuildContext context, BrandProvider provider) {
    return Card(
      elevation: 10,
      color: AppConstants.appSTCColor,
      child: Padding(
        padding: AppConstants.all_5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(Strings.of(context).zone,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
            ),
            AppConstants.h_10,
            Padding(
              padding: AppConstants.all_5,
              child: Container(
                width: MediaQuery.of(context).size.width,
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
      ),
    );
  }

  selectPC(BuildContext context, BrandProvider provider) {
    return Card(
      elevation: 10,
      color: AppConstants.appSTCColor,
      child: Padding(
        padding: AppConstants.all_5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(Strings.of(context).pC,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
            ),
            AppConstants.h_10,
            Padding(
              padding: AppConstants.all_5,
              child: Container(
                width: MediaQuery.of(context).size.width,
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
      ),
    );
  }

  selectAC(BuildContext context, BrandProvider provider) {
    return Card(
      elevation: 10,
      color: AppConstants.appSTCColor,
      child: Padding(
        padding: AppConstants.all_5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(Strings.of(context).aC,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
            ),
            AppConstants.h_10,
            Padding(
              padding: AppConstants.all_5,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: AppConstants.boxBorderDecoration2,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      dropdownColor: Colors.white,
                      borderRadius: AppConstants.boxRadius8,
                      iconDisabledColor: Colors.black,
                      iconEnabledColor: Colors.black,
                      isExpanded: true,
                      value: provider.sAc.isEmpty
                          ? provider.sendPcAc(provider.sPc).first
                          : provider.sAc,
                      items: provider
                          .sendPcAc(provider.sPc)
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
                      onChanged: (value) => provider.setAc(value.toString())),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  selectBrandingType(BuildContext context, BrandProvider provider) {
    return Card(
      elevation: 10,
      color: AppConstants.appSTCColor,
      child: Padding(
        padding: AppConstants.all_5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(Strings.of(context).brandingType,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
            ),
            AppConstants.h_10,
            Padding(
              padding: AppConstants.all_5,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: AppConstants.boxBorderDecoration2,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      dropdownColor: Colors.white,
                      borderRadius: AppConstants.boxRadius8,
                      iconDisabledColor: Colors.black,
                      iconEnabledColor: Colors.black,
                      isExpanded: true,
                      value: provider.typeOfBranding.isEmpty
                          ? provider.brandingTypes.first
                          : provider.typeOfBranding,
                      items: provider.brandingTypes
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
                      onChanged: (value) =>
                          provider.setBranding(value.toString())),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getLocation(BuildContext context, BrandProvider provider) {
    return Card(
      elevation: 10,
      color: AppConstants.appSTCColor,
      child: Padding(
        padding: AppConstants.all_5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(Strings.of(context).location,
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => provider.initLocationSearch(context),
                  child: btn(context, "Get Location"),
                ),
                AppConstants.w_5
              ],
            ),
            AppConstants.h_10,
            if (provider.locate.isNotEmpty)
              Padding(
                padding: AppConstants.all_5,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: AppConstants.boxBorderDecoration2,
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: Text(provider.locate,
                                maxLines: 5,
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ],
                    )),
              ),
          ],
        ),
      ),
    );
  }

  btn(BuildContext context, String title) {
    return Center(
      child: Container(
        width: 150,
        height: 50,
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  uploadPICS(BuildContext context, BrandProvider provider) {
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
            if (provider.pics.isNotEmpty)
              GridView.count(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                controller: provider.scrollController,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                children: List.generate(
                  provider.pics.length,
                  (index) => Container(
                    color: Colors.white,
                    height: 150,
                    child: Image.network(provider.pics[index]),
                  ),
                ),
              ),
            AppConstants.h_10,
            InkWell(
              onTap: () {
                if (provider.pics.isEmpty || provider.pics.length < 3) {
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
            )
          ],
        ),
      ),
    );
  }

  siteType(BuildContext context, BrandProvider provider) {
    return Card(
      elevation: 10,
      color: AppConstants.appSTCColor,
      child: Padding(
        padding: AppConstants.all_5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(Strings.of(context).siteType,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
            ),
            AppConstants.h_10,
            Padding(
              padding: AppConstants.all_5,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: AppConstants.boxBorderDecoration2,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      dropdownColor: Colors.white,
                      borderRadius: AppConstants.boxRadius8,
                      iconDisabledColor: Colors.black,
                      iconEnabledColor: Colors.black,
                      isExpanded: true,
                      value: provider.siteType.isEmpty
                          ? provider.siteTypes.first
                          : provider.siteType,
                      items: provider.siteTypes
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
                      onChanged: (value) =>
                          provider.setSiteType(value.toString())),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  areaType(BuildContext context, BrandProvider provider) {
    return Card(
      elevation: 10,
      color: AppConstants.appSTCColor,
      child: Padding(
        padding: AppConstants.all_5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(Strings.of(context).areaType,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
            ),
            AppConstants.h_10,
            Padding(
              padding: AppConstants.all_5,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: AppConstants.boxBorderDecoration2,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      dropdownColor: Colors.white,
                      borderRadius: AppConstants.boxRadius8,
                      iconDisabledColor: Colors.black,
                      iconEnabledColor: Colors.black,
                      isExpanded: true,
                      value: provider.areaType.isEmpty
                          ? provider.areaTypes.first
                          : provider.areaType,
                      items: provider.areaTypes
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
                      onChanged: (value) =>
                          provider.setAreaType(value.toString())),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  nooFPosters(BuildContext context, BrandProvider provider) {
    return Card(
      elevation: 10,
      color: AppConstants.appSTCColor,
      child: Padding(
        padding: AppConstants.all_5,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text("Appropriate number of Posters can be pasted:",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
            ),
            AppConstants.h_10,
            SizedBox(
              height: 75,
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                controller: provider.noPosters,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textCapitalization: TextCapitalization.sentences,
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
                    hintText: "Enter Answer",
                    errorStyle: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.red),
                    hintStyle: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: Colors.black),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppConstants.appBgLite),
                        borderRadius: AppConstants.boxRadius8),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppConstants.appBgLite),
                        borderRadius: AppConstants.boxRadius8),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppConstants.appBgLite),
                        borderRadius: AppConstants.boxRadius8)),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
          ],
        ),
      ),
    );
  }

  landmark(BuildContext context, BrandProvider provider) {
    return Card(
      elevation: 10,
      color: AppConstants.appSTCColor,
      child: Padding(
        padding: AppConstants.all_5,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text("Landmark",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
            ),
            AppConstants.h_10,
            SizedBox(
              height: 75,
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                controller: provider.landmark,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textCapitalization: TextCapitalization.sentences,
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
                    hintText: "e.g. Near Old Post office etc.,",
                    errorStyle: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.red),
                    hintStyle: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: Colors.black),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppConstants.appBgLite),
                        borderRadius: AppConstants.boxRadius8),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppConstants.appBgLite),
                        borderRadius: AppConstants.boxRadius8),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppConstants.appBgLite),
                        borderRadius: AppConstants.boxRadius8)),
                keyboardType: TextInputType.multiline,
                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  hoardingDetails(BuildContext context, BrandProvider provider) {
    return Card(
      elevation: 10,
      color: AppConstants.appSTCColor,
      child: Padding(
        padding: AppConstants.all_5,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text("Hoarding Details:",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
            ),
            AppConstants.h_10,
            Column(
              children: [
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Length: ",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: TextFormField(
                        controller: provider.len,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textCapitalization: TextCapitalization.sentences,
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
                            hintText: "Enter Answer",
                            errorStyle: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Colors.red),
                            hintStyle: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w200,
                                color: Colors.black),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppConstants.appBgLite),
                                borderRadius: AppConstants.boxRadius8),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppConstants.appBgLite),
                                borderRadius: AppConstants.boxRadius8),
                            border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppConstants.appBgLite),
                                borderRadius: AppConstants.boxRadius8)),
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalInputFormatter()],
                        //controller: addNewPeople.fnameController,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(" \"ft",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                AppConstants.h_5,
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Width:   ",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: TextFormField(
                        controller: provider.width,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textCapitalization: TextCapitalization.sentences,
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
                            hintText: "Enter Answer",
                            errorStyle: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Colors.red),
                            hintStyle: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w200,
                                color: Colors.black),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppConstants.appBgLite),
                                borderRadius: AppConstants.boxRadius8),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppConstants.appBgLite),
                                borderRadius: AppConstants.boxRadius8),
                            border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppConstants.appBgLite),
                                borderRadius: AppConstants.boxRadius8)),
                        keyboardType: TextInputType.number,
                        inputFormatters: [DecimalInputFormatter()],
                        //controller: addNewPeople.fnameController,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(" \"ft",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: AppConstants.all_5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Aggregator Name:",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(
                    height: 75,
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller: provider.hName,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textCapitalization: TextCapitalization.sentences,
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
                          hintText: "Enter Answer",
                          errorStyle: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.red),
                          hintStyle: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w200,
                              color: Colors.black),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppConstants.appBgLite),
                              borderRadius: AppConstants.boxRadius8),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppConstants.appBgLite),
                              borderRadius: AppConstants.boxRadius8),
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppConstants.appBgLite),
                              borderRadius: AppConstants.boxRadius8)),
                      keyboardType: TextInputType.multiline,

                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                      //controller: addNewPeople.fnameController,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: AppConstants.all_5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Aggregator Number:",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(
                    height: 75,
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller: provider.hNum,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textCapitalization: TextCapitalization.sentences,
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
                          hintText: "Enter Answer",
                          errorStyle: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.red),
                          hintStyle: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w200,
                              color: Colors.black),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppConstants.appBgLite),
                              borderRadius: AppConstants.boxRadius8),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppConstants.appBgLite),
                              borderRadius: AppConstants.boxRadius8),
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppConstants.appBgLite),
                              borderRadius: AppConstants.boxRadius8)),
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      //controller: addNewPeople.fnameController,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  wallPainting(BuildContext context, BrandProvider provider) {
    return Card(
      elevation: 10,
      color: AppConstants.appSTCColor,
      child: Padding(
        padding: AppConstants.all_5,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text("Property Details:",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
            ),
            AppConstants.h_10,
            Padding(
              padding: AppConstants.all_5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Name Of the Owner:",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(
                    height: 75,
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller: provider.pName,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textCapitalization: TextCapitalization.sentences,
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
                          hintText: "Enter Answer",
                          errorStyle: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.red),
                          hintStyle: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w200,
                              color: Colors.black),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppConstants.appBgLite),
                              borderRadius: AppConstants.boxRadius8),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppConstants.appBgLite),
                              borderRadius: AppConstants.boxRadius8),
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppConstants.appBgLite),
                              borderRadius: AppConstants.boxRadius8)),
                      keyboardType: TextInputType.multiline,

                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                      //controller: addNewPeople.fnameController,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: AppConstants.all_5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Number Of the Owner:",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(
                    height: 75,
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller: provider.pNum,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textCapitalization: TextCapitalization.sentences,
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
                          hintText: "Enter Answer",
                          errorStyle: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.red),
                          hintStyle: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w200,
                              color: Colors.black),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppConstants.appBgLite),
                              borderRadius: AppConstants.boxRadius8),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppConstants.appBgLite),
                              borderRadius: AppConstants.boxRadius8),
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppConstants.appBgLite),
                              borderRadius: AppConstants.boxRadius8)),
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      //controller: addNewPeople.fnameController,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DecimalInputFormatter extends TextInputFormatter {
  final RegExp _regex = RegExp(r'^\d{0,3}(\.\d{0,2})?$');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (_regex.hasMatch(newValue.text)) {
      return newValue;
    } else {
      // Reject the input if it doesn't match the regex
      return oldValue;
    }
  }
}
