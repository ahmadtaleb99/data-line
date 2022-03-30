import 'package:form_builder_test/FormService/FormApi.dart';
import 'package:form_builder_test/dynamic%20form/IFormModel.dart';
import 'package:hive/hive.dart';

class LocalStorageApi  extends FormApi{

  late   Box<IFormModel> _formBox;
  Future<void> init() async {
    Hive.registerAdapter(IFormModelAdapter());
    _formBox = await Hive.openBox<IFormModel>('form');
  }


  @override
  Future<List<IFormModel>> getFormElements() {
    throw UnimplementedError();
    // _formBox.values.where((element) => false);
  }

  @override
  void saveFormElements() {
  }



}