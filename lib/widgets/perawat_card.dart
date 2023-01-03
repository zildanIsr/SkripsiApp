import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/detail_perawat.dart';
import 'package:flutter_application_1/pages/pesan_view.dart';
import 'package:flutter_application_1/widgets/workrate.dart';
import 'package:get/get.dart';


class _ArticleDescription extends StatelessWidget {
  const _ArticleDescription({
    required this.name,
    required this.specialist,
    required this.yearWorks,
    required this.rating,
    required this.price,
  });

  final String name;
  final String specialist;
  final String yearWorks;
  final String rating;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                specialist,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        const Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: WorkRate()
          )
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                'Rp $price',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  Get.to(() => const PesanVieww());
                }, 
                child: const Text('Pesan')
              )
            ],
          ),
        )
      ],
    );
  }
}

class PerawatListItem extends StatelessWidget {
  const PerawatListItem({
    super.key,
    required this.thumbnail,
    required this.name,
    required this.specialist,
    required this.yearWorks,
    required this.rating,
    required this.price,
  });

  final Widget thumbnail;
  final String name;
  final String specialist;
  final String yearWorks;
  final String rating;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        elevation: 0.0,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: (() {
            Get.to(() => const DetailPerawat());
          }),
          child: SizedBox(
            height: 130,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.0,
                  child: thumbnail,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                    child: _ArticleDescription(
                      name: name,
                      specialist: specialist,
                      yearWorks: yearWorks,
                      rating: rating,
                      price: price,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PerawatCard extends StatelessWidget {
  const PerawatCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      //padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        PerawatListItem(
          thumbnail: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue
            ),
          ),
          name: 'Zildan Isrezkinurahman',
          specialist: 'Sp Sakit Jiwa.',
          yearWorks: '9',
          price: '20.000',
          rating: '98',
        ),
        PerawatListItem(
          thumbnail: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red
            ),
          ),
          name: 'Zildan Isrezkinurahman',
          specialist: 'Sp Sakit Jiwa.',
          yearWorks: '9',
          price: '20.000',
          rating: '98',
        ),
        PerawatListItem(
          thumbnail: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green
            ),
          ),
          name: 'Zildan Isrezkinurahman',
          specialist: 'Sp Sakit Jiwa.',
          yearWorks: '9',
          price: '20.000',
          rating: '98',
        ),
      ],
    );
  }
}
