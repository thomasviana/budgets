abstract class Resource<T> {
  const Resource();

  R fold<R>(
    R Function() ifInitial,
    R Function() ifLoading,
    R Function(T data) ifData,
    R Function(Exception error) ifError,
  );

  void when({
    void Function()? isInitial,
    void Function()? isLoading,
    void Function(T data)? isData,
    void Function(Exception error)? isError,
  }) {
    isInitial ??= () {};
    isLoading ??= () {};
    isData ??= (d) {};
    isError ??= (e) {};

    fold(isInitial, isLoading, isData, isError);
  }

  T getOrElse(T Function() dflt) {
    return fold(dflt, dflt, (data) => data, (_) => dflt());
  }

  T operator |(T dflt) => getOrElse(() => dflt);

  bool isInitial() => fold(() => true, () => false, (_) => false, (_) => false);

  bool isLoading() => fold(() => false, () => true, (_) => false, (_) => false);

  bool isData() => fold(() => false, () => false, (_) => true, (_) => false);

  bool isError() => fold(() => false, () => false, (_) => false, (_) => true);

  bool isErrorOfType<E extends Exception>() =>
      fold(() => false, () => false, (_) => false, (error) => error is E);

  Resource<R> map<R>(R Function(T t) mapper) {
    return fold(initial, loading, (t) => data(mapper(t)), error);
  }

  @override
  String toString() => fold(
        () => 'Initial',
        () => 'Loading',
        (t) => 'Data($t)',
        (e) => 'Error($e)',
      );

  static Resource<T> initial<T>() => Initial();

  static Resource<T> loading<T>() => Loading();

  static Resource<T> data<T>(T t) => Data(t);

  static Resource<T> error<T>(Exception e) => Error(e);
}

class Initial<T> extends Resource<T> {
  const Initial();

  @override
  R fold<R>(
    R Function() ifInitial,
    R Function() ifLoading,
    R Function(T data) ifData,
    R Function(Exception error) ifError,
  ) {
    return ifInitial();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Initial && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class Loading<T> extends Resource<T> {
  const Loading();

  @override
  R fold<R>(
    R Function() ifInitial,
    R Function() ifLoading,
    R Function(T data) ifData,
    R Function(Exception error) ifError,
  ) {
    return ifLoading();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Loading && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class Data<T> extends Resource<T> {
  final T _d;

  const Data(this._d);

  T get value => _d;

  @override
  R fold<R>(
    R Function() ifInitial,
    R Function() ifLoading,
    R Function(T data) ifData,
    R Function(Exception error) ifError,
  ) {
    return ifData(_d);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Data && runtimeType == other.runtimeType && _d == other._d;

  @override
  int get hashCode => _d.hashCode;
}

class Error<T> extends Resource<T> {
  final Exception _e;

  const Error(this._e);

  Exception get value => _e;

  @override
  R fold<R>(
    R Function() ifInitial,
    R Function() ifLoading,
    R Function(T data) ifData,
    R Function(Exception error) ifError,
  ) {
    return ifError(_e);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Error && runtimeType == other.runtimeType && _e == other._e;

  @override
  int get hashCode => _e.hashCode;
}
