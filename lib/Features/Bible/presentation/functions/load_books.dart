class LoadBooks {
  Future<void> loadBooks({
    required Map<String, dynamic> books,
    required Map<String, dynamic> chapters,
    required Map<String, dynamic> oldBooks,
    required Map<String, dynamic> oldChapters,
    required Map<String, dynamic> newChapters,
    required Map<String, dynamic> newBooks,
    required apiFunctions,
    required setState,
  }) async {
    books = await apiFunctions.getBooksFunction();
    chapters = await apiFunctions.getChaptersFunction();

    int newIndex = 1;
    int oldIndex = 1;

    for (int index = 1; index <= books.length; index++) {
      if (index >= 50) {
        newBooks[newIndex.toString()] = books[index.toString()];
        newChapters[newIndex.toString()] = chapters[index.toString()];
        newIndex++;
      } else {
        oldBooks[oldIndex.toString()] = books[index.toString()];
        oldChapters[oldIndex.toString()] = chapters[index.toString()];
        oldIndex++;
      }
    }
    updateData() {
      setState();
    }

    updateData();
  }
}
