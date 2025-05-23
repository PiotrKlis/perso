import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/src/transformers/backpressure/debounce.dart';
import 'package:rxdart/src/transformers/flat_map.dart';

EventTransformer<T> debounce<T>(Duration duration) =>
    (events, mapper) => events.debounceTime(duration).flatMap(mapper);
