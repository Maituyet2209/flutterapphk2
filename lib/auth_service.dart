import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService {
  static Future<Map<String, dynamic>?> getUserInfoFromToken(String token) async {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      // Trả về một map chứa thông tin từ payload của token
      return decodedToken;
    } catch (error) {
      print('Error decoding token: $error');
      return null;
    }
  }
}