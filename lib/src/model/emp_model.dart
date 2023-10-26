class Employee {
  dynamic number;
  String? ofcMail;
  String? empID;
  String? name;
  int? sNo;
  String? dept;
  String level;
  String? designation;

  Employee(
      {required this.number,
      required this.ofcMail,
      required this.empID,
      required this.name,
      this.sNo,
      required this.dept,
      required this.designation,
      required this.level});

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
      number: json['number'],
      ofcMail: json['ofc_mail'],
      empID: json['empID'],
      name: json['name'],
      sNo: json['S . No'],
      dept: json['dept'],
      designation: json['designation'],
      level: json['level']);

  Map<String, dynamic> toJson() => {
        'number': number,
        'ofc_mail': ofcMail,
        'empID': empID,
        'name': name,
        'S.No': sNo,
        'dept': dept,
        'designation': designation,
        'level': level
      };
}
