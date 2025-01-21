import 'package:flutter/cupertino.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/usecase/dto/link-mail-server.request.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/usecase/link-mail-server.usecase.dart';
import 'package:newsfunnel_frontend/service_locator.dart';

class AddServerSheetWidget extends StatefulWidget {
  const AddServerSheetWidget({super.key});

  void show(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('Add Mail Server'),
          message: const Text('Configure a new mail server'),
          actions: [
            _AddServerForm(
              nameController: _AddServerSheetWidgetState._nameController,
              userController: _AddServerSheetWidgetState._userController,
              passwordController: _AddServerSheetWidgetState._passwordController,
              hostController: _AddServerSheetWidgetState._hostController,
              portController: _AddServerSheetWidgetState._portController,
              tls: _AddServerSheetWidgetState._tls,
              onTlsChanged: (value) => _AddServerSheetWidgetState._tls = value,
            )
          ],
        );
      },
    );
  }

  @override
  State<AddServerSheetWidget> createState() => _AddServerSheetWidgetState();
}

class _AddServerSheetWidgetState extends State<AddServerSheetWidget> {
  static final _nameController = TextEditingController();
  static final _userController = TextEditingController();
  static final _passwordController = TextEditingController();
  static final _hostController = TextEditingController();
  static final _portController = TextEditingController();
  static bool _tls = true;

  @override
  void dispose() {
    _nameController.dispose();
    _userController.dispose();
    _passwordController.dispose();
    _hostController.dispose();
    _portController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class _AddServerForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController userController;
  final TextEditingController passwordController;
  final TextEditingController hostController;
  final TextEditingController portController;
  final bool tls;
  final ValueChanged<bool> onTlsChanged;

  const _AddServerForm({
    required this.nameController,
    required this.userController,
    required this.passwordController,
    required this.hostController,
    required this.portController,
    required this.tls,
    required this.onTlsChanged,
  });

  @override
  State<_AddServerForm> createState() => _AddServerFormState();
}

class _AddServerFormState extends State<_AddServerForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoTextField(
            controller: widget.nameController,
            placeholder: 'Server Name',
            padding: const EdgeInsets.all(12),
          ),
          const SizedBox(height: 8),
          CupertinoTextField(
            controller: widget.userController,
            placeholder: 'Username',
            padding: const EdgeInsets.all(12),
          ),
          const SizedBox(height: 8),
          CupertinoTextField(
            controller: widget.passwordController,
            placeholder: 'Password',
            padding: const EdgeInsets.all(12),
            obscureText: true,
          ),
          const SizedBox(height: 8),
          CupertinoTextField(
            controller: widget.hostController,
            placeholder: 'Host',
            padding: const EdgeInsets.all(12),
          ),
          const SizedBox(height: 8),
          CupertinoTextField(
            controller: widget.portController,
            placeholder: 'Port',
            padding: const EdgeInsets.all(12),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Use TLS'),
              CupertinoSwitch(
                value: widget.tls,
                onChanged: widget.onTlsChanged,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CupertinoButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              CupertinoButton.filled(
                onPressed: () async {
                  final request = LinkMailServerRequest(
                    name: widget.nameController.text,
                    user: widget.userController.text,
                    password: widget.passwordController.text,
                    host: widget.hostController.text,
                    port: int.parse(widget.portController.text),
                    tls: widget.tls,
                  );

                  await serviceLocator<LinkMailServerUsecase>().execute(request: request);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
