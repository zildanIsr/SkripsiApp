import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/nurse_data.dart';
import 'package:flutter_application_1/pages/detail_pengguna.dart';
import 'package:flutter_application_1/pages/detail_perawat.dart';
import 'package:url_launcher/url_launcher.dart';
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
    required this.direct,
    this.image,
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
  final bool direct;
  final String? image;

  @override
  Widget build(BuildContext context) {
    String getNumber(String number) {
      var sub = number.substring(0, 2);

      if (sub.contains('08')) {
        var newnumber = '62${number.substring(1)}';
        return newnumber;
      }
      return number;
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
      height: bodyHeight >= 700 ? bodyHeight * 0.3 : bodyHeight * 0.35,
      //color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nurse ? 'Detail Perawat' : 'Detail Pasien',
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: bodyHeight >= 700 ? 130 : 120,
                  width: bodyHeight >= 700 ? 130 : 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8), // Image border
                    child: image != null
                        ? Image.network(
                            image!,
                            fit: BoxFit.fill,
                          )
                        : Image.asset(
                            'assets/nurse-boy-128.png',
                            fit: BoxFit.fill,
                          ),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    //color: Colors.deepOrange,
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //Name
                        Text(
                          userName,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
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
                        const SizedBox(
                          height: 2.0,
                        ),
                        direct
                            ? GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () async {
                                  var number = getNumber(desc_2);

                                  var whatsappUrl =
                                      "whatsapp://send?phone=$number&text=${Uri.encodeComponent("Hallo, saya $userName dari aplikasi Homenursing")}";

                                  Uri url = Uri.parse(whatsappUrl);
                                  try {
                                    await launchUrl(url);
                                  } catch (e) {
                                    //To handle error and display error message
                                    Get.snackbar(
                                      'Gagal',
                                      '',
                                      colorText: Colors.white,
                                      messageText: const Text(
                                        'Gagal membuka WhatsApp',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white),
                                      ),
                                      backgroundColor: Colors.red.shade400,
                                      snackPosition: SnackPosition.TOP,
                                    );
                                  }
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 13,
                                      backgroundColor: Colors.green.shade300,
                                      child: const Icon(
                                        Icons.call_rounded,
                                        size: 11,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      desc_2,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Text(
                                desc_2,
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
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
                        const SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          desc_1,
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
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
