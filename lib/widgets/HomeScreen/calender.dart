import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calender extends StatefulWidget {
  final Function updateSubjectList;
  final DateTime chosenDate;
  Calender(this.updateSubjectList, this.chosenDate);
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  List<Map<String, Object>> get dates {
    return List.generate(
      5,
      (index) {
        final todayDate = DateTime.now().add(
          Duration(days: index),
        );
        return {'day': todayDate};
      },
    );
  }

  Widget datebuilder(DateTime day) {
    String formattedDate = DateFormat.d().format(day);
    String chosenDate = DateFormat.d().format(widget.chosenDate);
    String tommorowDate = DateFormat.d().format(
      widget.chosenDate.add(
        Duration(days: 1),
      ),
    );
    String yesterdayDate = DateFormat.d().format(
      widget.chosenDate.subtract(
        Duration(days: 1),
      ),
    );

    if (formattedDate == chosenDate) {
      return Text(
        formattedDate,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(253, 145, 145, 1),
        ),
      );
    } else if (formattedDate == tommorowDate ||
        formattedDate == yesterdayDate) {
      return Text(
        formattedDate,
        style: TextStyle(
          fontSize: 25,
          color: Color.fromRGBO(253, 145, 145, 1),
        ),
      );
    }
    return Text(
      formattedDate,
      style: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(253, 145, 145, 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        ...dates.map(
          (data) {
            //Calender logic
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: GestureDetector(
                onTap: () => widget.updateSubjectList(data['day']),
                child: datebuilder(data['day']),
              ),
            );
          },
        ).toList(),
      ],
    );
  }
}
