import 'package:json_annotation/json_annotation.dart';
part 'model_user.g.dart';



@JsonSerializable(explicitToJson: false)
class User{
  String id;
  String prenom;
  String nom;
  String adresse;
  String password;
  String telephone;
  String email;
  String? attachement;

  User({
      required this.id, required this.prenom,  required this.nom, required this.adresse, required this.password,
    required this.telephone, required this.email, this.attachement});

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}