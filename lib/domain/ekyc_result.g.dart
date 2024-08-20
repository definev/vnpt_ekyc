// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ekyc_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EkycData _$HapiEkycDataFromJson(Map<String, dynamic> json) => EkycData(
      name: json['name'] as String,
      dob: json['dob'] as String,
      province: json['province'] as String,
      district: json['district'] as String,
      ward: json['ward'] as String,
      citizenId: json['citizenId'] as String,
      issueBy: json['issueBy'] as String,
      issueDate: json['issueDate'] as String,
      address: json['address'] as String,
      gender: json['gender'] as String,
      prob: (json['prob'] as num).toDouble(),
    );

Map<String, dynamic> _$HapiEkycDataToJson(EkycData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'dob': instance.dob,
      'province': instance.province,
      'district': instance.district,
      'ward': instance.ward,
      'citizenId': instance.citizenId,
      'issueBy': instance.issueBy,
      'issueDate': instance.issueDate,
      'address': instance.address,
      'gender': instance.gender,
      'prob': instance.prob,
    };
