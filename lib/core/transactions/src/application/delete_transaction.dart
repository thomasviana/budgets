import 'package:injectable/injectable.dart';

import '../../domain.dart';

@injectable
class DeleteTransaction {
  final TransactionRepository _transactionRepository;

  const DeleteTransaction(this._transactionRepository);

  Future<void> call(TransactionId transactionId) {
    return _transactionRepository.delete(transactionId);
  }
}
