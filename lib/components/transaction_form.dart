import 'package:expenses/components/adaptative_button.dart';
import 'package:expenses/components/adaptative_datepicker.dart';
import 'package:expenses/components/adaptative_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          // padding: const EdgeInsets.all(10),
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: <Widget>[
              AdaptativeTextField(
                _titleController,
                TextInputType.text,
                (_) => _submitForm(),
                'Título',
              ),
              AdaptativeTextField(
                _valueController,
                const TextInputType.numberWithOptions(decimal: true),
                (_) => _submitForm(),
                'Valor (R\$)',
              ),
              // TextField(
              //   controller: _titleController,
              //   onSubmitted: (_) => _submitForm(),
              //   decoration: const InputDecoration(
              //     labelText: 'Título',
              //   ),
              // ),
              // TextField(
              //   controller: _valueController,
              //   // Somente TextInputType.number() não irá funcionar para IOS, somente no Android
              //   // Para que funcione nos 2 sistemas deve usar TextInputType.numberWithOptions(decimal: true)
              //   keyboardType:
              //       const TextInputType.numberWithOptions(decimal: true),
              //   onSubmitted: (_) => _submitForm(),
              //   decoration: const InputDecoration(
              //     labelText: 'Valor (R\$)',
              //   ),
              // ),
              // SizedBox(
              //   height: 70,
              //   child: Row(
              //     children: <Widget>[
              //       Expanded(
              //         child: Text(
              //           _selectedDate == null
              //               ? 'Nenhuma data selecionada!'
              //               : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}',
              //         ),
              //       ),
              //       TextButton(
              //         style: ButtonStyle(
              //           foregroundColor: MaterialStateProperty.all<Color>(
              //               Theme.of(context).colorScheme.primary),
              //         ),
              //         onPressed: _showDatePicker,
              //         child: const Text(
              //           'Selecionar Data',
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton(
                    'Nova Transação',
                    _submitForm,
                  ),
                  // ElevatedButton(
                  //   style: ButtonStyle(
                  //     backgroundColor: MaterialStateProperty.all<Color>(
                  //         Theme.of(context).colorScheme.primary),
                  //     foregroundColor:
                  //         MaterialStateProperty.all<Color>(Colors.white),
                  //   ),
                  //   onPressed: _submitForm,
                  //   child: const Text('Nova Transação'),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
