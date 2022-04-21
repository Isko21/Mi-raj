import 'package:daily_muslim/components/properties.dart';
import 'package:daily_muslim/components/shared_pref.dart';
import 'package:flutter/material.dart';

class PickerItem {
  String label;

  PickerItem(this.label);
}

class PickerWidget extends StatefulWidget {
  final List<PickerItem> pickerItems;

  const PickerWidget({
    Key? key,
    required this.pickerItems,
  }) : super(key: key);

  @override
  _PickerWidgetState createState() => _PickerWidgetState();
}

class _PickerWidgetState extends State<PickerWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(color: white),
      itemBuilder: (context, index) {
        PickerItem pickerItem = widget.pickerItems[index];
        bool isItemSelected = index == calcMethod;
        return InkWell(
          onTap: () {
            setState(() {});
            calcMethod = index;
            switch (calcMethod) {
              case 0:
                calcMet = 'Egyptian General Authority of Survey';
                break;
              case 1:
                calcMet = 'University of Islamic Sciences, Karachi';
                break;
              case 2:
                calcMet = 'Kuwait';
                break;
              case 3:
                calcMet = 'Moonsighting Committee Worldwide';
                break;
              case 4:
                calcMet = 'Muslim World League';
                break;
              case 5:
                calcMet = 'Islamic Society of North America';
                break;
              case 6:
                calcMet = 'Qatar';
                break;
              case 7:
                calcMet = 'Majlis Ugama Islam Singapura';
                break;
              case 8:
                calcMet = 'Institute of Geophysics, University of Tehran';
                break;
              case 9:
                calcMet = 'Diyanet İşleri Başkanlığı, Turkey';
                break;
              case 10:
                calcMet = 'Umm Al-Qura University, Makkah';
                break;
            }
            AllUserData.setLocationData(calcMet, 'calc');
            calcMet = AllUserData.getLocationData('calc');
          },
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      pickerItem.label,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  isItemSelected
                      ? Icon(
                          Icons.check_circle,
                          size: 16,
                          color: white,
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: widget.pickerItems.length,
    );
  }
}
