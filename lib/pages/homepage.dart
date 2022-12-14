import 'package:flutter/material.dart';
import '../Models/kategori_model.dart';

class Homepage extends StatelessWidget {

  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    //final mediaQueryWidht = MediaQuery.of(context).size.width;
    final myAppBar = AppBar (
      elevation: 0.0,
      backgroundColor: Colors.pink.shade100,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.person),
            iconSize: 30,
            onPressed: () { },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      title: const Text('Nama'),
    );

    final bodyHeight = mediaQueryHeight - myAppBar.preferredSize.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: myAppBar,
      body: Column(
        children: <Widget> [
          Container(
            height: bodyHeight * 0.4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [
                  0.1,
                  0.4               
                ],
                colors: [
                  Colors.pink.shade100,
                  Colors.white70
                ],
              )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text('Kategori Layanan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                    )
                  ),
                  Expanded(
                    flex: 4,
                    child: CategoryList()
                  )
                ],
              ),
            ),
          ),
          Container(
            height: bodyHeight * 0.5,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  CategoryList({super.key});

  final List<Kategori> categories = <Kategori> [
    Kategori(Icons.home, 'Home',),  
    Kategori(Icons.home, 'Home',),  
    Kategori(Icons.contacts, 'Contact'),  
    Kategori(Icons.contacts, 'Contact'),  
    Kategori(Icons.map, 'Maps'),  
    Kategori(Icons.map, 'Maps'),  
    Kategori(Icons.phone, 'Phone'),  
    Kategori(Icons.phone, 'Phone'),  
  ];  

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: List.generate(categories.length, (index) => 
        SelectCard(category: categories[index]),  
      )
    );
  }
}

class SelectCard extends StatelessWidget {  
  const SelectCard({Key? key, required this.category}) : super(key: key);  
  final Kategori category;  
  
  @override  
  Widget build(BuildContext context) {  
    return Center(
      child: Column(
        children: <Widget> [
          Expanded(
            child: CircleAvatar(
              radius: 35,
              child: Icon(category.icon, size: 40,),
            )
          ),
          Text(category.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)  
        ],
      ),
    );
  }  
}  

