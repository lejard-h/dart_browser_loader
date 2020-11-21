import 'dart:async';
import 'dart:html';

import 'package:pedantic/pedantic.dart';

Map<Element, Future> _mapper = {};

Future<T> waitLoad<T extends Element>(T element) async {
  if (_mapper[element] != null) {
    return _mapper[element] as T;
  }

  final completer = Completer<T>();

  unawaited(
    element.onLoad.first.then((_) {
      completer.complete(element);
    }),
  );

  unawaited(
    element.onError.first.then((e) {
      completer.completeError(e);
    }),
  );

  return _mapper[element] = completer.future;
}
