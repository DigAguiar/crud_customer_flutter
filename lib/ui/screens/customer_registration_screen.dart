import 'package:brasil_fields/brasil_fields.dart';
import 'package:customer_registration/core/utils/custom_cep_formatter.dart';
import 'package:customer_registration/data/repositories/cep_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/customer_model.dart';
import '../../logic/controllers/customer_controller.dart';
import '../../core/utils/customer_validator.dart';
import '../widgets/customer_form_field.dart';

class CustomerRegistrationScreen extends ConsumerStatefulWidget {
  final CustomerModel? customer;
  const CustomerRegistrationScreen({super.key, this.customer});

  @override
  ConsumerState<CustomerRegistrationScreen> createState() =>
      _CustomerRegistrationScreenState();
}

class _CustomerRegistrationScreenState
    extends ConsumerState<CustomerRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _cepErrorMessage;
  final FocusNode _cepFocusNode = FocusNode();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cepController = TextEditingController();
  final _streetController = TextEditingController();
  final _numberController = TextEditingController();
  final _complementController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cepController.dispose();
    _streetController.dispose();
    _numberController.dispose();
    _complementController.dispose();
    _neighborhoodController.dispose();
    _cityController.dispose();
    _stateController.dispose();

    _cepFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.customer != null) {
      _nameController.text = widget.customer!.name;
      _emailController.text = widget.customer!.email;
      _phoneController.text = widget.customer!.phone ?? '';
      _cepController.text = widget.customer!.cep ?? '';
      _streetController.text = widget.customer!.street ?? '';
      _numberController.text = widget.customer!.number ?? '';
      _complementController.text = widget.customer!.complement ?? '';
      _neighborhoodController.text = widget.customer!.neighborhood ?? '';
      _cityController.text = widget.customer!.city ?? '';
      _stateController.text = widget.customer!.state ?? '';
    }

    _cepFocusNode.addListener(() {
      if(!_cepFocusNode.hasFocus){
        _formKey.currentState?.validate();
      }
    });

  }

  void _saveCustomer() {
    if (_formKey.currentState!.validate()) {
      final customerData = CustomerModel(
        id: widget.customer?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        cep: _cepController.text,
        street: _streetController.text,
        number: _numberController.text,
        complement: _complementController.text,
        neighborhood: _neighborhoodController.text,
        city: _cityController.text,
        state: _stateController.text,
      );

      if (widget.customer == null) {
        ref.read(customerControllerProvider.notifier).addCustomer(customerData);
      } else {
        ref
            .read(customerControllerProvider.notifier)
            .updateCustomer(customerData);
      }

      Navigator.pop(context);
    }
  }

  Future<void> _searchCep(String value) async {
    if (_cepErrorMessage != null) {
      setState(() => _cepErrorMessage = null);
    }

    if (value.length == 9) {
      try {
        final address = await CepRepository().getAddressByCep(value);

        if (address != null) {
          setState(() {
            _stateController.text = address['uf'] ?? '';
            _cityController.text = address['localidade'] ?? '';
            _neighborhoodController.text = address['bairro'] ?? '';
            _streetController.text = address['logradouro'] ?? '';
            _cepErrorMessage = null;
          });
        }
      } catch (e) {
        setState(() {
          _cepErrorMessage = e.toString().replaceAll('Exception: ', '');

          _stateController.clear();
          _cityController.clear();
          _neighborhoodController.clear();
          _streetController.clear();
        });
      }

      
      _formKey.currentState?.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.customer != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Editar Cliente" : "Novo Cliente"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomerFormField(
                label: "Nome Completo",
                controller: _nameController,
                validator: CustomerValidator.validateName,
                keyboardType: TextInputType.name,
                icon: Icons.person,
                readOnly: false,
              ),
              CustomerFormField(
                label: "E-mail",
                controller: _emailController,
                validator: CustomerValidator.validateEmail,
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email,
                readOnly: false,
              ),
              CustomerFormField(
                label: "Telefone",
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                icon: Icons.phone,
                readOnly: false,
                maxLength: 15,
                inputFormatters: [
                  TelefoneInputFormatter()
                ],
              ),
              const Divider(height: 32),
              const Text("Endereço",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              CustomerFormField(
                label: "CEP",
                controller: _cepController,
                focusNode: _cepFocusNode,
                keyboardType: TextInputType.number,
                icon: Icons.map,
                readOnly: false,
                maxLength: 9,
                inputFormatters: [CustomCepFormatter()],
                onChanged: _searchCep,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Campo obrigatório";

                  if (value.length < 9) return "CEP Incompleto";

                  return _cepErrorMessage;
                },
              ),
              CustomerFormField(
                label: "Rua",
                controller: _streetController,
                keyboardType: TextInputType.streetAddress,
                readOnly: false,
              ),
              CustomerFormField(
                label: "Número",
                controller: _numberController,
                keyboardType: TextInputType.number,
                readOnly: false,
              ),
              CustomerFormField(
                label: "Complemento",
                controller: _complementController,
                keyboardType: TextInputType.text,
                readOnly: false,
              ),
              CustomerFormField(
                label: "Bairro",
                controller: _neighborhoodController,
                keyboardType: TextInputType.text,
                readOnly: false,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomerFormField(
                      label: "Cidade",
                      controller: _cityController,
                      keyboardType: TextInputType.text,
                      readOnly: false,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CustomerFormField(
                      label: "UF",
                      controller: _stateController,
                      keyboardType: TextInputType.text,
                      readOnly: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveCustomer,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(55),
                  backgroundColor: const Color(0xFF070E91),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
                child: Text(isEditing ? "Atualizar Dados" : "Salvar Cliente",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
