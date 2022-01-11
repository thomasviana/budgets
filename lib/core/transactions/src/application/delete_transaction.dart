import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class DeleteTx {
  final TxRepository _txRepository;

  const DeleteTx(this._txRepository);

  Future<void> call(TxId txId) {
    return _txRepository.delete(txId);
  }
}
