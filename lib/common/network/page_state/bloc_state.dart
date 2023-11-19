enum Status{
  initial,
  loading,
  success,
  error
}
class BlocState{
  final Status status;
final String error;

  BlocState({required this.status, required this.error});

  bool isInitial()=>status==Status.initial;
bool isLoading()=>status==Status.loading;
  bool isSuccess()=>status==Status.success;
  bool isFailure()=>status==Status.error;

}