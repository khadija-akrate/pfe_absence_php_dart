class Seance {
  String dateDebut;
  String dateFin;
  String id;
  Seance({this.dateDebut, this.dateFin, this.id});

  Seance.fromJson(Map<String, dynamic> json) {
    dateDebut = json['date_D'];
    dateFin = json['date_F'];
    id = json['ID_SEANCE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_D'] = dateDebut;
    data['date_F'] = dateFin;
    data['ID_SEANCE'] = id;
    return data;
  }
}
