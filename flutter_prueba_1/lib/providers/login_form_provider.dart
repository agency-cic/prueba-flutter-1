import 'package:flutter/material.dart';


class FormProvider extends ChangeNotifier{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email ='';
  String cellphone ='';

  bool isValidForm(){

    return formKey.currentState?.validate() ?? false;
  }

}