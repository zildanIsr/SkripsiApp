import 'package:flutter/material.dart';

import 'package:skeletons/skeletons.dart';

class CardSkeleton extends StatelessWidget {
  const CardSkeleton({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: count,
      shrinkWrap: true,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: SkeletonItem(
              child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                        shape: BoxShape.rectangle,
                        width: 130,
                        height: 130,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 5,
                          lineStyle: SkeletonLineStyle(
                            randomLength: true,
                            height: 14,
                            borderRadius: BorderRadius.circular(8),
                            minLength: MediaQuery.of(context).size.width / 6,
                            maxLength: MediaQuery.of(context).size.width / 2,
                          )),
                    ),
                  )
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }
}

class ProfilSkeleton extends StatelessWidget {
  const ProfilSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 350,
            color: Colors.grey.shade300,
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                const Positioned(
                  left: 50,
                  right: 50,
                  top: 80,
                  child: Column(
                    children: [
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                            shape: BoxShape.circle,
                            width: 140,
                            height: 140,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                            height: 24,
                            width: 200,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            alignment: Alignment.center),
                      )
                    ],
                  ),
                ),
                Positioned(
                    bottom: -50,
                    left: 50,
                    right: 50,
                    child: Card(
                      elevation: 4.0,
                      child: Container(
                        height: 90,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 16.0),
                        child: const Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        alignment: Alignment.center),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        alignment: Alignment.center),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        alignment: Alignment.center),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        alignment: Alignment.center),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        alignment: Alignment.center),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        alignment: Alignment.center),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 70.0,
          ),
          const SkeletonLine(
            style: SkeletonLineStyle(
                height: 18,
                width: 250,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                alignment: Alignment.centerLeft),
          ),
          const SizedBox(
            height: 16.0,
          ),
          SkeletonParagraph(
            style: SkeletonParagraphStyle(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                lines: 3,
                lineStyle: SkeletonLineStyle(
                  randomLength: true,
                  height: 14,
                  borderRadius: BorderRadius.circular(8),
                  minLength: MediaQuery.of(context).size.width / 8,
                  maxLength: MediaQuery.of(context).size.width / 2,
                )),
          ),
          const SizedBox(
            height: 24.0,
          ),
          const SkeletonLine(
            style: SkeletonLineStyle(
                height: 18,
                width: 250,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                alignment: Alignment.centerLeft),
          ),
          const SizedBox(
            height: 16.0,
          ),
          SkeletonParagraph(
            style: SkeletonParagraphStyle(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                lines: 3,
                lineStyle: SkeletonLineStyle(
                  randomLength: true,
                  height: 14,
                  borderRadius: BorderRadius.circular(8),
                  minLength: MediaQuery.of(context).size.width / 8,
                  maxLength: MediaQuery.of(context).size.width / 2,
                )),
          ),
          const SizedBox(
            height: 24.0,
          ),
          const SkeletonLine(
            style: SkeletonLineStyle(
                height: 18,
                width: 250,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                alignment: Alignment.centerLeft),
          ),
          const SizedBox(
            height: 16.0,
          ),
          SkeletonParagraph(
            style: SkeletonParagraphStyle(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                lines: 3,
                lineStyle: SkeletonLineStyle(
                  randomLength: true,
                  height: 14,
                  borderRadius: BorderRadius.circular(8),
                  minLength: MediaQuery.of(context).size.width / 8,
                  maxLength: MediaQuery.of(context).size.width / 2,
                )),
          ),
        ],
      ),
    );
  }
}

class HistoryCardSkeleton extends StatelessWidget {
  const HistoryCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        //color: Colors.blue,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) => Container(
            //color: Colors.amber,
            width: MediaQuery.of(context).size.width,
            height: 180.0,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Card(
              //color: Colors.green,
              elevation: 4.0,
              //clipBehavior: Clip.hardEdge,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Expanded(
                    child: SkeletonLine(
                      style: SkeletonLineStyle(
                          height: 18,
                          width: 280,
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          alignment: Alignment.centerLeft),
                    ),
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  const Divider(
                    height: 1.0,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SkeletonParagraph(
                          style: SkeletonParagraphStyle(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 14.0),
                              lines: 3,
                              lineStyle: SkeletonLineStyle(
                                randomLength: true,
                                height: 14,
                                borderRadius: BorderRadius.circular(8),
                                minLength:
                                    MediaQuery.of(context).size.width / 4,
                                maxLength:
                                    MediaQuery.of(context).size.width / 1.5,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class RatingSkeletons extends StatelessWidget {
  const RatingSkeletons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
      elevation: 4,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const ListTile(
            leading: SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  shape: BoxShape.circle,
                  width: 45,
                  height: 45,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
            title: SkeletonLine(
              style: SkeletonLineStyle(
                  height: 14,
                  width: 200,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  alignment: Alignment.centerLeft),
            ),
            subtitle: SkeletonLine(
              style: SkeletonLineStyle(
                  height: 12,
                  width: 150,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  alignment: Alignment.centerLeft),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 16.0),
            height: 30,
            child: const SkeletonLine(
              style: SkeletonLineStyle(
                  height: 12,
                  width: 150,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  alignment: Alignment.centerLeft),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SkeletonLine(
              style: SkeletonLineStyle(
                  height: 12,
                  width: 150,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  alignment: Alignment.centerLeft),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
            child: SkeletonParagraph(
              style: SkeletonParagraphStyle(
                  padding: EdgeInsets.zero,
                  lines: 2,
                  lineStyle: SkeletonLineStyle(
                    randomLength: true,
                    height: 14,
                    borderRadius: BorderRadius.circular(8),
                    minLength: MediaQuery.of(context).size.width / 2,
                    maxLength: MediaQuery.of(context).size.width,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
