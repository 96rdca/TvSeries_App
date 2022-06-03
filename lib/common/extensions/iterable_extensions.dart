extension MyIterable<E> on Iterable<E> {
  Iterable<E> sortedBy(Comparable Function(E e) key) =>
      toList()..sort((a, b) => key(a).compareTo(key(b)));

  Iterable<E> sortByDescending(Comparable Function(E e) key) =>
      toList()..sort((a, b) => key(b).compareTo(key(a)));
}
