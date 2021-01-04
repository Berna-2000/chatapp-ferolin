import 'errorAlert.dart';
import 'successAlert.dart';

submitChangePassword(context, _formKey){
  if (_formKey.currentState.validate()) {
    _formKey.currentState.save();
    String success = "changed";
    showSuccessMessage(context, success);
  }else{
    String error = "missing";
    showErrorMessage(context, error);
  }
}