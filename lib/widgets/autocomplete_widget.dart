import 'package:flutter/material.dart';

/// Data dusun beserta hierarki alamat
final List<Map<String, String>> dusunData = [
  {
    "dusun": "Dusun Selorejo 1",
    "desa": "Selorejo",
    "kecamatan": "Selorejo",
    "kabupaten": "Malang",
    "kode_pos": "65167",
    "provinsi": "Jawa Timur",
  },
  {
    "dusun": "Dusun Kalipare 2",
    "desa": "Kalipare",
    "kecamatan": "Kalipare",
    "kabupaten": "Malang",
    "kode_pos": "65166",
    "provinsi": "Jawa Timur",
  },
  {
    "dusun": "Dusun Sumberpucung",
    "desa": "Sumberpucung",
    "kecamatan": "Sumberpucung",
    "kabupaten": "Malang",
    "kode_pos": "65165",
    "provinsi": "Jawa Timur",
  },
  {
    "dusun": "Dusun Kromengan",
    "desa": "Kromengan",
    "kecamatan": "Kromengan",
    "kabupaten": "Malang",
    "kode_pos": "65168",
    "provinsi": "Jawa Timur",
  },
];

/// Widget AutoComplete Dusun
class DusunAutocomplete extends StatelessWidget {
  final TextEditingController dusunController;
  final TextEditingController desaController;
  final TextEditingController kecamatanController;
  final TextEditingController kabupatenController;
  final TextEditingController kodePosController;
  final TextEditingController provinsiController;

  const DusunAutocomplete({
    super.key,
    required this.dusunController,
    required this.desaController,
    required this.kecamatanController,
    required this.kabupatenController,
    required this.kodePosController,
    required this.provinsiController,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<Map<String, String>>(
      displayStringForOption: (option) => option["dusun"]!,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<Map<String, String>>.empty();
        }
        return dusunData.where((option) => option["dusun"]!
            .toLowerCase()
            .contains(textEditingValue.text.toLowerCase()));
      },
      onSelected: (Map<String, String> selection) {
        dusunController.text = selection["dusun"]!;
        desaController.text = selection["desa"]!;
        kecamatanController.text = selection["kecamatan"]!;
        kabupatenController.text = selection["kabupaten"]!;
        kodePosController.text = selection["kode_pos"]!;
        provinsiController.text = selection["provinsi"]!;
      },
      fieldViewBuilder:
          (context, controller, focusNode, onEditingComplete) {
        return TextFormField(
          controller: dusunController,
          focusNode: focusNode,
          decoration: const InputDecoration(labelText: "Dusun"),
        );
      },
    );
  }
}