// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChapterModelAdapter extends TypeAdapter<ChapterModel> {
  @override
  final int typeId = 1;

  @override
  ChapterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChapterModel(
      bookName: fields[0] as String,
      text: fields[1] as String,
      bookID: fields[2] as int,
      chapterID: fields[3] as int,
      verses: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ChapterModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.bookName)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.bookID)
      ..writeByte(3)
      ..write(obj.chapterID)
      ..writeByte(4)
      ..write(obj.verses);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChapterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
