
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/listperawat_view.dart';
import 'package:flutter_application_1/widgets/perawat_card.dart';
import '../Models/kategori_model.dart';

import 'package:get/get.dart';

class Homepage extends StatelessWidget {

  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    //final mediaQueryWidht = MediaQuery.of(context).size.width;
    final myAppBar = AppBar (
      elevation: 0.0,
      toolbarHeight: 60,
      title: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.black
          ),
          Container(
            padding: const EdgeInsets.only(left: 16.0),
            width: 150,
            child: const Text('Zildan Isrezki nurahman hernawan', 
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 1,
            ),
          )
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.add)
          ),
        )
      ],
    );

    final bodyHeight = mediaQueryHeight - myAppBar.preferredSize.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: myAppBar,
      body: Column(
        children: <Widget> [
          SizedBox(
            //color: Colors.amber,
            height: bodyHeight * 0.26,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text('Kategori Layanan',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                    )
                  ),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: CategoryList(),
                    )
                  )
                ],
              ),
            ),
          ),
          Container(
            height: bodyHeight * 0.66,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget> [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text('Populer',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                ),
                Flexible(
                  child: PerawatCard()
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  CategoryList({super.key});

  final List<Kategori> categories = <Kategori> [
    Kategori('1', Icons.medical_information, 'Infusisasi',),  
    Kategori('2', Icons.medical_information, 'Rawat Jalan',),  
    Kategori('3', Icons.medical_information, 'Edukasi'),  
    Kategori('4', Icons.medical_information, 'Tensi'),  
    Kategori('5', Icons.medical_information, 'Rawat Luka'),  
    Kategori('6', Icons.medical_information, 'Obat'),  
  ];  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.isEmpty ? 
          <Widget> [
            const Text(
                "Tidak ada",
                style: TextStyle(color: Colors.grey),
            )
          ]
        : 
          List.generate(categories.length, (index) =>
            SelectCard(category: categories[index])
          )
      )
    );
  }
}

class SelectCard extends StatelessWidget {  
  const SelectCard({Key? key, required this.category}) : super(key: key);  
  final Kategori category;  
  
  @override  
  Widget build(BuildContext context) {  
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 100,
        maxWidth: 100
      ),
      width: 100,
      height: 100,
      margin: const EdgeInsets.only(right: 4),
      child: Column(
        children: <Widget> [
          Expanded(
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.pinkAccent.withAlpha(30),
                onTap: () {
                  Get.to(() => const ListPerawatView(), arguments: category.name);
                },
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Icon(category.icon, size: 40,))
                )
              ),
            ),
          const SizedBox(height: 4,),
          Text(category.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)  
        ],
      ),
    );
  }  
}  

