enum LoadingStatus {
  pure,
  loading,
  loadSuccess,
  loadFailure;

  bool get isPure => this == pure;

  bool get isLoading => this == loading || this == LoadingStatus.loading;

  bool get isLoadSuccess => this == loadSuccess;

  bool get isLoadFailure => this == loadFailure;
}
