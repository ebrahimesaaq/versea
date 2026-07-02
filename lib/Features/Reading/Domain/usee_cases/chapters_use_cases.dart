import 'package:versea/Features/Reading/Domain/entities/chapter_entity.dart';

abstract class ChaptersUseCases {
  // late Future<ChapterEntity> saveLastRead;

  // late Future<ChapterEntity> selectChapter;

  Future<ChapterEntity> call();
}

class ReadingUseCase extends ChaptersUseCases {
  @override
  Future<ChapterEntity> call() {
    throw UnimplementedError();
  }
}
