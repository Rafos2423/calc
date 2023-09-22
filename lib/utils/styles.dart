import 'package:flutter/material.dart';

void main() => runApp(const Styles());

const Color color = Color.fromRGBO(240, 98, 146, 1);

class Styles extends StatefulWidget {
  const Styles({super.key});
  @override
  State<Styles> createState() => StyleState();
}

class StyleState extends State<Styles> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  @override
  void initState() {
    super.initState();
  }

  Container drawBorderField(State<StatefulWidget> widget, Function func,
      TextEditingController controller, String label,
      {double width = 300}) {
    return Container(
      width: width,
      child: TextField(
        cursorColor: color,
        controller: controller,
        onSubmitted: (value) {
          widget.setState(() => func());
        },
        style: const TextStyle(color: color),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(color: color),
          enabledBorder: border,
          focusedBorder: border,
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
      ),
    );
  }

  Container drawNoBorderField(State<StatefulWidget> widget, Function func,
      TextEditingController controller, String label,
      {double width = 300}) {
    return Container(
      decoration: const BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: width,
      child: TextField(
        cursorColor: Colors.white,
        controller: controller,
        onSubmitted: (value) {
          widget.setState(() => func());
        },
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(color: Colors.white),
          enabledBorder: noBorder,
          focusedBorder: noBorder,
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
      ),
    );
  }

  Widget drawRotateCalcButton(Function func) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        alignment: Alignment.bottomCenter,
        padding: const MaterialStatePropertyAll(EdgeInsets.zero),
        fixedSize: const MaterialStatePropertyAll(Size(0, 120)),
        backgroundColor: MaterialStateProperty.all(color),
        shadowColor: MaterialStateProperty.all(Colors.black),
        elevation: MaterialStateProperty.all(5),
      ),
      onPressed: () => func(),
      child: Center(child: StyleState().rotateLabel),
    );
  }

  Widget drawCalcButton(Function func) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        padding: const MaterialStatePropertyAll(EdgeInsets.zero),
        fixedSize: const MaterialStatePropertyAll(Size(80, 50)),
        backgroundColor: MaterialStateProperty.all(color),
        shadowColor: MaterialStateProperty.all(Colors.black),
        elevation: MaterialStateProperty.all(5),
      ),
      onPressed: () => func(),
      child: const Center(
        child: Text(
          "<=>",
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  RotatedBox rotateLabel = const RotatedBox(
    quarterTurns: 1,
    child: Text(
      "<=>",
      style: TextStyle(
          fontSize: 45, color: Colors.white, fontWeight: FontWeight.w400),
    ),
  );

  OutlineInputBorder border = const OutlineInputBorder(
    borderSide: BorderSide(
      width: 2,
      color: color,
    ),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  OutlineInputBorder noBorder = const OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );
}
