
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_pad_pa/models/model_infrastructure/model_infrastructure.dart';
part 'model_creneau.g.dart';

@JsonSerializable(explicitToJson: true)
class CreneauEvent {
  String? id;
  bool? estDisponible;
  DateTime? dateDebut;
  DateTime? dateFin;
  Infrastructure? infrastructure;


  CreneauEvent({this.id, this.estDisponible,
    this.dateDebut, this.dateFin,
    this.infrastructure});


  factory CreneauEvent.fromJson(Map<String, dynamic> json) =>
      _$CreneauEventFromJson(json);



  Map<String, dynamic> toJson() => _$CreneauEventToJson(this);

}