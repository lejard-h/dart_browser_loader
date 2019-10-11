import 'dart:async';
import 'dart:html';

Map<Element, Future> _mapper = {};

Future<T> waitLoad<T extends Element>(T element) {
  if (_mapper.containsKey(element)) {
    return _mapper[element];
  }

  final completer = Completer<T>();
  element.onLoad.first.then((_) {
    completer.complete(element);
  });

  element.onError.first.then((e) {
    completer.completeError(e);
  });

  return _mapper[element] = completer.future;
}
