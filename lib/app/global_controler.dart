import 'package:get/get.dart';

class GlobalController extends GetxController {

final GlobalController repository; GlobalController(this.repository);

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}