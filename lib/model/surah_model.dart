// To parse this JSON data, do
//
//     final surahModel = surahModelFromJson(jsonString);

//import 'package:meta/meta.dart';
import 'dart:convert';

List<SurahModel> surahModelFromJson(String str) => List<SurahModel>.from(json.decode(str).map((x) => SurahModel.fromJson(x)));

String surahModelToJson(List<SurahModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SurahModel {
    int nomor;
    String nama;
    String namaLatin;
    int jumlahAyat;
    TempatTurun tempatTurun;
    String arti;
    String deskripsi;
    String audio;

    SurahModel({
        required this.nomor,
        required this.nama,
        required this.namaLatin,
        required this.jumlahAyat,
        required this.tempatTurun,
        required this.arti,
        required this.deskripsi,
        required this.audio,
    });

    factory SurahModel.fromJson(Map<String, dynamic> json) { 
        
        print(json); 
        return SurahModel(
        nomor: json["nomor"],
        nama: json["nama"],
        namaLatin: json["nama_latin"],
        jumlahAyat: json["jumlah_ayat"],
        tempatTurun: tempatTurunValues.map[json["tempat_turun"]]!,
        arti: json["arti"],
        deskripsi: json["deskripsi"],
        audio: json["audio"],
    );
    }

    Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "nama_latin": namaLatin,
        "jumlah_ayat": jumlahAyat,
        "tempat_turun": tempatTurunValues.reverse[tempatTurun],
        "arti": arti,
        "deskripsi": deskripsi,
        "audio": audio,
    };
}

enum TempatTurun {
    Medinian,
    Meccan
}

final tempatTurunValues = EnumValues({
    "Medinian": TempatTurun.Medinian,
    "Meccan": TempatTurun.Meccan
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
