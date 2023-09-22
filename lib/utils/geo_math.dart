import "dart:math";

void main() {
  //print(GeoMath.reserveTask(7273.856, 5241.656, 9833.813, 2165.041));
}

class GeoMath {
  static double _toRad([double deg = 180.0]) {
    return deg * pi / 180;
  }

  static double _toDeg(double radians) {
    return radians * (180.0 / pi);
  }

  static String toDeg([double degree = 0, double min = 0, double sec = 0]) {
    double deg = degree + min / 60 + sec / 3600;
    return deg.toStringAsFixed(5);
  }

  static Map<String, String> toGMS([double deg = 0]) {
    double min = ((deg - deg.toInt()) * 60);
    return {
      "deg": deg.floor().toString(),
      "min": min.toInt().toString(),
      "sec": ((min - min.toInt()) * 60).toStringAsFixed(2)
    }; 
  }

  static Map<String, String> directTask(double x1, double y1, double deg, double distance) {
    var radians = _toRad(deg);

    var dx = distance * cos(radians);
    var dy = distance * sin(radians);

    var x2 = x1 + dx;
    var y2 = y1 + dy;

    return {"x2": x2.toStringAsFixed(5), "y2": y2.toStringAsFixed(5)};
  }

  static Map<String, String> reserveTask(double x1, double y1, double x2, double y2) {
    var dx = x2 - x1;
    var dy = y2 - y1;

    var distance = sqrt(dx * dx + dy * dy);
    var angle = 0.0;
    
    if (dx == 0 && y2 > y1) {
      angle = 90;
    }
    else if (dx == 0 && y2 < y1) {
      angle = 270;
    }
    else {
      var rhumb = _toDeg(atan((dy/dx).abs()));
      if (dx >= 0 && dy > 0) {
        angle = rhumb;
      }
      else if (dx < 0 && dy <=0) {
        angle = 180 + rhumb;
      }
      else if (dx >= 0 && dy < 0) {
        angle = 360 - rhumb;
      }
      else if (dx < 0 && dy >= 0) {
        angle = 180 - rhumb;
      }
    }
    return {"dist": distance.toStringAsFixed(5), "angle": angle.toStringAsFixed(5)};
  }
}
