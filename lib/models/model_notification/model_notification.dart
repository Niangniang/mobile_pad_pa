import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_pad_pa/models/model_user/model_user.dart';
part 'model_notification.g.dart';

@JsonSerializable(explicitToJson: true)
class Notif{

  String? id;
  String? titre;
  String? message;
  String? dateHeure;
  //User? user;


  Notif({this.id, this.titre, this.message, this.dateHeure});



  factory Notif.fromJson(Map<String, dynamic> json) =>
      _$NotifFromJson(json);
  Map<String, dynamic> toJson() => _$NotifToJson(this);
}
