enum BudgetType { total, perDay }

extension BudgetTypeExtension on BudgetType {
  String get label {
    switch (this) {
      case BudgetType.total:
        return 'Total';
      case BudgetType.perDay:
        return 'Per Day';
    }
  }
}