import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/nurse_data.dart';
import 'package:flutter_application_1/pages/detail_pengguna.dart';
import 'package:flutter_application_1/pages/detail_perawat.dart';
import 'package:get/get.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({
    Key? key,
    required this.bodyHeight,
    required this.title1,
    required this.title2,
    required this.userName,
    required this.desc_1,
    required this.desc_2,
    this.id,
    required this.nurse,
    this.str,
    this.getAddress,
  }) : super(key: key);

  final double bodyHeight;
  final String userName;
  final String title1;
  final String title2;
  final String desc_1;
  final String desc_2;
  final int? id;
  final String? str;
  final bool nurse;
  final String? getAddress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      height: bodyHeight * 0.32,
      //color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nurse ? 'Detail Perawat' : 'Detail Pasien',
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30), // Image border
                    child: Image.network(
                      'https://dummyimage.com/150x150/000/fff.png',
                      fit: BoxFit.cover,
                      width: 150.0,
                      height: 150.0,
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    //color: Colors.deepOrange,
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 16.0, right: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //Name
                        Text(
                          userName,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        //Title1
                        Text(
                          title1,
                          style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                        Text(
                          desc_1,
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          title2,
                          style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                        Text(
                          desc_2,
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Container(
                            width: double.infinity,
                            //color: Colors.grey,
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                nurse
                                    ? Get.to(
                                        () => DetailPerawat(strNumber: str!),
                                        binding: BindingsBuilder.put(
                                            () => NurseController()))
                                    : Get.to(() => DetailPengguna(
                                        id: id, getAddress: getAddress));
                              },
                              child: const Text(
                                'Lihat Detail',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ))
                      ],
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
