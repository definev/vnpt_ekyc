# Thay đổi ở bản mới SDK NFC 
## _Áp dụng cho phiên bản >= 2.1.12_

Thay đổi các thuộc tính về cấu hình màu sắc:
- styleHeader (Int: 0 và 1) --> modeButtonHeaderBar (ModeButtonHeaderBar: LeftButton và RightButton)
- colorContentHeader (UIColor) --> contentColorHeaderBar (UIColor)
- colorBackgroundHeader (UIColor) --> backgroundColorHeaderBar (UIColor)
- colorContentMain (UIColor) --> textColorContentMain (UIColor)
- colorBackgroundMain (UIColor) --> backgroundColorMainScreen (UIColor)
- colorLine (UIColor) --> backgroundColorLine (UIColor)
- colorBackgroundButton (UIColor) --> backgroundColorButton (UIColor)
- colorTitleButton (UIColor) --> textColorTitleButton (UIColor)
- colorBackgroundCapture (UIColor) --> backgroundColorCapture (UIColor)
- colorEffectAnimation (UIColor) --> effectColorAnimation (UIColor)
- colorEffectAnimationFailed (UIColor) --> effectColorAnimationFailed (UIColor)
- colorBackgroundPopup (UIColor) --> backgroundColorPopup (UIColor)
- colorTextPopup (UIColor) --> textColorContentPopup (UIColor)

Thay đổi về cấu hình token
- ICNFCSaveData.shared().sdTokenId -> objICMainNFCReader.tokenId và objICMainNFCReader.tokenIdEKYC
- ICNFCSaveData.shared().sdTokenKey -> objICMainNFCReader.tokenKey và objICMainNFCReader.tokenKeyEKYC
- ICNFCSaveData.shared().sdAuthorization -> objICMainNFCReader.accessToken và accessToken.accessTokenEKYC


