class Branding {
  String? vName;
  String? vMail;
  String? zone;
  String? pc;
  String? ac;
  String? location;
  String? longitude;
  String? latitude;
  String? brandType;
  Map<String, dynamic>? hoarding;
  Map<String, dynamic>? pvtWall;
  String? noOfPoster;
  List<String>? bBranding;
  List<String>? aBranding;
  String? siteType;
  String? landmark;
  String? areaType;
  String? date;
  
  Branding(
      {required this.vName,
      required this.vMail,
      required this.zone,
      required this.pc,
      required this.ac,
      required this.brandType,
      this.hoarding,
      this.noOfPoster,
      this.pvtWall,
      required this.location,
      required this.longitude,
      required this.latitude,
      required this.bBranding,
      required this.aBranding,
      required this.siteType,
    required this.landmark,
      required this.areaType,
      required this.date});

  factory Branding.fromJson(Map<String, dynamic> json) => Branding(
      vName: json['volunteer_name'],
      vMail: json['volunteer_mail'],
      zone: json['zone'],
      pc: json['pc'],
      ac: json['ac'],
      location: json['location'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      bBranding: json['before_branding'],
      aBranding: json['after_branding'],
      siteType: json['site_type'],
      areaType: json['area_type'],
      date: json['date'],
      brandType: json['type_of_branding'],
      pvtWall: json['pvt_wall_details'],
      hoarding: json['hoarding_details'], landmark: json['landamrk']);

  Map<String, dynamic> toJson() => {
        'volunteer_name': vName,
        'volunteer_mail': vMail,
        'zone': zone,
        'pc': pc,
        'ac': ac,
        'location': location,
        'type_of_branding': brandType,
        'hoarding_details': hoarding,
        'pvt_wall_details': pvtWall,
        'no_posters': noOfPoster,
        'latitude': latitude,
        'longitude': longitude,
        'before_branding': bBranding,
        'after_branding': aBranding,
        'site_type': siteType,
        'landmark':landmark,
        'area_type': areaType,
        'date': date
      };
}
