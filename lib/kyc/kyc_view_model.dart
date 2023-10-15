import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';

import '../store/application_state.dart';
import '../store/auth/auth_action.dart';

class KYCViewModel {
  final Store<ApplicationState> _store;

  KYCViewModel(this._store);

  static KYCViewModel converter(Store<ApplicationState> store) {
    return KYCViewModel(store);
  }

  void uploadKYCImage(XFile image){
    _store.dispatch(AuthUploadingKYCImageAction(image));
  }

}
