import 'package:inovilage/network/Network.dart';

class EndPoint {
  //Auth
  static register({
    Map<String, dynamic>? body,
  }) async {
    return Network().post(
      url: "register",
      body: body,
    );
  }

  static login({
    Map<String, dynamic>? body,
  }) async {
    return Network().post(
      url: "login",
      body: body,
    );
  }

  static updateProfil({
    Map<String, dynamic>? body,
  }) async {
    return Network().post(
      url: "auth/updateProfil/${body!['id']}",
      body: body,
    );
  }

  static updateStatusKurir({
    Map<String, dynamic>? body,
  }) async {
    return Network().post(
      url: "auth/updateStatus",
      body: body,
    );
  }

  static logout() async {
    return Network().post(
      url: "auth/logout",
    );
  }

  static dashboard() async {
    return Network().get(
      url: "auth/dashboard",
    );
  }

  static getUserData() async {
    return Network().get(
      url: "auth/getUserData",
    );
  }

  static getListUser() async {
    return Network().get(
      url: "auth/listUser",
    );
  }

  //Pengiriman

  //Artikel
  static getArtikel() async {
    return Network().get(
      url: "artikel/list",
    );
  }

  //Donasi

  // Saldo

  //Sampah
  static getListSampah() async {
    return Network().get(
      url: "trash/list",
    );
  }
}
