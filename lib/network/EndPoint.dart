import 'package:inovilage/network/Network.dart';

class EndPoint {
  
  static login({
    Map<String, dynamic>? body,
  }) async {
    return Network().post(
      url: "login",
      body: body,
    );
  }
}
