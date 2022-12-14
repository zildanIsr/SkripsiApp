import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/auth_view.dart';
import 'package:get/get.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidht = MediaQuery.of(context).size.width;

    final bodyHeight = mediaQueryHeight - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: bodyHeight,
          child: Stack(
            children: [            
              Positioned(
                child: Container(
                  width: double.infinity,
                  height: bodyHeight * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.pink.shade300,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(200),
                      bottomRight: Radius.circular(200)
                    )
                  ),
                ),
              ),
              ProfileCard(bodyHeight: bodyHeight, mediaQueryWidht: mediaQueryWidht),
              const Positioned(
                left: 50,
                right: 50,
                top: 100,
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 80,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.bodyHeight,
    required this.mediaQueryWidht,
  }) : super(key: key);

  final double bodyHeight;
  final double mediaQueryWidht;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        height: bodyHeight * 0.65,
        //color: Colors.green,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            Card(
              elevation: 8.0,
              child: SizedBox(
                width: mediaQueryWidht * 0.7,
                child: Center(
                  child: Column(
                    children: <Widget> [
                      const Padding(
                        padding: EdgeInsets.symmetric( vertical: 8),
                        child: Text(
                          'Zildan Isrezkinurahman Hernawan',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'PASIEN',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            letterSpacing: 2,
                            color: Colors.green.shade500,
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: mediaQueryWidht,
                //color: Colors.amber,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: 
                      TextButton(
                        onPressed: (){}, 
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Edit Profile', style: TextStyle(fontSize: 18, color: Colors.grey),),
                            Icon(Icons.arrow_forward_outlined, ),
                          ],
                        )
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: 
                      TextButton(
                        onPressed: () { Get.to(const AuthView());},
                        child: const Text('Logout', style: TextStyle(fontSize: 18),),
                      ),
                    )
                  ],
                )
              )
            ),
            
          ],
        )
      )
    );
  }
}

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});
  
  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    //final mediaQueryWidht = MediaQuery.of(context).size.width;

    final bodyHeight = mediaQueryHeight - MediaQuery.of(context).padding.top;
    return Center(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: bodyHeight * 0.4,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(200),
                bottomRight: Radius.circular(200),
              ),
              color: Colors.amber
            ),
            child: const CircleAvatar(
              backgroundColor: Colors.blue,
              maxRadius: 20,
            ),
          ),

        ],
      ),
    );

  }
}