import 'package:flutter/material.dart';
import 'package:form_builder_test/DrawDropDownButton.dart';

var htmlFormToFlutter =  {
  'select' :  drawer
};

Widget drawbtn({ required String label,
  required bool deactivated,
  required bool reqired,
  required bool isHidden,
  required bool isReadOnly,
  required String prompt}){
  return DrawDropDownButton(label: label, deactivated: deactivated, reqired: reqired, isHidden: isHidden, isReadOnly: isReadOnly, prompt: prompt);
}

String rawJson =   r'[{"type":"select","label":"countries","deactivate":false,"required":false,"isHidden":false,"isReadOnly":false,"className":"form-control","name":"select-1646638397919","prompt":"Select a value","relatedListCheckbox":false,"multiple":false,"scoring":false,"other":false,"showIfLogicCheckbox":false,"showIfIsRequired":false,"requiredIfLogicCheckbox":false,"values":[{"label":"syr","value":"syr","parent":"","status":"Active","score":"0","selected":true},{"label":"joran","value":"joran","parent":"","status":"Active","score":"0"}]},{"type":"select","label":"cities","deactivate":false,"required":false,"isHidden":false,"isReadOnly":false,"className":"form-control","name":"select-1646638398638","prompt":"Select a value","relatedListCheckbox":true,"relatedListFieldName":"frmb-1646638394223-fld-1","multiple":false,"scoring":false,"other":false,"showIfLogicCheckbox":false,"showIfIsRequired":false,"requiredIfLogicCheckbox":false,"values":[{"label":"dama","value":"dama","parent":"syr","status":"Active","score":"0","selected":true},{"label":"erbid","value":"erbid","parent":"joran","status":"Active","score":"0"}]},{"type":"lookup","label":"xyz","deactivate":false,"required":false,"name":"lookup-1646638984056","form":"61dfe9bf6a6d0000fa003c97","referrence":"id_1642064300659","helper":"text_1642064312106","showIfLogicCheckbox":true,"showIfFieldName":"frmb-1646638394223-fld-1","showIfFieldValue":"syr","showIfIsRequired":false,"requiredIfLogicCheckbox":false}]';



class drawer {
  List<dynamic> parameters;
  Function drawFunction;

  drawer({required this.parameters, required this.drawFunction});


}