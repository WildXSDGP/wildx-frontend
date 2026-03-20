import 'package:flutter/material.dart';
import '../models/ranger_model.dart';
import '../theme/safari_theme.dart';

class EditRangerScreen extends StatefulWidget {
  final RangerModel ranger;
  final ValueChanged<RangerModel>? onSave;

  const EditRangerScreen({super.key, required this.ranger, this.onSave});

  @override
  State<EditRangerScreen> createState() => _EditRangerScreenState();
}

class _EditRangerScreenState extends State<EditRangerScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _locationCtrl;
  late final TextEditingController _bioCtrl;

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final parts = widget.ranger.name.split(' ');
    _firstNameCtrl = TextEditingController(
        text: parts.isNotEmpty ? parts.first : '');
    _lastNameCtrl  = TextEditingController(
        text: parts.length > 1 ? parts.sublist(1).join(' ') : '');
    _emailCtrl    = TextEditingController(text: widget.ranger.email ?? '');
    _locationCtrl = TextEditingController(text: widget.ranger.location ?? '');
    _bioCtrl      = TextEditingController(text: widget.ranger.bio ?? '');
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _locationCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);

    await Future.delayed(const Duration(milliseconds: 600));

    final updated = widget.ranger.copyWith(
      name: '${_firstNameCtrl.text.trim()} ${_lastNameCtrl.text.trim()}'.trim(),
      email: _emailCtrl.text.trim(),
      location: _locationCtrl.text.trim(),
      bio: _bioCtrl.text.trim(),
    );

    widget.onSave?.call(updated);
    if (mounted) Navigator.pop(context, updated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SafariTheme.background,
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _EditHeader(ranger: widget.ranger)),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const _FieldLabel(label: 'Your Name'),
                  const SizedBox(height: 8),
                  _TrailField(
                    controller: _firstNameCtrl,
                    hint: 'First name',
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),

                  const _FieldLabel(label: 'Last Name'),
                  const SizedBox(height: 8),
                  _TrailField(
                    controller: _lastNameCtrl,
                    hint: 'Last name',
                  ),
                  const SizedBox(height: 20),

                  const _FieldLabel(label: 'Your Email'),
                  const SizedBox(height: 8),
                  _TrailField(
                    controller: _emailCtrl,
                    hint: 'your@email.com',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.mail_outline_rounded,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return null;
                      if (!v.contains('@')) return 'Enter a valid email';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  const _FieldLabel(label: 'Location'),
                  const SizedBox(height: 8),
                  _TrailField(
                    controller: _locationCtrl,
                    hint: 'City, Country',
                    prefixIcon: Icons.location_on_outlined,
                  ),
                  const SizedBox(height: 20),

                  const _FieldLabel(label: 'Bio'),
                  const SizedBox(height: 8),
                  _TrailField(
                    controller: _bioCtrl,
                    hint: 'Tell us about yourself…',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: _saving ? null : _save,
                      style: FilledButton.styleFrom(
                        backgroundColor: SafariTheme.forestGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      child: _saving
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Save Changes'),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EditHeader extends StatelessWidget {
  final RangerModel ranger;
  const _EditHeader({required this.ranger});

  @override
  Widget build(BuildContext context) {
    final initials = ranger.name
        .split(' ')
        .take(2)
        .map((w) => w.isNotEmpty ? w[0] : '')
        .join()
        .toUpperCase();

    return Container(
      decoration: const BoxDecoration(
        gradient: SafariTheme.headerGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.maybePop(context),
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: const BoxDecoration(
                      color: Color(0x2EFFFFFF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.white, size: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 16,
                          offset: Offset(0, 6),
                        ),
                      ],
                      image: ranger.avatarUrl != null
                          ? DecorationImage(
                              image: NetworkImage(ranger.avatarUrl!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: ranger.avatarUrl == null
                        ? Center(
                            child: Text(
                              initials,
                              style: const TextStyle(
                                color: SafariTheme.forestGreen,
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: SafariTheme.amber,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.camera_alt_rounded,
                          color: Colors.white, size: 15),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                ranger.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (ranger.location != null && ranger.location!.isNotEmpty) ...[
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on_rounded,
                        color: Color(0xCCFFFFFF), size: 14),
                    const SizedBox(width: 4),
                    Text(
                      ranger.location!,
                      style: const TextStyle(
                        color: Color(0xCCFFFFFF),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _TrailField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final int maxLines;
  final String? Function(String?)? validator;

  const _TrailField({
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.prefixIcon,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: SafariTheme.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: SafariTheme.textSecondary,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: SafariTheme.textSecondary, size: 20)
            : null,
        filled: true,
        fillColor: SafariTheme.surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: SafariTheme.cardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: SafariTheme.cardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: SafariTheme.forestGreen, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: SafariTheme.coral),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: SafariTheme.textSecondary,
        letterSpacing: 0.5,
      ),
    );
  }
}
