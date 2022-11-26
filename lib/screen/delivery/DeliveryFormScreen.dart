import 'package:flutter/material.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geocoding/geocoding.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/provider/AuthProvider.dart';
import 'package:inovilage/provider/PengirimanProvider.dart';
import 'package:inovilage/static/SnackBar.dart';
import 'package:inovilage/static/Static.dart';
import 'package:inovilage/static/Utils.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/ButtonWidget.dart';
import 'package:inovilage/widget/HeaderWidger.dart';
import 'package:inovilage/widget/InputWidget.dart';
import 'package:inovilage/widget/SelectWidget.dart';
import 'package:inovilage/widget/TextWidget.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:provider/provider.dart';

class DeliveryFormScreen extends StatefulWidget {
  const DeliveryFormScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryFormScreen> createState() => _DeliveryFormScreenState();
}

class _DeliveryFormScreenState extends State<DeliveryFormScreen> {
  TextEditingController nameController = TextEditingController(),
      phoneController = TextEditingController(),
      addressController = TextEditingController(),
      dateController = TextEditingController(),
      typeController = TextEditingController();
  DateTime date = DateTime.now();
  DateTime now = DateTime.now();
  int selectedItem = 1000;
  double lat = -8.339147, long = 113.5814033;
  bool loading = false, isChecked = false;
  // MapController controller = MapController(
  //   initMapWithUserPosition: false,
  //   initPosition: GeoPoint(latitude: -8.339147, longitude: 113.5814033),
  // );

  getData() async {
    var auth = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).authData;
    setState(() {
      nameController.text = auth!.name!;
      phoneController.text = auth.phone!;
    });
  }

  setAsLocation() async {
    try {
      var auth = Provider.of<AuthProvider>(
        context,
        listen: false,
      ).authData;
      if (isChecked) {
        lat = -8.339147;
        long = 113.5814033;
      } else {
        lat = double.parse(auth!.latAddress.toString());
        long = double.parse(auth.longAddress.toString());
      }
      List<Placemark> locations = await placemarkFromCoordinates(lat, long);

      String address =
          "${locations[1].street.toString()} ${locations[1].subLocality.toString()} ${locations[0].locality.toString()}, ${locations[0].postalCode.toString()} ";
      // print(jsonEncode(locations));

      setState(() {
        addressController.text = address;
      });
    } catch (e) {}
  }

  requestSending() async {
    setState(() {
      loading = true;
    });
    Map<String, dynamic> body = {
      "tanggal": date.toString(),
      "alamat_jemput": addressController.text,
      "lat_address": lat.toString(),
      "long_address": long.toString(),
      "jenis_sampah": typeController.text,
    };

    await Provider.of<PengirimanProvider>(
      context,
      listen: false,
    )
        .requestPengiriman(
      body,
    )
        .then((response) {
      if (response['code'] == '00') {
        showSnackBar(
          context,
          'Success',
          type: 'success',
          subtitle: 'Berhasil mengirim order',
          position: 'top',
          duration: 5,
        );
        Navigator.pushNamed(
          context,
          Navigation.homeScreen,
        );
      } else {
        showSnackBar(
          context,
          'Gagal',
          type: 'error',
          subtitle: response['message'],
          position: 'top',
          duration: 5,
        );
      }
    });
    setState(() {
      loading = false;
    });
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return secondaryColor;
    }
    return secondaryColor;
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(
          defaultMargin,
        ),
        child: SafeArea(
          child: Column(
            children: [
              const HeaderWidget(
                title: "Ajukan Pengiriman Sampah",
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: defaultMargin,
                ),
                child: InputWidget(
                  title: "Nama Pengirim",
                  hintText: "Nama Lengkap",
                  controller: nameController,
                  iconLeft: Icons.account_circle_outlined,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: InputWidget(
                  title: "No HP",
                  hintText: "Nomor Telepon",
                  controller: phoneController,
                  iconLeft: Icons.phone_android,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    label: "Alamat",
                    type: 'l1',
                    color: fontSecondaryColor,
                  ),
                  Row(
                    children: [
                      TextWidget(
                        label: "Sesuaikan dengan akun",
                        type: 'b2',
                        color: secondaryColor,
                      ),
                      Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setAsLocation();
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  bottom: defaultMargin,
                ),
                child: InputWidget(
                  title: "hidden",
                  hintText: "Alamat",
                  controller: addressController,
                  iconLeft: Icons.location_on_outlined,
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 300,
                child:
                    // child: OSMFlutter(
                    //   controller: controller,
                    //   trackMyPosition: false,
                    //   initZoom: 12,
                    //   minZoomLevel: 8,
                    //   maxZoomLevel: 14,
                    //   stepZoom: 1.0,
                    //   userLocationMarker: UserLocationMaker(
                    //     personMarker: MarkerIcon(
                    //       icon: Icon(
                    //         Icons.location_history_rounded,
                    //         color: Colors.red,
                    //         size: 48,
                    //       ),
                    //     ),
                    //     directionArrowMarker: MarkerIcon(
                    //       icon: Icon(
                    //         Icons.double_arrow,
                    //         size: 48,
                    //       ),
                    //     ),
                    //   ),
                    //   roadConfiguration: RoadConfiguration(
                    //     startIcon: MarkerIcon(
                    //       icon: Icon(
                    //         Icons.person,
                    //         size: 64,
                    //         color: Colors.brown,
                    //       ),
                    //     ),
                    //     roadColor: Colors.yellowAccent,
                    //   ),
                    //   markerOption: MarkerOption(
                    //       defaultMarker: MarkerIcon(
                    //     icon: Icon(
                    //       Icons.person_pin_circle,
                    //       color: Colors.blue,
                    //       size: 56,
                    //     ),
                    //   )),
                    // )
                    OpenStreetMapSearchAndPick(
                  center: LatLong(lat, long),
                  buttonColor: primaryColor,
                  buttonText: 'Pilih Lokasi',
                  onPicked: (pickedData) {
                    lat = pickedData.latLong.latitude;
                    long = pickedData.latLong.longitude;
                    addressController.text = pickedData.address.toString();
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: InputWidget(
                  title: "Tanggal",
                  hintText: "Pilih Tanggal",
                  controller: dateController,
                  iconRight: Icons.keyboard_arrow_down_outlined,
                  readOnlyColorCustom: whiteColor,
                  readonly: true,
                  onPress: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(now.year, now.month, now.day),
                      lastDate: DateTime(2100),
                    );
                    if (newDate == null) return;
                    setState(() {
                      date = newDate;
                      dateController.text = dateFormatDay(
                        context,
                        format: "E, dd MMM y",
                        value: newDate.toString(),
                      );
                    });
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: InputWidget(
                  title: "Jenis Sampah",
                  hintText: "Pilih Jenis Sampah",
                  controller: typeController,
                  iconRight: Icons.keyboard_arrow_down_outlined,
                  readOnlyColorCustom: whiteColor,
                  readonly: true,
                  onPress: () async {
                    _showModalSelect();
                  },
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                ),
                child: ButtonWidget(
                  label: "Ajukan Pengiriman Sampah",
                  isLoading: loading,
                  theme: loading ? 'disable' : 'primary',
                  onPressed: () {
                    if (!loading) {
                      requestSending();
                    }
                  },
                  upperCase: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showModalSelect() {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: whiteColor,
      clipBehavior: Clip.hardEdge,
      builder: (BuildContext context) {
        return SelectWidget(
          data: jenisSampah,
          selected: selectedItem,
          title: "Jenis Sampah",
          callback: (index, data) {
            setState(() {
              selectedItem = index;
              typeController.text = data['label'];
            });
          },
        );
      },
    );
  }
}
