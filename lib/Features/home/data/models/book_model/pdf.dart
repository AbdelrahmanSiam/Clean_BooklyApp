
class Pdf {
  final bool? isAvailable;

  const Pdf({this.isAvailable});

  factory Pdf.fromBookJson(Map<String, dynamic> json) => Pdf(
        isAvailable: json['isAvailable'] as bool?,
      );

  Map<String, dynamic> toBookJson() => {
        'isAvailable': isAvailable,
      };

  @override
  List<Object?> get props => [isAvailable];
}
