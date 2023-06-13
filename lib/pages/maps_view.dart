import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Controllers/map_contoller.dart';
import '../widgets/perawat_card.dart';
import '../widgets/skeleton.dart';

class MapsView extends StatefulWidget {
  const MapsView({Key? key}) : super(key: key);

  @override
  State<MapsView> createState() => MapsViewState();
}

class MapsViewState extends State<MapsView> {
  MapController mc = Get.put(MapController());

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final Set<Marker> _markers = <Marker>{};

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-7.983908, 112.621391),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _generateMarkers();
  }

  @override
  void dispose() {
    _markers.clear();
    super.dispose();
  }

  _generateMarkers() async {
    await mc.getAllNurseAddress();
    late BitmapDescriptor myIcon;

    await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), 'assets/nurse-boy-128.png')
        .then((onValue) {
      myIcon = onValue;
    });

    for (int i = 0; i < mc.position.length; i++) {
      Marker marker = Marker(
          markerId: MarkerId(i.toString()),
          position: LatLng(mc.position[i].addresses.latitude,
              mc.position[i].addresses.longitude),
          icon: myIcon,
          onTap: () {
            mc.getProduct(mc.position[i].id);
            Get.bottomSheet(
                Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Scaffold(
                      appBar: AppBar(
                        elevation: 2.0,
                        leading: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.black,
                            )),
                        backgroundColor: Colors.white,
                      ),
                      body: Obx(() => mc.isLoading.value
                          ? const CardSkeleton(
                              count: 3,
                            )
                          : mc.productPoint.isEmpty
                              ? const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.medical_services_outlined,
                                        color: Colors.black12,
                                        size: 100,
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        "Belum ada layanan",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.fromLTRB(
                                      16.0, 4.0, 16.0, 0),
                                  shrinkWrap: true,
                                  itemCount: mc.productPoint.length,
                                  itemBuilder: (context, index) {
                                    return PerawatListItem(
                                      key: ValueKey(mc.productPoint[index].id),
                                      thumbnail: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child:
                                            mc.productPoint[index].user.image !=
                                                    null
                                                ? Image.network(
                                                    mc.productPoint[index].user
                                                        .image,
                                                    fit: BoxFit.fill,
                                                  )
                                                : Image.asset(
                                                    'assets/nurse-boy-128.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                      ),
                                      name: mc.productPoint[index].user.name,
                                      category:
                                          mc.productPoint[index].category.name,
                                      price: mc.productPoint[index].price,
                                      rating: mc
                                          .productPoint[index].perawat.rating!,
                                      strNumber: mc.productPoint[index].perawat
                                          .strNumber,
                                      categoryId:
                                          mc.productPoint[index].categoryId,
                                      productId: mc.productPoint[index].id,
                                    );
                                  }))),
                ),
                isScrollControlled: true);
          });
      setState(() {
        _markers.add(marker);
      });
    }
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
      markers: _markers,
    ));
  }
}
