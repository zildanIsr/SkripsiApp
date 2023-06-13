import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/nurse_data.dart';
import 'package:flutter_application_1/Controllers/rating_controller.dart';
import 'package:flutter_application_1/widgets/skeleton.dart';
import 'package:get/get.dart';

import 'package:skeletons/skeletons.dart';

import '../Controllers/category_controller.dart';
import '../Models/kategori_model.dart';

class DetailRating extends StatefulWidget {
  const DetailRating({super.key});

  @override
  State<DetailRating> createState() => _DetailRatingState();
}

class _DetailRatingState extends State<DetailRating>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myAppbar = AppBar(
      title: const Text('Ulasan Pasien'),
      elevation: 0.0,
    );

    final height =
        MediaQuery.of(context).size.height - myAppbar.preferredSize.height;

    RatingController rc = Get.find();
    NurseController nc = Get.find();

    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            title: const Text('Ulasan Pasien'),
            pinned: true,
            floating: true,
            forceElevated: innerBoxIsScrolled,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 4.0,
            bottom: TabBar(
              indicatorColor: Colors.black26,
              tabs: <Tab>[
                Tab(
                  height: height * 0.15,
                  child: SizedBox(
                      //color: Colors.grey,
                      width: double.infinity,
                      //height: height * 0.15,
                      //padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.33,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.star_rate_rounded,
                                        size: 42,
                                        color: Colors.amber,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            text: nc.rating.value.toString(),
                                            style: const TextStyle(
                                              height: 1.5,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 32,
                                            ),
                                            children: const [
                                              TextSpan(
                                                text: '/5.0',
                                                style: TextStyle(
                                                  height: 1.5,
                                                  color: Colors.black38,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ]),
                                      )
                                    ],
                                  )),
                              const SizedBox(
                                width: 16,
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.55,
                                  child: Obx(() => rc.isLoading.value
                                      ? const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SkeletonLine(
                                              style: SkeletonLineStyle(
                                                  height: 14,
                                                  width: 200,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              15.0)),
                                                  alignment:
                                                      Alignment.centerLeft),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            SkeletonLine(
                                              style: SkeletonLineStyle(
                                                  height: 14,
                                                  width: 150,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              15.0)),
                                                  alignment:
                                                      Alignment.centerLeft),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                  text: rc.totOrder.value
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                  children: const [
                                                    TextSpan(
                                                      text:
                                                          ' pesanan layanan selesai',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                  text: rc.listTestimoni.length
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black45,
                                                    fontSize: 16,
                                                  ),
                                                  children: const [
                                                    TextSpan(
                                                      text:
                                                          ' ulasan dan rating',
                                                      style: TextStyle(
                                                        color: Colors.black45,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ]),
                                            )
                                          ],
                                        ))),
                            ],
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          const FilterRate()
                        ],
                      )),
                ),
              ],
              controller: _tabController,
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: const [ListItem()],
      ),
    ));
  }
}

class FilterRate extends StatefulWidget {
  const FilterRate({
    super.key,
  });

  @override
  State<FilterRate> createState() => _FilterRateState();
}

class _FilterRateState extends State<FilterRate> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    RatingController rc = Get.find();
    NurseController nc = Get.find();

    return SizedBox(
      height: 45,
      //padding: const EdgeInsets.fromLTRB(0, 6, 0, 8),
      //color: Colors.amber,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 6,
          itemBuilder: ((context, index) {
            if (index == 0) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    side: BorderSide(
                      color: selected == index ? Colors.green : Colors.black12,
                    )),
                color: selected == index ? Colors.green.shade400 : Colors.white,
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        selected = index;
                        rc.getAllTestimoni(nc.singleNurse.id!, null);
                      });
                    },
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Semua',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        )
                      ],
                    )),
              );
            }
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  side: BorderSide(
                    color: selected == index ? Colors.green : Colors.black12,
                  )),
              color: selected == index ? Colors.green.shade400 : Colors.white,
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      selected = index;
                      rc.getAllTestimoni(nc.singleNurse.id!, index);
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        '$index',
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      )
                    ],
                  )),
            );
          })),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({super.key});

  @override
  Widget build(BuildContext context) {
    RatingController rc = Get.find();
    return Obx(() => rc.isLoading.value
        ? ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 3,
            itemBuilder: (context, index) {
              return const RatingSkeletons();
            })
        : rc.listTestimoni.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.rate_review_outlined,
                      color: Colors.black12,
                      size: 100,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "Belum ada testimoni",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: rc.listTestimoni.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return RatingCard(
                    key: ValueKey(rc.listTestimoni[index].id),
                    description: rc.listTestimoni[index].desciption,
                    pacientName: rc.listTestimoni[index].user.name,
                    rate: rc.listTestimoni[index].rate,
                    categoryId:
                        rc.listTestimoni[index].order.product.categoryId,
                  );
                }));
  }
}

class RatingCard extends StatelessWidget {
  const RatingCard({
    super.key,
    required this.pacientName,
    required this.description,
    required this.rate,
    required this.categoryId,
  });
  final String pacientName;
  final String description;
  final int rate;
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    CategoryController cc = Get.put(CategoryController());
    Kategori category = cc.getCategory(categoryId);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
      elevation: 4,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.album, color: Colors.cyan, size: 45),
            title: Text(
              pacientName,
              style: const TextStyle(fontSize: 16),
            ),
            subtitle: const Text('1 bulan yang lalu'),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 16.0),
            height: 30,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rate,
                itemBuilder: (context, i) {
                  return const Icon(
                    Icons.star,
                    color: Colors.amber,
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Kategori: ${category.name}',
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 16, color: Colors.black45),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
            child: Text(
              description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
