import 'dart:convert';

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
  const EkycResponse({
    this.data,
    this.errorCode,
  });

  static EkycResponse parseFromNative(Map<String?, String?> raw) {
    if (raw['error'] case String error) {
      return const EkycResponse(
        errorCode: EkycErrorCode.unknown,
      );
    }

    final dataInfo = raw['data_info'];
    final dataCompare = raw['data_compare'];

    if (dataInfo == null || dataCompare == null) {
      return const EkycResponse(
        errorCode: EkycErrorCode.userCancel,
      );
    }

    final dataInfoMap = jsonDecode(dataInfo) as Map<String, dynamic>;
    final dataCompareMap = jsonDecode(dataCompare) as Map<String, dynamic>;

    final compare = dataInfoMap['object'];
    double prob = dataCompareMap['prob']?.toDouble() ?? 0;

    if (prob < 90.0) {
      return const EkycResponse(
        data: null,
        errorCode: EkycErrorCode.faceNotMatch,
      );
    }

    dynamic object = dataInfoMap['object'];
    dynamic address = List.from(object['post_code']).firstWhere(
      (element) => element['type'] == 'address',
      orElse: () => object['post_code'][0],
    );

    if (object['id_fake_warning'] == 'yes') {
      return const EkycResponse(
        data: null,
        errorCode: EkycErrorCode.idFake,
      );
    }

    if (object['expire_warning'] == 'yes') {
      return const EkycResponse(
        data: null,
        errorCode: EkycErrorCode.idExpired,
      );
    }

    if (object['back_expire_warning'] == 'yes') {
      return const EkycResponse(
        data: null,
        errorCode: EkycErrorCode.idBackExpired,
      );
    }

    dynamic addressObject =
        object['card_type'].toUpperCase() == 'CĂN CƯỚC CÔNG DÂN'
            ? object['recent_location']!.split('\n').join(' ')
            : object['recent_location_label']!.split('\n').join(' ');

    return EkycResponse(
      data: EkycData(
        name: object['name'],
        dob: object['birth_day'],
        province: address['city'][1],
        district: address['district'][1],
        ward: address['ward'][1],
        citizenId: object['id'],
        issueBy: object['issue_place']?.split('\n')?.join(' ') ?? '',
        issueDate: object['issue_date'],
        address: (addressObject == null) ? '' : addressObject.toString(),
        gender: object['gender'],
        prob: compare['prob']?.toDouble(),
      ),
    );
  }

  final EkycData? data;
  final EkycErrorCode? errorCode;
}

enum EkycErrorCode {
  notFound,
  faceNotMatch,
  idFake,
  idExpired,
  idBackExpired,
  userCancel,
  unknown,
}
