import 'package:http/http.dart';
import 'dart:convert';

class worker {
  late String location;

  //Constructor
  worker({required this.location}) {
    location = this.location;
  }
  late String temp;
  late String humidity;
  late String air_speed;
  late String description;
  late String main;
  late String icon;
  //method
  Future<void> getdata() async {
    try {
      Response response = await get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=afbc6892923e3907fc61bce809884b30"));
      Map data = jsonDecode(response.body);
      print(data);

      //Getting Temp,Humidity
      Map temp_data = data['main'];
      String getHumidity = temp_data['humidity'].toString();
      double getTemp = temp_data['temp'] - 273.15;

      //Getting Air_Speed
      Map wind = data['wind'];
      double getAir_speed = wind['speed'] / 0.27777777777778;

      //Getting Description
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getMain_des = weather_main_data['main'];
      String getDesc = weather_main_data["description"];

      //Assigning Values
      temp = getTemp.toString(); //degree Celsius
      humidity = getHumidity; //%
      air_speed = getAir_speed.toString(); //km/hour
      description = getDesc;
      main = getMain_des;
      icon = weather_main_data["icon"].toString();
    } catch (e) {
      temp = "NA";
      humidity = "NA";
      air_speed = "NA";
      description = "Data not found!";
      main = "NA";
      icon = "09n";
    }
  }
}
