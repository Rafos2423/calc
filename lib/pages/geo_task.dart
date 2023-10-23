import 'package:calc/utils/geo_math.dart';
import 'package:calc/utils/styles.dart';
import 'package:flutter/material.dart';

void main() => runApp(const GeoTask());

class GeoTask extends StatefulWidget {
  const GeoTask({super.key});

  @override
  State<GeoTask> createState() => NameState();
}

class NameState extends State<GeoTask> {
  final Map<String, TextEditingController> controllers = {
    "x1": TextEditingController(),
    "y1": TextEditingController(),
    "angle": TextEditingController(),
    "dist": TextEditingController(),
    "x2": TextEditingController(),
    "y2": TextEditingController(),
  };

  double toDouble(TextEditingController controller) {
    if (controller.text.isEmpty) throw Exception();
    var value = double.tryParse(controller.text);
    if (value == null) throw Exception();
    return value;
  }

  void auto()
  {
    directTask() ? () : reverseTask();
  }

  bool directTask() {
    try {
      var x1 = toDouble(controllers["x1"]!);
      var y1 = toDouble(controllers["y1"]!);
      var angle = toDouble(controllers["angle"]!);
      var dist = toDouble(controllers["dist"]!);

      var result = GeoMath.directTask(x1, y1, angle, dist);

      controllers["angle"]!.text = "";
      controllers["dist"]!.text = "";
      controllers["x2"]!.text = result["x2"]!;
      controllers["y2"]!.text = result["y2"]!;
    }
    catch (ex) {
      return false;
    }
    return true;
  }

  bool reverseTask() {
    try {
      var x1 = toDouble(controllers["x1"]!);
      var y1 = toDouble(controllers["y1"]!);
      var x2 = toDouble(controllers["x2"]!);
      var y2 = toDouble(controllers["y2"]!);

      var result = GeoMath.reserveTask(x1, y1, x2, y2);

      controllers["angle"]!.text = result["angle"]!;
      controllers["dist"]!.text = result["dist"]!;
      controllers["x2"]!.text = "";
      controllers["y2"]!.text = "";
    }
    catch (ex) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 120),
          child: Column(
            children: [
              StyleState().drawBorderField(
                  this, auto, controllers["x1"]!, "X1:",
                  width: 120.0),
              const SizedBox(height: 25),
              StyleState().drawBorderField(
                  this, auto, controllers["y1"]!, "Y1:",
                  width: 120.0),
              const SizedBox(height: 15),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("/", style: TextStyle(fontSize: 40, color: color)),
                  SizedBox(width: 110),
                  Text("\\", style: TextStyle(fontSize: 40, color: color)),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      StyleState().drawNoBorderField(
                          this, directTask, controllers["angle"]!, "Угол:",
                          width: 120),
                      const SizedBox(height: 25),
                      StyleState().drawNoBorderField(
                          this, directTask, controllers["dist"]!, "Расстояние:",
                          width: 120)
                    ],
                  ),
                  const SizedBox(width: 20),
                  StyleState().drawCalcButton(auto),
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      StyleState().drawNoBorderField(
                          this, reverseTask, controllers["x2"]!, "X2:",
                          width: 120),
                      const SizedBox(height: 25),
                      StyleState().drawNoBorderField(
                          this, reverseTask, controllers["y2"]!, "Y2:",
                          width: 120)
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text("Прямая ГЗ", style: TextStyle(fontSize: 18, color: color)),
                    ]
                  ),
                  SizedBox(width: 90),
                  Column(
                    children: [
                      Text("Обратная ГЗ", style: TextStyle(fontSize: 18, color: color))
                    ]
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
