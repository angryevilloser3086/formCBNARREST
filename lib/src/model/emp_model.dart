class Employee {
  dynamic number;
  String? ofcMail;
  String? empID;
  String? name;
  int? sNo;
  String? dept;
  String? designation;

  Employee(
      {this.number,
      this.ofcMail,
      this.empID,
      this.name,
      this.sNo,
      this.dept,
      this.designation});

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        number: json['number'],
        ofcMail: json['ofc_mail'],
        empID: json['empID'],
        name: json['name'],
        sNo: json['S.No'],
        dept: json['dept'],
        designation: json['designation'],
      );

  Map<String, dynamic> toJson() => {
        'number': number,
        'ofc_mail': ofcMail,
        'empID': empID,
        'name': name,
        'S.No': sNo,
        'dept': dept,
        'designation': designation,
      };
}
