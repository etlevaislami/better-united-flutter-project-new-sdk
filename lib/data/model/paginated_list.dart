class PaginatedList<T> {
  final List<T> data;
  final int totalPages;
  final int currentPage;
  final int totalItemCount;

  PaginatedList(
      this.data, this.totalPages, this.currentPage, this.totalItemCount);

  bool isLastPage() => totalPages == currentPage;
}
