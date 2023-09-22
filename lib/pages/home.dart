import 'package:flutter/material.dart';
import 'deg_gms.dart';
import 'geo_task.dart';

void main() => runApp(const HomePage());

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => NameState();
}

const Color color = Color.fromRGBO(240, 98, 146, 1);

class NameState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 100),
            const Center(
              child: Text(
                'GeoCalc',
                style: TextStyle(
                  color: color,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: 120),
            _getButton(context, const DegGMS(), 'ГМС и десятичные градусы'),
            const SizedBox(height: 50),
            _getButton(context, const GeoTask(), 'Геодезические задачи'),
          ],
        ),
      ),
    );
  }
}

Widget _getButton(BuildContext context, root, String text) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => root),
      );
    },
    style: ButtonStyle(
      alignment: Alignment.center,
      fixedSize: const MaterialStatePropertyAll(Size(320, 90)),
      backgroundColor: MaterialStateProperty.all(color),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    ),
    child: Text(
      text,
      style: const TextStyle(
      fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    )
  );
}
