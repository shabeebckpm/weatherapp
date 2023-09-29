// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

Welcome welcomeFromMap(String str) => Welcome.fromMap(json.decode(str));

String welcomeToMap(Welcome data) => json.encode(data.toMap());

class Welcome {
    Coord coord;
    List<Weather> weather;
    String base;
    Main main;
    int visibility;
    Wind wind;
    Clouds clouds;
    int dt;
    Sys sys;
    int timezone;
    int id;
    String name;
    int cod;

    Welcome({
        required this.coord,
        required this.weather,
        required this.base,
        required this.main,
        required this.visibility,
        required this.wind,
        required this.clouds,
        required this.dt,
        required this.sys,
        required this.timezone,
        required this.id,
        required this.name,
        required this.cod,
    });

    factory Welcome.fromMap(Map<String, dynamic> json) => Welcome(
        coord: Coord.fromMap(json["coord"]),
        weather: List<Weather>.from(json["weather"].map((x) => Weather.fromMap(x))),
        base: json["base"],
        main: Main.fromMap(json["main"]),
        visibility: json["visibility"],
        wind: Wind.fromMap(json["wind"]),
        clouds: Clouds.fromMap(json["clouds"]),
        dt: json["dt"],
        sys: Sys.fromMap(json["sys"]),
        timezone: json["timezone"],
        id: json["id"],
        name: json["name"]??'null',
        cod: json["cod"],
    );

    Map<String, dynamic> toMap() => {
        "coord": coord.toMap(),
        "weather": List<dynamic>.from(weather.map((x) => x.toMap())),
        "base": base,
        "main": main.toMap(),
        "visibility": visibility,
        "wind": wind.toMap(),
        "clouds": clouds.toMap(),
        "dt": dt,
        "sys": sys.toMap(),
        "timezone": timezone,
        "id": id,
        "name": name,
        "cod": cod,
    };
}

class Clouds {
    int all;

    Clouds({
        required this.all,
    });

    factory Clouds.fromMap(Map<String, dynamic> json) => Clouds(
        all: json["all"],
    );

    Map<String, dynamic> toMap() => {
        "all": all,
    };
}

class Coord {
    double lon;
    double lat;

    Coord({
        required this.lon,
        required this.lat,
    });

    factory Coord.fromMap(Map<String, dynamic> json) => Coord(
        lon: json["lon"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "lon": lon,
        "lat": lat,
    };
}

class Main {
    double temp;
    double feelsLike;
    double tempMin;
    double tempMax;
    int pressure;
    int humidity;
   // int seaLevel;
    int grndLevel;

    Main({
        required this.temp,
        required this.feelsLike,
        required this.tempMin,
        required this.tempMax,
        required this.pressure,
        required this.humidity,
        //required this.seaLevel,
        required this.grndLevel,
    });

    factory Main.fromMap(Map<String, dynamic> json) => Main(
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        tempMin: json["temp_min"]?.toDouble(),
        tempMax: json["temp_max"]?.toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        //seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"]?? 0,
    );

    Map<String, dynamic> toMap() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
        //"sea_level": seaLevel,
        "grnd_level": grndLevel,
    };
}

class Sys {
    String country;
    int sunrise;
    int sunset;

    Sys({
        required this.country,
        required this.sunrise,
        required this.sunset,
    });

    factory Sys.fromMap(Map<String, dynamic> json) => Sys(
        country: json["country"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
    );

    Map<String, dynamic> toMap() => {
        "country": country,
        "sunrise": sunrise,
        "sunset": sunset,
    };
}

class Weather {
    int id;
    String main;
    String description;
    String icon;

    Weather({
        required this.id,
        required this.main,
        required this.description,
        required this.icon,
    });

    factory Weather.fromMap(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
    };
}

class Wind {
    double speed;
    int deg;
    double gust;

    Wind({
        required this.speed,
        required this.deg,
        required this.gust,
    });

    factory Wind.fromMap(Map<String, dynamic> json) => Wind(
        speed: json["speed"]?.toDouble(),
        deg: json["deg"],
        gust: json["gust"]?.toDouble()??0.0,
    );

    Map<String, dynamic> toMap() => {
        "speed": speed,
        "deg": deg,
        "gust": gust,
    };
}
