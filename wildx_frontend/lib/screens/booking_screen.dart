import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../models/accommodation.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _checkIn;
  DateTime? _checkOut;
  int _adults = 1;
  int _children = 0;

  int get _totalGuests => _adults + _children;

  int get _nights {
    if (_checkIn == null || _checkOut == null) return 0;
    return _checkOut!.difference(_checkIn!).inDays;
  }

  double _totalPrice(double pricePerNight) => pricePerNight * _nights;

  /// Opens a date-range picker so the user selects both check-in and
  /// check-out in a single interaction.
  Future<void> _pickDateRange() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastDate = today.add(const Duration(days: 365));

    final range = await showDateRangePicker(
      context: context,
      firstDate: today,
      lastDate: lastDate,
      initialDateRange: (_checkIn != null && _checkOut != null)
          ? DateTimeRange(start: _checkIn!, end: _checkOut!)
          : null,
      currentDate: today,
      saveText: 'CONFIRM',
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: kGreen,
            onPrimary: Colors.white,
            secondary: kGreenLight,
            onSecondary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black87,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: kGreen),
          ),
        ),
        child: child!,
      ),
    );

    if (range == null) return;
    setState(() {
      _checkIn = range.start;
      _checkOut = range.end;
    });
  }

  /// Opens a single-date picker for adjusting only check-in or check-out.
  Future<void> _pickSingleDate({required bool isCheckIn}) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastDate = today.add(const Duration(days: 365));

    final DateTime firstAllowed;
    final DateTime initial;

    if (isCheckIn) {
      firstAllowed = today;
      initial = _checkIn ?? today;
    } else {
      firstAllowed = (_checkIn ?? today).add(const Duration(days: 1));
      initial = _checkOut ?? firstAllowed;
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: initial.isBefore(firstAllowed) ? firstAllowed : initial,
      firstDate: firstAllowed,
      lastDate: lastDate,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: kGreen,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black87,
          ),
        ),
        child: child!,
      ),
    );

    if (picked == null) return;
    setState(() {
      if (isCheckIn) {
        _checkIn = picked;
        if (_checkOut != null && !_checkOut!.isAfter(picked)) {
          _checkOut = null;
        }
      } else {
        _checkOut = picked;
      }
    });
  }

  void _clearDates() => setState(() {
        _checkIn = null;
        _checkOut = null;
      });

  @override
  Widget build(BuildContext context) {
    final accommodation =
        ModalRoute.of(context)!.settings.arguments as Accommodation;

    return Scaffold(
      backgroundColor: kGreenSoft,
      appBar: AppBar(
        backgroundColor: kGreen,
        foregroundColor: Colors.white,
        title: const Text(
          'Book Accommodation',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _AccommodationHeader(accommodation: accommodation),
                  const SizedBox(height: 20),
                  _SectionCard(
                    title: 'Select Dates',
                    icon: Icons.date_range_outlined,
                    trailing: _checkIn != null || _checkOut != null
                        ? GestureDetector(
                            onTap: _clearDates,
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.clear_rounded,
                                    size: 14, color: Colors.grey),
                                SizedBox(width: 2),
                                Text('Clear',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                          )
                        : null,
                    child: Column(
                      children: [
                        // Tap either field to adjust individually
                        _DateField(
                          label: 'Check-in',
                          icon: Icons.login_rounded,
                          date: _checkIn,
                          hint: 'Select check-in date',
                          onTap: () => _pickSingleDate(isCheckIn: true),
                        ),
                        // Nights indicator
                        if (_nights > 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                const Expanded(child: Divider(color: kGreenSoft)),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: kGreenSoft,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '$_nights ${_nights == 1 ? 'night' : 'nights'}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: kGreen,
                                    ),
                                  ),
                                ),
                                const Expanded(child: Divider(color: kGreenSoft)),
                              ],
                            ),
                          )
                        else
                          const SizedBox(height: 12),
                        _DateField(
                          label: 'Check-out',
                          icon: Icons.logout_rounded,
                          date: _checkOut,
                          hint: _checkIn == null
                              ? 'Pick check-in first'
                              : 'Select check-out date',
                          enabled: _checkIn != null,
                          onTap: _checkIn != null
                              ? () => _pickSingleDate(isCheckIn: false)
                              : () {},
                        ),
                        const SizedBox(height: 12),
                        // Full range picker shortcut
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: kGreen,
                              side: const BorderSide(color: kGreenLight),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: _pickDateRange,
                            icon: const Icon(
                                Icons.calendar_month_outlined, size: 18),
                            label: Text(
                              _checkIn != null && _checkOut != null
                                  ? 'Change date range'
                                  : 'Pick date range',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _SectionCard(
                    title: 'Guests',
                    icon: Icons.people_outline_rounded,
                    trailing: _totalGuests > 0
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: kGreenSoft,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '$_totalGuests total',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: kGreen,
                              ),
                            ),
                          )
                        : null,
                    child: _GuestSelector(
                      adults: _adults,
                      children: _children,
                      onAdultsChanged: (v) => setState(() => _adults = v),
                      onChildrenChanged: (v) => setState(() => _children = v),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _PriceSummary(
                    pricePerNight: accommodation.pricePerNight,
                    nights: _nights,
                    adults: _adults,
                    children: _children,
                    total: _totalPrice(accommodation.pricePerNight),
                  ),
                ],
              ),
            ),
          ),
          _BookingFooter(
            isEnabled: _nights > 0,
            total: _totalPrice(accommodation.pricePerNight),
            onConfirm: () {
              // TODO: Submit booking to backend
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Booking confirmed! (placeholder)'),
                  backgroundColor: kGreen,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ── Accommodation header card ───────────────────────────────────────────────

class _AccommodationHeader extends StatelessWidget {
  final Accommodation accommodation;

  const _AccommodationHeader({required this.accommodation});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: kGreen.withValues(alpha: 0.10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              accommodation.imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, _) => Container(
                height: 160,
                color: kGreenSoft,
                child: const Icon(Icons.image_not_supported,
                    size: 48, color: kGreen),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  accommodation.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 14, color: kGreenLight),
                    const SizedBox(width: 4),
                    Text(
                      accommodation.parkName,
                      style: const TextStyle(
                          fontSize: 13, color: Colors.grey),
                    ),
                    const Spacer(),
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 2),
                    Text(
                      '${accommodation.rating}',
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'LKR ${accommodation.pricePerNight.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kGreen,
                      ),
                    ),
                    const Text(
                      ' / night',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Generic section card ────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final Widget? trailing;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: kGreen.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: kGreen),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (trailing != null) ...[
                const Spacer(),
                trailing!,
              ],
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

// ── Date selection field ────────────────────────────────────────────────────

class _DateField extends StatelessWidget {
  final String label;
  final IconData icon;
  final DateTime? date;
  final String hint;
  final bool enabled;
  final VoidCallback onTap;

  const _DateField({
    required this.label,
    required this.icon,
    required this.date,
    required this.onTap,
    this.hint = 'Select date',
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final hasDate = date != null;
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: enabled ? kGreenSoft : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: hasDate
                ? kGreen
                : enabled
                    ? kGreenLight.withValues(alpha: 0.4)
                    : Colors.grey.shade300,
            width: hasDate ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon,
                size: 18,
                color: enabled ? kGreen : Colors.grey.shade400),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: enabled ? Colors.grey : Colors.grey.shade400,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  hasDate ? _formatDate(date!) : hint,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: hasDate
                        ? Colors.black87
                        : enabled
                            ? Colors.grey
                            : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.calendar_today_rounded,
              size: 16,
              color: enabled
                  ? kGreen.withValues(alpha: 0.6)
                  : Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }

  static String _formatDate(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return '${weekdays[d.weekday - 1]}, ${d.day} ${months[d.month - 1]} ${d.year}';
  }
}

// ── Guest selector (adults + children) ──────────────────────────────────────

class _GuestSelector extends StatelessWidget {
  final int adults;
  final int children;
  final ValueChanged<int> onAdultsChanged;
  final ValueChanged<int> onChildrenChanged;

  static const int _maxGuests = 20;

  const _GuestSelector({
    required this.adults,
    required this.children,
    required this.onAdultsChanged,
    required this.onChildrenChanged,
  });

  int get _total => adults + children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _GuestRow(
          icon: Icons.person_outline_rounded,
          label: 'Adults',
          subtitle: 'Age 13+',
          value: adults,
          onDecrement: adults > 1 ? () => onAdultsChanged(adults - 1) : null,
          onIncrement:
              _total < _maxGuests ? () => onAdultsChanged(adults + 1) : null,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(height: 1, color: kGreenSoft),
        ),
        _GuestRow(
          icon: Icons.child_care_rounded,
          label: 'Children',
          subtitle: 'Age 0 – 12',
          value: children,
          onDecrement:
              children > 0 ? () => onChildrenChanged(children - 1) : null,
          onIncrement: _total < _maxGuests
              ? () => onChildrenChanged(children + 1)
              : null,
        ),
        if (_total >= _maxGuests)
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Icon(Icons.info_outline_rounded, size: 14, color: Colors.grey),
                SizedBox(width: 6),
                Text(
                  'Maximum of 20 guests reached',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _GuestRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final int value;
  final VoidCallback? onDecrement;
  final VoidCallback? onIncrement;

  const _GuestRow({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: kGreen),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
        const Spacer(),
        _CounterButton(
          icon: Icons.remove,
          onTap: onDecrement,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: SizedBox(
            width: 24,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kGreen,
              ),
            ),
          ),
        ),
        _CounterButton(
          icon: Icons.add,
          onTap: onIncrement,
        ),
      ],
    );
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _CounterButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: enabled ? kGreen : kGreenSoft,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 18,
          color: enabled ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}

// ── Price summary card ──────────────────────────────────────────────────────

class _PriceSummary extends StatelessWidget {
  final double pricePerNight;
  final int nights;
  final int adults;
  final int children;
  final double total;

  const _PriceSummary({
    required this.pricePerNight,
    required this.nights,
    required this.adults,
    required this.children,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: kGreen.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.receipt_long_outlined, size: 18, color: kGreen),
              SizedBox(width: 8),
              Text(
                'Price Summary',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _PriceRow(
            label:
                'LKR ${pricePerNight.toStringAsFixed(0)} × $nights ${nights == 1 ? 'night' : 'nights'}',
            value: nights > 0
                ? 'LKR ${(pricePerNight * nights).toStringAsFixed(0)}'
                : '—',
          ),
          const SizedBox(height: 8),
          _PriceRow(
            label: '$adults ${adults == 1 ? 'adult' : 'adults'}'
                '${children > 0 ? ', $children ${children == 1 ? 'child' : 'children'}' : ''}',
            value: '',
            isSubtle: true,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, color: kGreenSoft),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                nights > 0 ? 'LKR ${total.toStringAsFixed(0)}' : '—',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kGreen,
                ),
              ),
            ],
          ),
          if (nights == 0) ...[
            const SizedBox(height: 8),
            const Text(
              'Select check-in and check-out dates to see the total price.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isSubtle;

  const _PriceRow({
    required this.label,
    required this.value,
    this.isSubtle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: isSubtle ? Colors.grey : Colors.black87,
          ),
        ),
        if (value.isNotEmpty)
          Text(
            value,
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
      ],
    );
  }
}

// ── Sticky booking footer ───────────────────────────────────────────────────

class _BookingFooter extends StatelessWidget {
  final bool isEnabled;
  final double total;
  final VoidCallback onConfirm;

  const _BookingFooter({
    required this.isEnabled,
    required this.total,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEnabled
                        ? 'LKR ${total.toStringAsFixed(0)}'
                        : 'Select dates',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isEnabled ? kGreen : Colors.grey,
                    ),
                  ),
                  const Text(
                    'total',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isEnabled ? kGreen : Colors.grey,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: isEnabled ? 2 : 0,
                  ),
                  onPressed: isEnabled ? onConfirm : null,
                  child: const Text(
                    'Confirm Booking',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
