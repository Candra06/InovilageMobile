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

  static getstatusKurir() async {
    return Network().get(
      url: "auth/statusKurir",
    );
  }

  static getListUser() async {
    return Network().get(
      url: "auth/listUser",
    );
  }

  //Pengiriman
  static getListPengiriman() async {
    return Network().get(
      url: "pengiriman/history",
    );
  }

  static getDetailPengiriman(
    String id,
  ) async {
    return Network().get(
      url: "pengiriman/detail/$id",
    );
  }

  static requestPengiriman(
    Map<String, dynamic> body,
  ) async {
    return Network().post(
      url: "pengiriman/addPengiriman",
      body: body,
    );
  }

  static addItemPengiriman(
    Map<String, dynamic> body,
    String id,
  ) async {
    return Network().post(
      url: "pengiriman/addItem/$id",
      body: body,
    );
  }

  static confirmPengiriman(
    String id,
  ) async {
    return Network().post(
      url: "pengiriman/confirm/$id",
    );
  }

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

  static createDataSampah(
    Map<String, dynamic> body,
  ) async {
    return Network().post(
      url: "trash/create",
      body: body,
    );
  }

  static editDataSampah(
    Map<String, dynamic> body,
    String id,
  ) async {
    return Network().post(
      url: "trash/update/$id",
      body: body,
    );
  }

  static deleteDataSampah(String id) async {
    return Network().get(
      url: "trash/delete/$id",
    );
  }
}
