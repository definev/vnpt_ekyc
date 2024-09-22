import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'vnpt_ekyc_method_channel.dart';

abstract class VnptEkycPlatform extends PlatformInterface {
  /// Constructs a VnptEkycPlatform.
  VnptEkycPlatform() : super(token: _token);

  static final Object _token = Object();

  static VnptEkycPlatform _instance = MethodChannelVnptEkyc();

  /// The default instance of [VnptEkycPlatform] to use.
  ///
  /// Defaults to [MethodChannelVnptEkyc].
  static VnptEkycPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [VnptEkycPlatform] when
  /// they register themselves.
  static set instance(VnptEkycPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Map<String?, String?>> extractEKYC(
    String accessToken,
    String tokenId,
    String tokenKey, {
    String language = 'vi',
  }) {
    throw UnimplementedError('extractEKYC() has not been implemented.');
  }
}
