import 'package:flutter/material.dart';
import 'package:sw_framework/Widgets/sw_screen.dart';

class DefaultSWScreen extends StatelessWidget {
  const DefaultSWScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SWScreen(
        title: "",
        builder: (context, provider, searchText, company) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sin Modulos",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Contacte a Secret Weapon para agregar o configurar un modulo",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
