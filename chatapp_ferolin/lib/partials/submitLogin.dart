import 'errorAlert.dart';

submitLogin(context, _formKey){
  if (_formKey.currentState.validate()) {
    _formKey.currentState.save();
    //Navigate to Home Page
  }else{
    String error = "missing";
    showErrorMessage(context, error);
  }
}
