// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherModelAdapter extends TypeAdapter<WeatherModel> {
  @override
  final int typeId = 0;

  @override
  WeatherModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherModel(
      cityName: fields[0] as String,
      icon: fields[1] as String,
      condition: fields[2] as String,
      temp: fields[3] as double,
      wind: fields[4] as double,
      humidity: fields[5] as int,
      windDir: fields[6] as String,
      gust: fields[7] as double,
      uv: fields[8] as double,
      pressure: fields[9] as double,
      precipe: fields[10] as double,
      lastUpdate: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.cityName)
      ..writeByte(1)
      ..write(obj.icon)
      ..writeByte(2)
      ..write(obj.condition)
      ..writeByte(3)
      ..write(obj.temp)
      ..writeByte(4)
      ..write(obj.wind)
      ..writeByte(5)
      ..write(obj.humidity)
      ..writeByte(6)
      ..write(obj.windDir)
      ..writeByte(7)
      ..write(obj.gust)
      ..writeByte(8)
      ..write(obj.uv)
      ..writeByte(9)
      ..write(obj.pressure)
      ..writeByte(10)
      ..write(obj.precipe)
      ..writeByte(11)
      ..write(obj.lastUpdate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
