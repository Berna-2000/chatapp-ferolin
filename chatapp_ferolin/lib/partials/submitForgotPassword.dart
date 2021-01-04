import 'errorAlert.dart';
import 'successAlert.dart';

submitForgotPassowrd(context, _formKey){
  if (_formKey.currentState.validate()) {
    _formKey.currentState.save();
    String success = "reset";
    showSuccessMessage(context, success);
  }else{
    String error = "missing";
    showErrorMessage(context, error);
  }
}