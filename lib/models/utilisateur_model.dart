import 'package:equatable/equatable.dart';
import 'package:restaurent/consts.dart';

class UtilisateurModel extends Equatable {
  final String? id;
  final String? firstname;
  final String? lastname;
  final String? username;
  final String? phonenumber;
  final String? sex;
  final String? email;
  final String? motPasseSchema;
  final String? pwd;
  final String? codepin;
  final String? role;
  final String? dateOfBirth;

  const UtilisateurModel({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.phonenumber,
    required this.sex,
    required this.email,
    required this.motPasseSchema,
    required this.pwd,
    required this.dateOfBirth,
    required this.codepin,
    required this.role,
  });

  @override
  List<Object?> get props => [
    id,
    firstname,
    lastname,
    username,
    phonenumber,
    sex,
    email,
    motPasseSchema,
    pwd,
    dateOfBirth,
    codepin,
    role,
  ];
  UtilisateurModel copyWith({
    String? firstname,
    String? lastname,
    String? username,
    String? phonenumber,
    String? sex,
    String? email,
    String? motPasseSchema,
    String? pwd,
    String? codepin,
    String? role,
    String? dateOfBirth,
  }) {
    return UtilisateurModel(
      id: id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      username: username ?? this.username,
      phonenumber: phonenumber ?? this.phonenumber,
      sex: sex ?? this.sex,
      email: email ?? this.email,
      motPasseSchema: motPasseSchema ?? this.motPasseSchema,
      pwd: pwd ?? this.pwd,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      codepin: codepin ?? this.codepin,
      role: role ?? this.role,
    );
  }

  factory UtilisateurModel.fromJson(Map<String, dynamic> map) {
    return UtilisateurModel(
      id: map['id'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      username: map['username'],
      phonenumber: map['phoneNumber'],
      sex: map['sex'],
      email: map['email'],
      motPasseSchema: map['motPasseSchema'],
      pwd: map['pwd'],
      dateOfBirth: map['dateBirth'],
      codepin: map['codepin'],
      role: map['role'],
    );
  }
  Map<String, dynamic> toJson() {
    if (id == null) {
      return {
        'firstname': firstname,
        'lastname': lastname,
        'phoneNumber': phonenumber,
        'pwd': pwd,
        'email': email,
        'role': role,
        'dateBirth': dateOfBirth,
      };
    } else {
      return {
        'id': id,
        'firstname': firstname,
        'lastname': lastname,
        'phoneNumber': phonenumber,
        'pwd': pwd,
        'email': email,
        'role': role,
        'dateBirth': dateOfBirth,
      };
    }
  }
}
