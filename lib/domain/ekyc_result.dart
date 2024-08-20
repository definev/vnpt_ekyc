import 'package:json_annotation/json_annotation.dart';

part 'ekyc_result.g.dart';

@JsonSerializable()
class EkycData {
  const EkycData({
    required this.name,
    required this.dob,
    required this.province,
    required this.district,
    required this.ward,
    required this.citizenId,
    required this.issueBy,
    required this.issueDate,
    required this.address,
    required this.gender,
    required this.prob,
  });

  factory EkycData.fromJson(Map<String, dynamic> json) =>
      _$HapiEkycDataFromJson(json);

  final String name;
  final String dob;
  final String province;
  final String district;
  final String ward;
  final String citizenId;
  final String issueBy;
  final String issueDate;
  final String address;
  final String gender;
  final double prob;

  Map<String, dynamic> toJson() => _$HapiEkycDataToJson(this);
}

class EkycResponse {
  final EkycData? data;
  final String? errorMessage;

  const EkycResponse({
    this.data,
    this.errorMessage,
  });
}
