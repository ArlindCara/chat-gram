import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddNewUserButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function() onTap;
  final Color? color;
  AddNewUserButton(this.icon, this.title, this.onTap, {this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.pink[50],
          ),
          child: Row(
            children: <Widget>[
              Icon(
                this.icon,
                color: color != null ? color : Colors.blue,
                size: 20,
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                this.title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }
}
