import 'package:flutter/material.dart';
class MenuItems extends StatelessWidget {
  const MenuItems({Key? key, required this.icon, required this.title, this.ontap}) : super(key: key);

  final IconData icon;
  final String title;
  final Function? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap?.call(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon,color: Colors.white,size: 30,),
            SizedBox(width: 10,),
            Text(title,style: TextStyle(fontSize: 20,color: Colors.white),)
          ],
        ),
      ),
    );
  }
}
