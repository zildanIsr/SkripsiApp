import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/skeleton.dart';
import 'package:get/get.dart';

import '../Controllers/address_controller.dart';

class ListAddress extends StatelessWidget {
  const ListAddress({super.key});

  @override
  Widget build(BuildContext context) {
    AddressController ac = Get.put(AddressController());

    return Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Alamat'),
        ),
        body: Obx(
          () => ac.isLoading.value
              ? const CardSkeleton()
              : ac.addressbyUser.isEmpty
                  ? const Center(
                      child: Text(
                        "Belum ada alamat",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : const Address(),
        ),
        floatingActionButton: Obx(
          () => ac.isLoading.value
              ? Container()
              : FloatingActionButton(
                  onPressed: () {
                    Get.toNamed('/maps-maker');
                  },
                  child: const Icon(Icons.add_home_sharp),
                ),
        ));
  }
}

class Address extends StatelessWidget {
  const Address({super.key});

  @override
  Widget build(BuildContext context) {
    AddressController ac = Get.find<AddressController>();
    return RefreshIndicator(
      onRefresh: () async {
        ac.refreshData();
      },
      child: SizedBox(
        //color: Colors.amber,
        width: double.infinity,
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
          itemCount: ac.addressbyUser.length,
          itemBuilder: (context, item) {
            return Obx(() => Item(
                  key: ValueKey(ac.addressbyUser[item].id),
                  address:
                      "${ac.addressbyUser[item].street}, ${ac.addressbyUser[item].sublocality}, ${ac.addressbyUser[item].locality}, ${ac.addressbyUser[item].subadminisArea}, ${ac.addressbyUser[item].adminisArea} ${ac.addressbyUser[item].postalCode}, ${ac.addressbyUser[item].country}",
                  seleceted: ac.selectedAddress.value,
                  value: ac.addressbyUser[item].id!,
                  id: ac.addressbyUser[item].id!,
                ));
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: 2,
              thickness: 1,
            );
          },
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item(
      {super.key,
      required this.address,
      required this.seleceted,
      required this.value,
      required this.id});

  final String address;
  final int seleceted;
  final int value;
  final int id;

  @override
  Widget build(BuildContext context) {
    AddressController ac = Get.find<AddressController>();

    showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Menghapus Alamat'),
              content: const Text('Apa kamu yakin menghapus alamat ini?'),
              actions: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.pink)),
                  onPressed: () {
                    ac.deletedAddress(id);
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Iya'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Tidak'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        width: double.infinity,
        //color: Colors.amber,
        child: ListTile(
          selected: value == seleceted ? true : false,
          selectedColor: Colors.pinkAccent,
          shape: RoundedRectangleBorder(
            //side: BorderSide(),
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
          leading: const Icon(
            Icons.home_filled,
            size: 50,
            color: Colors.pink,
          ),
          title: Text(
            address,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      showExitPopup();
                    },
                    child: const Text('Hapus alamat')),
              ],
            ),
          ),
          onTap: () {
            ac.onChangedSelectedAddress(value);
            ac.stringAddress(address);
          },
          trailing: Radio(
              value: value,
              groupValue: seleceted,
              onChanged: ((val) {
                ac.onChangedSelectedAddress(val);
                ac.stringAddress(address);
                //print(ac.selectedAddress.value);
              })),
        ));
  }
}
