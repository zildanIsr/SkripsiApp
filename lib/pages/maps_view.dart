import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Map<String, dynamic>> datas = [
  {
    'id': '1',
    'position': const LatLng(-6.410674, 106.856738),
    'assetPath': 'assets/doctor.png',
  },
  {
    'id': '2',
    'position': const LatLng(-6.411506, 106.863218),
    'assetPath': 'assets/doctor.png',
  },
  {
    'id': '3',
    'position': const LatLng(-6.414406, 106.854013),
    'assetPath': 'assets/doctor.png',
  },
];

class MapsView extends StatefulWidget {
  const MapsView({Key? key}) : super(key: key);

  @override
  State<MapsView> createState() => MapsViewState();
}

class MapsViewState extends State<MapsView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final Map<String, Marker> listMarker = {};

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-6.200000, 106.816666),
    zoom: 14.4746,
  );

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _generateMarkers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
      myLocationEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: listMarker.values.toSet(),
    ));
  }

  _generateMarkers() async {
    // BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
    //   const ImageConfiguration(),
    //   "assets/nurse.png",
    // );
    late BitmapDescriptor myIcon;

    await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), 'assets/nurse-boy-128.png')
        .then((onValue) {
      myIcon = onValue;
    });

    for (int i = 0; i < datas.length; i++) {
      listMarker[i.toString()] = Marker(
          markerId: MarkerId(i.toString()),
          position: datas[i]['position'],
          icon: myIcon,
          onTap: () {
            Get.bottomSheet(
                Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black,
                          )),
                      backgroundColor: Colors.white,
                      title: const Text('wdwdw'),
                    ),
                  ),
                ),
                isScrollControlled: true);
          });
      setState(() {});
    }
  }
}
