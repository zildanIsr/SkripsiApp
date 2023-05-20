import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/user_controller.dart';
import 'package:flutter_application_1/Models/address_model.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../Controllers/address_controller.dart';

class OnMapView extends StatefulWidget {
  const OnMapView({Key? key}) : super(key: key);

  @override
  State<OnMapView> createState() => OnMapViewState();
}

class OnMapViewState extends State<OnMapView> {
  AddressController ac = Get.put(AddressController());
  UserController uc = Get.put(UserController());

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-7.983908, 112.621391),
    zoom: 14.4746,
  );

  late Marker _position;
  late AddressModel newAddress;
  String setAddress = '';

  @override
  void initState() {
    _position = Marker(
        markerId: const MarkerId('Posisi'),
        infoWindow: const InfoWindow(title: 'Rumah'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: _kGooglePlex.target);
    super.initState();
    loadposition();
  }

  void loadposition() {
    getUserCurrentLocation().then((value) async {
      _addNewMaker(LatLng(value.latitude, value.longitude));

      List<Placemark> placemarks =
          await placemarkFromCoordinates(value.latitude, value.longitude);

      setState(() {
        setAddress =
            "${placemarks.reversed.last.street}, ${placemarks.reversed.last.subLocality}, ${placemarks.reversed.last.locality}, ${placemarks.reversed.last.subAdministrativeArea}, ${placemarks.reversed.last.administrativeArea} ${placemarks.reversed.last.postalCode}, ${placemarks.reversed.last.country}";

        newAddress = AddressModel(
            street: placemarks.reversed.last.street!,
            sublocality: placemarks.reversed.last.subLocality!,
            locality: placemarks.reversed.last.locality!,
            subadminisArea: placemarks.reversed.last.subAdministrativeArea!,
            adminisArea: placemarks.reversed.last.administrativeArea!,
            postalCode: placemarks.reversed.last.postalCode!,
            country: placemarks.reversed.last.country!,
            latitude: value.latitude,
            longitude: value.longitude,
            userId: uc.userRole.value,
            updatedAt: DateTime.now(),
            createdAt: DateTime.now());
      });

      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(value.latitude, value.longitude), zoom: 16);

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    });
  }

  Future<Position> getUserCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  addNewAddress(AddressModel data) {
    //debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(const Duration(seconds: 3)).then((_) async {
      var responses = await ac.addNewAddress(data);
      if (responses >= 400 && responses < 500) {
        return Get.snackbar("Error", "Gagal menambahkan alamat",
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red.shade300);
      } else if (responses >= 500) {
        return Get.snackbar("Error", "Server Error",
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red.shade300);
      } else if (responses == 201) {
        Get.back();
        return Get.snackbar("Success", "Berhasil menambahkan alamat",
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green.shade300);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: AlignmentDirectional.bottomCenter, children: <
          Widget>[
        GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: {_position},
          onTap: _addNewMaker,
          onLongPress: _addNewMaker,
        ),
        SizedBox(
          width: double.infinity,
          height: 300.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 8.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        alignment: Alignment.center,
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 25,
                          //color: Colors.black,
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: IconButton(
                        onPressed: () {
                          getUserCurrentLocation().then((value) async {
                            _addNewMaker(
                                LatLng(value.latitude, value.longitude));

                            CameraPosition cameraPosition = CameraPosition(
                                target: LatLng(value.latitude, value.longitude),
                                zoom: 20);

                            final GoogleMapController controller =
                                await _controller.future;

                            controller.animateCamera(
                                CameraUpdate.newCameraPosition(cameraPosition));
                          });
                        },
                        alignment: Alignment.center,
                        icon: const Icon(
                          Icons.my_location,
                          size: 25,
                          //color: Colors.black,
                        )),
                  ),
                ],
              ),
              Expanded(
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Alamat Tersimpan',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Container(
                            padding: const EdgeInsets.all(18.0),
                            constraints: const BoxConstraints(
                                minWidth: double.infinity, minHeight: 100.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: Colors.black26),
                            ),
                            child: Text(
                              setAddress != '' ? setAddress : ' ',
                              softWrap: true,
                              maxLines: 3,
                              style: const TextStyle(fontSize: 18.0),
                            )),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.bottomRight,
                          child: Obx(() => ac.isLoading.value
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 28.0, vertical: 12.0),
                                  child: LoadingAnimationWidget.discreteCircle(
                                      color: Colors.pink, size: 24),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    addNewAddress(newAddress);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4.0),
                                    child: Text('Simpan'),
                                  ))),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  void _addNewMaker(LatLng pos) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);

    setState(() {
      _position = Marker(
          markerId: const MarkerId('1'),
          infoWindow: const InfoWindow(title: 'Rumah'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: pos);

      setAddress =
          "${placemarks.reversed.last.street}, ${placemarks.reversed.last.subLocality}, ${placemarks.reversed.last.locality}, ${placemarks.reversed.last.subAdministrativeArea}, ${placemarks.reversed.last.administrativeArea} ${placemarks.reversed.last.postalCode}, ${placemarks.reversed.last.country}";

      newAddress = AddressModel(
          street: placemarks.reversed.last.street!,
          sublocality: placemarks.reversed.last.subLocality!,
          locality: placemarks.reversed.last.locality!,
          subadminisArea: placemarks.reversed.last.subAdministrativeArea!,
          adminisArea: placemarks.reversed.last.administrativeArea!,
          postalCode: placemarks.reversed.last.postalCode!,
          country: placemarks.reversed.last.country!,
          latitude: pos.latitude,
          longitude: pos.longitude,
          userId: uc.userRole.value,
          updatedAt: DateTime.now(),
          createdAt: DateTime.now());
    });
  }
}
