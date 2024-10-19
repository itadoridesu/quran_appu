// To parse this JSON data, do
//
//     final ayahModel = ayahModelFromJson(jsonString);

//import 'package:meta/meta.dart';
import 'dart:convert';

AyahModel ayahModelFromJson(String str) => AyahModel.fromJson(json.decode(str));

String ayahModelToJson(AyahModel data) => json.encode(data.toJson());

class AyahModel {
    String surahName;
    String surahNameArabic;
    String surahNameArabicLong;
    String surahNameTranslation;
    String revelationPlace;
    int totalAyah;
    int surahNo;
    int ayahNo;
    String english;
    String arabic1;
    String arabic2;
    String bangla;
    Map<String, Audio> audio;

    AyahModel({
        required this.surahName,
        required this.surahNameArabic,
        required this.surahNameArabicLong,
        required this.surahNameTranslation,
        required this.revelationPlace,
        required this.totalAyah,
        required this.surahNo,
        required this.ayahNo,
        required this.english,
        required this.arabic1,
        required this.arabic2,
        required this.bangla,
        required this.audio,
    });

    factory AyahModel.fromJson(Map<String, dynamic> json) => AyahModel(
        surahName: json["surahName"],
        surahNameArabic: json["surahNameArabic"],
        surahNameArabicLong: json["surahNameArabicLong"],
        surahNameTranslation: json["surahNameTranslation"],
        revelationPlace: json["revelationPlace"],
        totalAyah: json["totalAyah"],
        surahNo: json["surahNo"],
        ayahNo: json["ayahNo"],
        english: json["english"],
        arabic1: json["arabic1"],
        arabic2: json["arabic2"],
        bangla: json["bangla"],
        audio: Map.from(json["audio"]).map((k, v) => MapEntry<String, Audio>(k, Audio.fromJson(v))),
    );

    Map<String, dynamic> toJson() => {
        "surahName": surahName,
        "surahNameArabic": surahNameArabic,
        "surahNameArabicLong": surahNameArabicLong,
        "surahNameTranslation": surahNameTranslation,
        "revelationPlace": revelationPlace,
        "totalAyah": totalAyah,
        "surahNo": surahNo,
        "ayahNo": ayahNo,
        "english": english,
        "arabic1": arabic1,
        "arabic2": arabic2,
        "bangla": bangla,
        "audio": Map.from(audio).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    };
}

class Audio {
    String reciter;
    String url;

    Audio({
        required this.reciter,
        required this.url,
    });

    factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        reciter: json["reciter"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "reciter": reciter,
        "url": url,
    };
}
