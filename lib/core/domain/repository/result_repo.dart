sealed class Result<T> {
  bool get isSuccess;

  const factory Result.data(T data) = DataResult;

  const factory Result.error(List<String> errorList) = ErrorResult;
}

class DataResult<T> implements Result<T> {
  final T data;

  const DataResult(this.data);

  @override
  bool get isSuccess => true;
}

class VoidResult<T> implements DataResult<T?> {
  @override
  bool get isSuccess => true;

  @override
  final T? data;

  const VoidResult([this.data]);
}

class ErrorResult<T> implements Result<T> {
  final List<String> errorList;

  const ErrorResult(this.errorList);

  @override
  bool get isSuccess => false;
}