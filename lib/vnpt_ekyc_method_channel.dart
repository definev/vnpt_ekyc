import 'package:vnpt_ekyc/domain/ekyc_result.dart';

import 'src/vnpt_ekyc_pigeons.g.dart';
import 'vnpt_ekyc_platform_interface.dart';

/// An implementation of [VnptEkycPlatform] that uses method channels.
class MethodChannelVnptEkyc extends VnptEkycPlatform {
  /// The method channel used to interact with the native platform.
  final vnptEkycPigeon = VnptEkycPigeon();

  @override
  Future<EkycResponse> extractEKYC(
    String accessToken,
    String tokenId,
    String tokenKey, {
    String language = 'vi',
  }) async {
    final raw = await vnptEkycPigeon.ekyc(
      accessToken,
      tokenId,
      tokenKey,
      language: language,
    );
    return EkycResponse.parseFromNative(raw);
  }
}
