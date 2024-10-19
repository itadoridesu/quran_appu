// To parse this JSON data, do
//
//     final surahDetailsModel = surahDetailsModelFromJson(jsonString);

//import 'package:meta/meta.dart';
import 'dart:convert';

SurahDetailsModel surahDetailsModelFromJson(String str) => SurahDetailsModel.fromJson(json.decode(str));

String surahDetailsModelToJson(SurahDetailsModel data) => json.encode(data.toJson());

class SurahDetailsModel {
    String surahName;
    String surahNameArabic;
    String surahNameArabicLong;
    String surahNameTranslation;
    String revelationPlace;
    int totalAyah;
    int surahNo;
    List<String> english;
    List<String> arabic1;
    List<String> arabic2;

    SurahDetailsModel({
        required this.surahName,
        required this.surahNameArabic,
        required this.surahNameArabicLong,
        required this.surahNameTranslation,
        required this.revelationPlace,
        required this.totalAyah,
        required this.surahNo,
        required this.english,
        required this.arabic1,
        required this.arabic2,
    });

    factory SurahDetailsModel.fromJson(Map<String, dynamic> json) => SurahDetailsModel(
        surahName: json["surahName"],
        surahNameArabic: json["surahNameArabic"],
        surahNameArabicLong: json["surahNameArabicLong"],
        surahNameTranslation: json["surahNameTranslation"],
        revelationPlace: json["revelationPlace"],
        totalAyah: json["totalAyah"],
        surahNo: json["surahNo"],
        english: List<String>.from(json["english"].map((x) => x)),
        arabic1: List<String>.from(json["arabic1"].map((x) => x)),
        arabic2: List<String>.from(json["arabic2"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "surahName": surahName,
        "surahNameArabic": surahNameArabic,
        "surahNameArabicLong": surahNameArabicLong,
        "surahNameTranslation": surahNameTranslation,
        "revelationPlace": revelationPlace,
        "totalAyah": totalAyah,
        "surahNo": surahNo,
        "english": List<dynamic>.from(english.map((x) => x)),
        "arabic1": List<dynamic>.from(arabic1.map((x) => x)),
        "arabic2": List<dynamic>.from(arabic2.map((x) => x)),
    };
}
