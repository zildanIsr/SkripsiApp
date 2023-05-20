import 'package:flutter/material.dart';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import '../extensions/datetime_extensions.dart';

class PesanVieww extends StatelessWidget {
  const PesanVieww({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan'),
        centerTitle: true,
      ),
      body: const OrderForm(),
    );
  }
}

class OrderForm extends StatelessWidget {
  const OrderForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    //final mediaQueryHeight = MediaQuery.of(context).size.height;    
    return Container(
      //color: Colors.amber,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text("Pilih Tanggal", 
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
          Expanded(
            child: Container(
              //color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  DatePicker(
                    DateTime.now(),
                    width: 100,
                    height: 100,
                    //controller: _controller,
                    monthTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    dayTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    dateTextStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    //initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.pinkAccent,
                    selectedTextColor: Colors.white,
                    daysCount: DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day - (DateTime.now().day - 1),
                    activeDates: [                      
                      DateTime.now().add(const Duration(days: 2)),
                      DateTime.now().add(const Duration(days: 5)),
                      DateTime.now().add(const Duration(days: 8)),
                     
                    ],
                    onDateChange: ((selectedDate) {
                      
                    }),
                  ),
                ],
              ),
            )
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
            child: Text("Pilih Waktu", 
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
          const Expanded(
            child: TimePickerRange(
              firstTime: TimeOfDay(hour: 7, minute: 00),
              endTime: TimeOfDay(hour: 21, minute: 00),
            )
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topRight,
              padding: const EdgeInsets.all(16.0),
              //color: Colors.green,
              child: FloatingActionButton.extended(
                onPressed: (){},
                icon: const Icon(Icons.navigate_next_rounded),
                label: const Text("Lanjut"),
              ),
            )
          ),
          const SizedBox(
            height: 30.0,
          )
        ],
      ),
    );
  }
}

class TimePickerRange extends StatefulWidget {
  const TimePickerRange({
    Key? key, required this.firstTime, required this.endTime,
  }) : super(key: key);

  final TimeOfDay firstTime;
  final TimeOfDay endTime;

  @override
  State<TimePickerRange> createState() => _TimePickerRangeState();
}

class _TimePickerRangeState extends State<TimePickerRange> {
  @override
  Widget build(BuildContext context) {
    
    DateTime time = DateTime.now();
    DateTime cvtFirstTime = time.setTimeOfDay(widget.firstTime);
    DateTime cvtEndTime = time.setTimeOfDay(widget.endTime);
    List<DateTime> listTimeAvailable = [];
    //List<Widget> listWidgetTime = [];

    while(cvtFirstTime.compareTo(cvtEndTime) != 0 ){
      DateTime getTime = cvtFirstTime.add(const Duration(hours: 1));
      listTimeAvailable.add(getTime);

      cvtFirstTime= cvtFirstTime.add(const Duration(hours: 1));
    }
    
    List<bool> selectedTime = [false, true, false, false];
    // for (var i in listTimeAvailable) {
    //   listWidgetTime.add(
    //     Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Text('data')
    //       ),
    //   );
    // }


    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      //color: Colors.red,
      child: Ink(
       color: Colors.white,
       child: GridView.count(
          primary: true,
          crossAxisCount: 5, //set the number of buttons in a row
          mainAxisSpacing: 8,
          crossAxisSpacing: 8, //set the spacing between the buttons
          childAspectRatio: 2, //set the width-to-height ratio of the button, 
                               //>1 is a horizontal rectangle
          children: List.generate(selectedTime.length, (index) {
            //using Inkwell widget to create a button
            return InkWell( 
                splashColor: Colors.yellow, //the default splashColor is grey
                onTap: () {
                  //set the toggle logic
                  setState(() { 
                    for (int indexBtn = 0;
                        indexBtn < selectedTime.length;
                        indexBtn++) {
                      if (indexBtn == index) {
                        selectedTime[indexBtn] = true;
                      } else {
                        selectedTime[indexBtn] = false;
                      }
                    }
                  });
                },
                child: Ink(
                  decoration: BoxDecoration(
                 //set the background color of the button when it is selected/ not selected
                    color: selectedTime[index] ? Color.fromARGB(255, 238, 146, 226) : Colors.white, 
                    // here is where we set the rounded corner
                    borderRadius: BorderRadius.circular(8), 
                    //don't forget to set the border, 
                    //otherwise there will be no rounded corner
                    border: Border.all(color: Colors.red), 
                  ),
                  child: Text('${listTimeAvailable[index].hour}:${listTimeAvailable[index].minute}', 
                      //set the color of the icon when it is selected/ not selected
                      style: TextStyle(
                        color: selectedTime[index] ? Colors.blue : Colors.grey), 
                      ),
                ));
          }),
        ),
      )
    );
  }
}