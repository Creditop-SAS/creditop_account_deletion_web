/// Strings para la página de información de datos.
class DataInfoStrings {
  const DataInfoStrings({
    required this.title,
    required this.deletedDataTitle,
    required this.deletedDataItems,
    required this.retainedDataTitle,
    required this.retainedDataItems,
    required this.retainedDataNote,
    required this.activeCreditNote,
    required this.continueButtonLabel,
    required this.cancelButtonLabel,
  });

  final String title;
  final String deletedDataTitle;
  final List<String> deletedDataItems;
  final String retainedDataTitle;
  final List<String> retainedDataItems;
  final String retainedDataNote;
  final String activeCreditNote;
  final String continueButtonLabel;
  final String cancelButtonLabel;
}
