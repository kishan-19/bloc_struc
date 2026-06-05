import 'dart:convert';
/// success : 1
/// message : "Logged In."
/// user : {"user_id":"101","name":"Mourieen Simon Rathod","firstname":"Mourieen","email":"mourieen.rathod@arron.in","phone":"7227054239","role":"hr","role_id":"2","code":"177","attendance_display":"1","payable_attendance":"1","joining_date":"1696962600","designation_id":"56","designation_name":"Sr. HR and Corporate Communications Manager","department_id":"2","anniversary_date":"","birthdate":"1990-06-05","profile_pic":"https://hr.arroninsurance.in/api//assets/uploads/profiles/1726065640-MOURIEEN_IMAGE.jpg","attendance_punching":0,"payable_salary_display":"0","token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEwMSIsInRva2VuX3ZlcnNpb24iOiIxMiIsIkFQSV9USU1FIjoxNzgwNjQyNDkxfQ.5D-IU77GvMRfVeodELXtTGLKW_1uwr-fjF4Xwrpab1E","in_time":"","out_time":"","total_duration":"0","access":{"dashboard":1,"employees":1,"manage_salaries":1,"payable_salaries":1,"attendance":1,"shifts_timing":1,"leave_request":1,"holidays":1,"leave_salary_deduction_information":1,"designations":1,"departments":1,"employee_punching":1,"events":1,"circular_notices":1,"social_media":1}}

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));
String loginModelToJson(LoginModel data) => json.encode(data.toJson());
class LoginModel {
  LoginModel({
      num? success, 
      String? message, 
      User? user,}){
    _success = success;
    _message = message;
    _user = user;
}

  LoginModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  num? _success;
  String? _message;
  User? _user;
LoginModel copyWith({  num? success,
  String? message,
  User? user,
}) => LoginModel(  success: success ?? _success,
  message: message ?? _message,
  user: user ?? _user,
);
  num? get success => _success;
  String? get message => _message;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

/// user_id : "101"
/// name : "Mourieen Simon Rathod"
/// firstname : "Mourieen"
/// email : "mourieen.rathod@arron.in"
/// phone : "7227054239"
/// role : "hr"
/// role_id : "2"
/// code : "177"
/// attendance_display : "1"
/// payable_attendance : "1"
/// joining_date : "1696962600"
/// designation_id : "56"
/// designation_name : "Sr. HR and Corporate Communications Manager"
/// department_id : "2"
/// anniversary_date : ""
/// birthdate : "1990-06-05"
/// profile_pic : "https://hr.arroninsurance.in/api//assets/uploads/profiles/1726065640-MOURIEEN_IMAGE.jpg"
/// attendance_punching : 0
/// payable_salary_display : "0"
/// token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEwMSIsInRva2VuX3ZlcnNpb24iOiIxMiIsIkFQSV9USU1FIjoxNzgwNjQyNDkxfQ.5D-IU77GvMRfVeodELXtTGLKW_1uwr-fjF4Xwrpab1E"
/// in_time : ""
/// out_time : ""
/// total_duration : "0"
/// access : {"dashboard":1,"employees":1,"manage_salaries":1,"payable_salaries":1,"attendance":1,"shifts_timing":1,"leave_request":1,"holidays":1,"leave_salary_deduction_information":1,"designations":1,"departments":1,"employee_punching":1,"events":1,"circular_notices":1,"social_media":1}

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      String? userId, 
      String? name, 
      String? firstname, 
      String? email, 
      String? phone, 
      String? role, 
      String? roleId, 
      String? code, 
      String? attendanceDisplay, 
      String? payableAttendance, 
      String? joiningDate, 
      String? designationId, 
      String? designationName, 
      String? departmentId, 
      String? anniversaryDate, 
      String? birthdate, 
      String? profilePic, 
      num? attendancePunching, 
      String? payableSalaryDisplay, 
      String? token, 
      String? inTime, 
      String? outTime, 
      String? totalDuration, 
      Access? access,}){
    _userId = userId;
    _name = name;
    _firstname = firstname;
    _email = email;
    _phone = phone;
    _role = role;
    _roleId = roleId;
    _code = code;
    _attendanceDisplay = attendanceDisplay;
    _payableAttendance = payableAttendance;
    _joiningDate = joiningDate;
    _designationId = designationId;
    _designationName = designationName;
    _departmentId = departmentId;
    _anniversaryDate = anniversaryDate;
    _birthdate = birthdate;
    _profilePic = profilePic;
    _attendancePunching = attendancePunching;
    _payableSalaryDisplay = payableSalaryDisplay;
    _token = token;
    _inTime = inTime;
    _outTime = outTime;
    _totalDuration = totalDuration;
    _access = access;
}

  User.fromJson(dynamic json) {
    _userId = json['user_id'];
    _name = json['name'];
    _firstname = json['firstname'];
    _email = json['email'];
    _phone = json['phone'];
    _role = json['role'];
    _roleId = json['role_id'];
    _code = json['code'];
    _attendanceDisplay = json['attendance_display'];
    _payableAttendance = json['payable_attendance'];
    _joiningDate = json['joining_date'];
    _designationId = json['designation_id'];
    _designationName = json['designation_name'];
    _departmentId = json['department_id'];
    _anniversaryDate = json['anniversary_date'];
    _birthdate = json['birthdate'];
    _profilePic = json['profile_pic'];
    _attendancePunching = json['attendance_punching'];
    _payableSalaryDisplay = json['payable_salary_display'];
    _token = json['token'];
    _inTime = json['in_time'];
    _outTime = json['out_time'];
    _totalDuration = json['total_duration'];
    _access = json['access'] != null ? Access.fromJson(json['access']) : null;
  }
  String? _userId;
  String? _name;
  String? _firstname;
  String? _email;
  String? _phone;
  String? _role;
  String? _roleId;
  String? _code;
  String? _attendanceDisplay;
  String? _payableAttendance;
  String? _joiningDate;
  String? _designationId;
  String? _designationName;
  String? _departmentId;
  String? _anniversaryDate;
  String? _birthdate;
  String? _profilePic;
  num? _attendancePunching;
  String? _payableSalaryDisplay;
  String? _token;
  String? _inTime;
  String? _outTime;
  String? _totalDuration;
  Access? _access;
User copyWith({  String? userId,
  String? name,
  String? firstname,
  String? email,
  String? phone,
  String? role,
  String? roleId,
  String? code,
  String? attendanceDisplay,
  String? payableAttendance,
  String? joiningDate,
  String? designationId,
  String? designationName,
  String? departmentId,
  String? anniversaryDate,
  String? birthdate,
  String? profilePic,
  num? attendancePunching,
  String? payableSalaryDisplay,
  String? token,
  String? inTime,
  String? outTime,
  String? totalDuration,
  Access? access,
}) => User(  userId: userId ?? _userId,
  name: name ?? _name,
  firstname: firstname ?? _firstname,
  email: email ?? _email,
  phone: phone ?? _phone,
  role: role ?? _role,
  roleId: roleId ?? _roleId,
  code: code ?? _code,
  attendanceDisplay: attendanceDisplay ?? _attendanceDisplay,
  payableAttendance: payableAttendance ?? _payableAttendance,
  joiningDate: joiningDate ?? _joiningDate,
  designationId: designationId ?? _designationId,
  designationName: designationName ?? _designationName,
  departmentId: departmentId ?? _departmentId,
  anniversaryDate: anniversaryDate ?? _anniversaryDate,
  birthdate: birthdate ?? _birthdate,
  profilePic: profilePic ?? _profilePic,
  attendancePunching: attendancePunching ?? _attendancePunching,
  payableSalaryDisplay: payableSalaryDisplay ?? _payableSalaryDisplay,
  token: token ?? _token,
  inTime: inTime ?? _inTime,
  outTime: outTime ?? _outTime,
  totalDuration: totalDuration ?? _totalDuration,
  access: access ?? _access,
);
  String? get userId => _userId;
  String? get name => _name;
  String? get firstname => _firstname;
  String? get email => _email;
  String? get phone => _phone;
  String? get role => _role;
  String? get roleId => _roleId;
  String? get code => _code;
  String? get attendanceDisplay => _attendanceDisplay;
  String? get payableAttendance => _payableAttendance;
  String? get joiningDate => _joiningDate;
  String? get designationId => _designationId;
  String? get designationName => _designationName;
  String? get departmentId => _departmentId;
  String? get anniversaryDate => _anniversaryDate;
  String? get birthdate => _birthdate;
  String? get profilePic => _profilePic;
  num? get attendancePunching => _attendancePunching;
  String? get payableSalaryDisplay => _payableSalaryDisplay;
  String? get token => _token;
  String? get inTime => _inTime;
  String? get outTime => _outTime;
  String? get totalDuration => _totalDuration;
  Access? get access => _access;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['name'] = _name;
    map['firstname'] = _firstname;
    map['email'] = _email;
    map['phone'] = _phone;
    map['role'] = _role;
    map['role_id'] = _roleId;
    map['code'] = _code;
    map['attendance_display'] = _attendanceDisplay;
    map['payable_attendance'] = _payableAttendance;
    map['joining_date'] = _joiningDate;
    map['designation_id'] = _designationId;
    map['designation_name'] = _designationName;
    map['department_id'] = _departmentId;
    map['anniversary_date'] = _anniversaryDate;
    map['birthdate'] = _birthdate;
    map['profile_pic'] = _profilePic;
    map['attendance_punching'] = _attendancePunching;
    map['payable_salary_display'] = _payableSalaryDisplay;
    map['token'] = _token;
    map['in_time'] = _inTime;
    map['out_time'] = _outTime;
    map['total_duration'] = _totalDuration;
    if (_access != null) {
      map['access'] = _access?.toJson();
    }
    return map;
  }

}

/// dashboard : 1
/// employees : 1
/// manage_salaries : 1
/// payable_salaries : 1
/// attendance : 1
/// shifts_timing : 1
/// leave_request : 1
/// holidays : 1
/// leave_salary_deduction_information : 1
/// designations : 1
/// departments : 1
/// employee_punching : 1
/// events : 1
/// circular_notices : 1
/// social_media : 1

Access accessFromJson(String str) => Access.fromJson(json.decode(str));
String accessToJson(Access data) => json.encode(data.toJson());
class Access {
  Access({
      num? dashboard, 
      num? employees, 
      num? manageSalaries, 
      num? payableSalaries, 
      num? attendance, 
      num? shiftsTiming, 
      num? leaveRequest, 
      num? holidays, 
      num? leaveSalaryDeductionInformation, 
      num? designations, 
      num? departments, 
      num? employeePunching, 
      num? events, 
      num? circularNotices, 
      num? socialMedia,}){
    _dashboard = dashboard;
    _employees = employees;
    _manageSalaries = manageSalaries;
    _payableSalaries = payableSalaries;
    _attendance = attendance;
    _shiftsTiming = shiftsTiming;
    _leaveRequest = leaveRequest;
    _holidays = holidays;
    _leaveSalaryDeductionInformation = leaveSalaryDeductionInformation;
    _designations = designations;
    _departments = departments;
    _employeePunching = employeePunching;
    _events = events;
    _circularNotices = circularNotices;
    _socialMedia = socialMedia;
}

  Access.fromJson(dynamic json) {
    _dashboard = json['dashboard'];
    _employees = json['employees'];
    _manageSalaries = json['manage_salaries'];
    _payableSalaries = json['payable_salaries'];
    _attendance = json['attendance'];
    _shiftsTiming = json['shifts_timing'];
    _leaveRequest = json['leave_request'];
    _holidays = json['holidays'];
    _leaveSalaryDeductionInformation = json['leave_salary_deduction_information'];
    _designations = json['designations'];
    _departments = json['departments'];
    _employeePunching = json['employee_punching'];
    _events = json['events'];
    _circularNotices = json['circular_notices'];
    _socialMedia = json['social_media'];
  }
  num? _dashboard;
  num? _employees;
  num? _manageSalaries;
  num? _payableSalaries;
  num? _attendance;
  num? _shiftsTiming;
  num? _leaveRequest;
  num? _holidays;
  num? _leaveSalaryDeductionInformation;
  num? _designations;
  num? _departments;
  num? _employeePunching;
  num? _events;
  num? _circularNotices;
  num? _socialMedia;
Access copyWith({  num? dashboard,
  num? employees,
  num? manageSalaries,
  num? payableSalaries,
  num? attendance,
  num? shiftsTiming,
  num? leaveRequest,
  num? holidays,
  num? leaveSalaryDeductionInformation,
  num? designations,
  num? departments,
  num? employeePunching,
  num? events,
  num? circularNotices,
  num? socialMedia,
}) => Access(  dashboard: dashboard ?? _dashboard,
  employees: employees ?? _employees,
  manageSalaries: manageSalaries ?? _manageSalaries,
  payableSalaries: payableSalaries ?? _payableSalaries,
  attendance: attendance ?? _attendance,
  shiftsTiming: shiftsTiming ?? _shiftsTiming,
  leaveRequest: leaveRequest ?? _leaveRequest,
  holidays: holidays ?? _holidays,
  leaveSalaryDeductionInformation: leaveSalaryDeductionInformation ?? _leaveSalaryDeductionInformation,
  designations: designations ?? _designations,
  departments: departments ?? _departments,
  employeePunching: employeePunching ?? _employeePunching,
  events: events ?? _events,
  circularNotices: circularNotices ?? _circularNotices,
  socialMedia: socialMedia ?? _socialMedia,
);
  num? get dashboard => _dashboard;
  num? get employees => _employees;
  num? get manageSalaries => _manageSalaries;
  num? get payableSalaries => _payableSalaries;
  num? get attendance => _attendance;
  num? get shiftsTiming => _shiftsTiming;
  num? get leaveRequest => _leaveRequest;
  num? get holidays => _holidays;
  num? get leaveSalaryDeductionInformation => _leaveSalaryDeductionInformation;
  num? get designations => _designations;
  num? get departments => _departments;
  num? get employeePunching => _employeePunching;
  num? get events => _events;
  num? get circularNotices => _circularNotices;
  num? get socialMedia => _socialMedia;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dashboard'] = _dashboard;
    map['employees'] = _employees;
    map['manage_salaries'] = _manageSalaries;
    map['payable_salaries'] = _payableSalaries;
    map['attendance'] = _attendance;
    map['shifts_timing'] = _shiftsTiming;
    map['leave_request'] = _leaveRequest;
    map['holidays'] = _holidays;
    map['leave_salary_deduction_information'] = _leaveSalaryDeductionInformation;
    map['designations'] = _designations;
    map['departments'] = _departments;
    map['employee_punching'] = _employeePunching;
    map['events'] = _events;
    map['circular_notices'] = _circularNotices;
    map['social_media'] = _socialMedia;
    return map;
  }

}