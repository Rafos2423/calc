import 'package:calc/utils/styles.dart';
import 'package:flutter/material.dart';
import '../utils/geo_math.dart';

void main() => runApp(const DegGMS());

class DegGMS extends StatefulWidget {
  const DegGMS({super.key});

  @override
  State<DegGMS> createState() => NameState();
}

class NameState extends State<DegGMS> {
  final Map<String, TextEditingController> controllers = {
    "doubleDegrees": TextEditingController(),
    "degrees": TextEditingController(),
    "minutes": TextEditingController(),
    "seconds": TextEditingController(),
  };

  double toDouble(TextEditingController controller) {
    if (controller.text.isEmpty) throw Exception();
    var value = double.tryParse(controller.text);
    if (value == null) throw Exception();
    return value;
  }

  void auto() {
    toGMS() ? () : toDeg();
  }

  bool toGMS() {
    try {
      var deg = toDouble(controllers["doubleDegrees"]!);
      var result = GeoMath.toGMS(deg);

      controllers["doubleDegrees"]!.text = "";
      controllers["degrees"]!.text = result["deg"]!;
      controllers["minutes"]!.text = result["min"]!;
      controllers["seconds"]!.text = result["sec"]!;
    } catch (ex) {
      return false;
    }
    return true;
  }

  bool toDeg() {
    try {
      var deg = toDouble(controllers["degrees"]!);
      var min = toDouble(controllers["minutes"]!);
      var sec = toDouble(controllers["seconds"]!);

      var result = GeoMath.toDeg(deg, min, sec);

      controllers["doubleDegrees"]!.text = result;
      controllers["degrees"]!.text = "";
      controllers["minutes"]!.text = "";
      controllers["seconds"]!.text = "";
    } catch (ex) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            children: [
              const Center(),
              StyleState().drawBorderField(this, toGMS,
                  controllers["doubleDegrees"]!, "Десятичные градусы:"),
              const SizedBox(height: 30),
              StyleState().drawRotateCalcButton(auto),
              const SizedBox(height: 30),
              StyleState().drawNoBorderField(
                  this, toDeg, controllers["degrees"]!, "Градусы:"),
              const SizedBox(height: 25),
              StyleState().drawNoBorderField(
                  this, toDeg, controllers["minutes"]!, "Минуты:"),
              const SizedBox(height: 25),
              StyleState().drawNoBorderField(
                  this, toDeg, controllers["seconds"]!, "Секунды:"),
            ],
          ),
        ),
      ),
    );
  }
}
