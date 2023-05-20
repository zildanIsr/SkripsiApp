import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/status_widget.dart';
import 'package:get/get.dart';

import '../Controllers/category_controller.dart';
import '../Models/kategori_model.dart';

class ListLayananCard extends StatelessWidget {
  const ListLayananCard({
    super.key,
    required this.categoryId,
    required this.price,
    required this.status,
  });

  final int categoryId;
  final int price;
  final int status;

  @override
  Widget build(BuildContext context) {
    CategoryController cc = Get.put(CategoryController());
    Kategori category = cc.getCategory(categoryId);

    return Container(
      //color: Colors.amber,
      width: MediaQuery.of(context).size.width,
      height: 190.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        //color: Colors.green,
        elevation: 4.0,
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 0.7,
              child: Container(
                //color: Colors.blue,
                alignment: Alignment.center,
                child: Icon(
                  category.icon,
                  size: 60,
                ),
              ),
            ),
            VerticalDivider(
              width: 2,
              thickness: 2,
              indent: 20,
              endIndent: 20,
              color: Colors.grey.shade200,
            ),
            Expanded(
                child: Container(
              //color: Colors.blue,
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    category.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    'Rp.${price.toString()}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const StatusWidget(
                    sizeIcon: 20,
                    alignSelected: MainAxisAlignment.start,
                    iconType: Icons.info_outline,
                    status: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.pink.shade400)),
                          onPressed: () {},
                          child: const Text('Delete')),
                      const SizedBox(
                        width: 8.0,
                      ),
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Edit'))
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
