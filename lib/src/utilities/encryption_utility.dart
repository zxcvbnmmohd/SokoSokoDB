import 'package:encrypt/encrypt.dart';

class EncryptionUtility {
  static final _iv = IV.fromLength(16);
  static final _key = Key.fromUtf8(
    'my32lengthsupersecretnooneknows1',
  ); // 32 chars
  static final _encrypter = Encrypter(AES(_key));

  static String encryptData(String plainText) {
    return _encrypter.encrypt(plainText, iv: _iv).base64;
  }

  static String decryptData(String encryptedText) {
    return _encrypter.decrypt64(encryptedText, iv: _iv);
  }
}
