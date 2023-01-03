import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/workrate.dart';

class DetailPerawat extends StatelessWidget {
  const DetailPerawat({super.key});

  @override
  Widget build(BuildContext context) {
    final myAppBar = AppBar (
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            onPressed: (){
              Get.back();
            }, 
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              )
          );
        }
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
    );
    
    return Scaffold(
      appBar: myAppBar,
      body: const ProfileDetail(),
    );
  }
}

class ProfileDetail extends StatelessWidget {
  const ProfileDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;    
    List<String> list =["S1 Universitas Brawijaya", "S2 Universitas Gajah Mada", "S3 Universitas Negeri Malang"];

    return Container(
      height: mediaQueryHeight,
      width: double.infinity,
      //color: Colors.amber,
      margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: Card(
        elevation: 8.0,
        color: Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UpperDetail(
              vheight: mediaQueryHeight,
            ),
            Container(
              height: mediaQueryHeight * 0.5,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),              
              //color: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,                  
                children: [
                  Row(
                    children: const [
                      Icon(Icons.cast_for_education),
                      SizedBox(width: 4.0,),
                      Text('Riwayat Pendidikan', 
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                      ), 
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(  
                      itemCount: list.length,   
                      physics: const NeverScrollableScrollPhysics(),                 
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          '${index+1}. ${list[index]}',
                          softWrap: true,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 16.0,
                            height: 2.0
                          ),
                        );
                      }
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.work_outline),
                              SizedBox(width: 4.0,),
                              Text('Tempat Praktik', 
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                              ), 
                            ],
                          ),
                          const Text(
                            'Klinik blaablabalbal',
                            softWrap: true,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16.0,
                              height: 2.0
                            ),
                          )
                        ],
                      )
                    )
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Row(
                          children: const [
                            Icon(Icons.heart_broken_outlined),
                            SizedBox(width: 4.0,),
                            Text('Nomor STR', 
                              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                            ), 
                          ],
                        ),
                        const Text(
                          'Klinik blaablabalbal',
                          softWrap: true,
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16.0,
                            height: 2.0
                          ),
                        )
                      ],
                    )
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpperDetail extends StatelessWidget {
  const UpperDetail({
    required this.vheight,
    Key? key,
  }) : super(key: key);

  final double vheight;


  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.green,
      height: vheight * 0.37,
      padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget> [
          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 80,
          ),
          SizedBox(height: 16.0,),
          Text(
            'Zildan Isrezkinurahman Hernawan',
            maxLines: 1,
            softWrap: true,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(height: 8.0,),
          WorkRate(),
          SizedBox(height: 16.0,),
          Divider(height: 16.0,)
        ],
      )
    );
  }
}

