// добавить расширения сюда для стрим контрлера, типа startLoading() и тп

import 'package:flutter_app_bloc_again/utils/lgi.dart';

abstract class BaseBloc {
  void dispose() {
    Lgi.p('on dispose bloc $this');
  }
}
