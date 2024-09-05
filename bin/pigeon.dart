import 'package:pigeon/pigeon.dart';

class PigeonEkycData {
  const PigeonEkycData({
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
}

class PigeonEkycResponse {
  final String? error;
  final PigeonEkycData? data;

  const PigeonEkycResponse({
    this.data,
    this.error,
  });
}

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/vnpt_ekyc_pigeons.g.dart',
  dartOptions: DartOptions(),
  gobjectOptions: GObjectOptions(),
  kotlinOut:
      'android/src/main/kotlin/com/definev/vnpt_ekyc/VnptEkycPigeon.g.kt',
  kotlinOptions: KotlinOptions(),
  swiftOut: 'ios/Classes/VnptEkycPigeon.g.swift',
  swiftOptions: SwiftOptions(),
  dartPackageName: 'vnpt_ekyc_pigeon',
))
@HostApi()
abstract class VnptEkycPigeon {
  @async
  Map<String, String?> ekyc(
    String accessToken,
    String tokenId,
    String tokenKey,{
    String language = 'vi',
    }
  );
}
