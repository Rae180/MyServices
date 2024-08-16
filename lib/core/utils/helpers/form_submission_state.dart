

abstract class FormSubmissionState{

 const FormSubmissionState();
 
}

class InitialFormState extends FormSubmissionState {
  const InitialFormState();
}

class SelectCategory extends FormSubmissionState{}

class FormSubmittingState extends FormSubmissionState {}

class FormSuccesfulState extends FormSubmissionState {}

class FormNoInternetState extends FormSubmissionState {}

class FormNetworkErrorState extends FormSubmissionState {
  final String message;
  const FormNetworkErrorState({required this.message});
 
}
