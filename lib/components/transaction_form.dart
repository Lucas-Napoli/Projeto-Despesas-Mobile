import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionsForm(this.onSubmit, {super.key});

  @override
  State<TransactionsForm> createState() => _TransactionsFormState();
}

class _TransactionsFormState extends State<TransactionsForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    // ignore: unnecessary_null_comparison
    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        // ignore: prefer_const_constructors
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            // ignore: prefer_const_constructors
            TextField(
              // ignore: prefer_const_constructors
              controller: _titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Titulo',
              ),
            ),
            // ignore: prefer_const_constructors
            TextField(
              // ignore: prefer_const_constructors
              controller: _valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      // ignore: unnecessary_null_comparison
                      _selectedDate == null
                          ? 'Nenhuma data selecionada!'
                          : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.purple,
                    ),
                    onPressed: _showDatePicker,
                    child: const Text('Selecionar Data'),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.purple),
                    child: const Text('Nova Transação')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
