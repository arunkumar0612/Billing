// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  Subscription? _selectedSubscription;
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;
  List<bool> _selectedPackages = [];
  bool _selectAll = false;
  bool _showDeleteConfirmation = false;

  @override
  void initState() {
    super.initState();
    _selectedSubscription = SubscriptionRepository.getSubscriptions().first;
    _selectedPackages = List.filled(SubscriptionRepository.getSubscriptions().length, false);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _deleteSelectedPackages() {
    setState(() {
      _showDeleteConfirmation = true;
    });
  }

  void _confirmDelete() {
    setState(() {
      int count = _selectedPackages.where((element) => element).length;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$count package(s) modified'),
          backgroundColor: Colors.blue,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      _selectedPackages = List.filled(_selectedPackages.length, false);
      _selectAll = false;
      _showDeleteConfirmation = false;
    });
  }

  void _cancelDelete() {
    setState(() {
      _showDeleteConfirmation = false;
    });
  }

  void _toggleSelectAll(bool? value) {
    setState(() {
      _selectAll = value ?? false;
      _selectedPackages = List.filled(_selectedPackages.length, _selectAll);
    });
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    final subscriptions = SubscriptionRepository.getSubscriptions();
    final isWideScreen = MediaQuery.of(context).size.width > 800;
    final theme = Theme.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 15, 22, 46),
        body: Stack(
          children: [
            // Background gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 15, 22, 46),
                    Color.fromARGB(255, 31, 45, 95),
                    Color.fromARGB(255, 56, 66, 103),
                  ],
                ),
              ),
            ),
            // Color.fromARGB(255, 15, 22, 46),
            //       Color.fromARGB(255, 31, 45, 95),
            //       Color.fromARGB(255, 56, 66, 103),
            // Content
            SafeArea(
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Premium Plans',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Main content
                  Expanded(
                    child: isWideScreen ? _buildWideLayout(subscriptions, theme) : _buildMobileLayout(subscriptions, theme),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWideLayout(List<Subscription> subscriptions, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Subscription list (left panel)
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          child: _buildSubscriptionList(subscriptions, theme),
        ),

        // Vertical divider
        Container(
          width: 1,
          margin: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.white.withOpacity(0.2),
                Colors.transparent,
              ],
            ),
          ),
        ),

        // Details panel (right panel)
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: _selectedSubscription != null
                ? SubscriptionDetailsPanel(
                    subscription: _selectedSubscription!,
                    isSelected: _getIsSelected(_selectedSubscription!),
                    onSelectionChanged: (value) {
                      _updateSelection(_selectedSubscription!, value);
                    },
                  )
                : Center(
                    child: Text(
                      'Select a plan to view details',
                      style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white70),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(List<Subscription> subscriptions, ThemeData theme) {
    return Column(
      children: [
        // Select all checkbox
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      value: _selectAll,
                      onChanged: _toggleSelectAll,
                      activeColor: Colors.blueAccent,
                      fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.blueAccent; // Color when checked
                        }
                        return Colors.white; // Transparent when unchecked
                      }),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Select All Plans',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              if (_selectedPackages.contains(true))
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _showDeleteConfirmation
                      ? Row(
                          children: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: const BorderSide(color: Colors.white54),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: _cancelDelete,
                              child: const Text('Cancel'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: _confirmDelete,
                              child: const Text('Confirm Delete'),
                            ),
                          ],
                        )
                      : ElevatedButton.icon(
                          // icon: const Icon(Icons.delete_outline, size: 20),
                          label: const Text('Delete'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.withOpacity(0.9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: _deleteSelectedPackages,
                        ),
                ),
            ],
          ),
        ),

        // Subscription carousel
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: _buildSubscriptionCarousel(subscriptions),
        ),

        // Page indicator
        _buildPageIndicator(subscriptions.length),

        // Details panel
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _selectedSubscription != null
                ? SubscriptionDetailsPanel(
                    subscription: _selectedSubscription!,
                    isSelected: _getIsSelected(_selectedSubscription!),
                    onSelectionChanged: (value) {
                      _updateSelection(_selectedSubscription!, value);
                    },
                  )
                : Center(
                    child: Text(
                      'Select a plan to view details',
                      style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white70),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubscriptionCarousel(List<Subscription> subscriptions) {
    return PageView.builder(
      controller: _pageController,
      itemCount: subscriptions.length,
      onPageChanged: (index) {
        setState(() {
          _selectedSubscription = subscriptions[index];
        });
        HapticFeedback.selectionClick();
      },
      itemBuilder: (context, index) {
        final subscription = subscriptions[index];
        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            double value = 1.0;
            if (_pageController.position.haveDimensions) {
              value = _pageController.page! - index;
              value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
            }
            return Center(
              child: Transform.scale(
                scale: Curves.easeOut.transform(value),
                child: Opacity(
                  opacity: value.clamp(0.5, 1.0),
                  child: SubscriptionCard(
                    subscription: subscription,
                    isSelected: _currentPage == index,
                    isChecked: _selectedPackages[index],
                    onTap: () {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOutQuint,
                      );
                    },
                    onChecked: (value) {
                      setState(() {
                        _selectedPackages[index] = value;
                      });
                      HapticFeedback.lightImpact();
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPageIndicator(int length) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(length, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _currentPage == index ? 24 : 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: _currentPage == index ? Colors.white : Colors.white.withOpacity(0.4),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSubscriptionList(List<Subscription> subscriptions, ThemeData theme) {
    return Column(
      children: [
        // Select all checkbox
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Transform.scale(
                        scale: 1.2,
                        child: Checkbox(
                          value: _selectAll,
                          onChanged: _toggleSelectAll,
                          activeColor: Colors.blueAccent,
                          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors.blueAccent; // Color when checked
                            }
                            return Colors.white; // Transparent when unchecked
                          }),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        )),
                    const SizedBox(width: 12),
                    Text(
                      'Select All Plans',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                if (_selectedPackages.contains(true))
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _showDeleteConfirmation
                        ? Row(
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side: const BorderSide(color: Colors.white54),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: _cancelDelete,
                                child: const Text('Cancel'),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: _confirmDelete,
                                child: const Text('Confirm Delete'),
                              ),
                            ],
                          )
                        : ElevatedButton.icon(
                            // icon: const Icon(Icons.delete_outline, size: 20),
                            label: const Text('Delete'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.withOpacity(0.9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: _deleteSelectedPackages,
                          ),
                  ),
              ],
            ),
          ),
        ),

        // Subscription list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: subscriptions.length,
            itemBuilder: (context, index) {
              final subscription = subscriptions[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: SubscriptionCard(
                  subscription: subscription,
                  isSelected: _selectedSubscription?.id == subscription.id,
                  isChecked: _selectedPackages[index],
                  onTap: () {
                    setState(() {
                      _selectedSubscription = subscription;
                    });
                    HapticFeedback.selectionClick();
                  },
                  onChecked: (value) {
                    setState(() {
                      _selectedPackages[index] = value;
                    });
                    HapticFeedback.lightImpact();
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  bool _getIsSelected(Subscription subscription) {
    final index = SubscriptionRepository.getSubscriptions().indexWhere((sub) => sub.id == subscription.id);
    return index >= 0 && index < _selectedPackages.length ? _selectedPackages[index] : false;
  }

  void _updateSelection(Subscription subscription, bool value) {
    final index = SubscriptionRepository.getSubscriptions().indexWhere((sub) => sub.id == subscription.id);
    if (index >= 0 && index < _selectedPackages.length) {
      setState(() {
        _selectedPackages[index] = value;
      });
    }
  }
}

class SubscriptionCard extends StatelessWidget {
  final Subscription subscription;
  final bool isSelected;
  final bool isChecked;
  final VoidCallback onTap;
  final ValueChanged<bool>? onChecked;

  const SubscriptionCard({
    super.key,
    required this.subscription,
    required this.isSelected,
    required this.isChecked,
    required this.onTap,
    this.onChecked,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          margin: EdgeInsets.all(isSelected ? 0 : 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isSelected
                  ? [
                      const Color(0xFF6A11CB),
                      const Color(0xFF2575FC),
                    ]
                  : [
                      const Color.fromARGB(255, 31, 40, 95).withOpacity(0.7),
                      const Color.fromARGB(255, 75, 76, 130).withOpacity(0.7),
                    ],
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFF2575FC).withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 10),
                    )
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(0, 4),
                    )
                  ],
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            subscription.name,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (subscription.isPopular)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.amber, Colors.orange],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.amber.withOpacity(0.3),
                                  blurRadius: 6,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Text(
                              'POPULAR',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${subscription.price.toStringAsFixed(2)}/${subscription.formattedDuration}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...subscription.features.take(3).map((feature) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.check_circle, size: 18, color: Colors.white.withOpacity(0.8)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  feature,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    if (subscription.features.length > 3)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          '+ ${subscription.features.length - 3} more features',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    if (isSelected)
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.5),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Text(
                            'SELECTED',
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Transform.scale(
                  scale: 1.2,
                  child: Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      if (onChecked != null) {
                        onChecked!(value ?? false);
                      }
                    },
                    activeColor: Colors.blueAccent,
                    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.green; // Color when checked
                      }
                      return Colors.white; // Transparent when unchecked
                    }),
                    checkColor: Colors.white, // Tick color
                    shape: const CircleBorder(),
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

class SubscriptionDetailsPanel extends StatefulWidget {
  final Subscription subscription;
  final bool isSelected;
  final ValueChanged<bool>? onSelectionChanged;

  const SubscriptionDetailsPanel({
    super.key,
    required this.subscription,
    this.isSelected = false,
    this.onSelectionChanged,
  });

  @override
  State<SubscriptionDetailsPanel> createState() => _SubscriptionDetailsPanelState();
}

class _SubscriptionDetailsPanelState extends State<SubscriptionDetailsPanel> {
  late Subscription _editableSubscription;
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _editableSubscription = Subscription(
      id: widget.subscription.id,
      name: widget.subscription.name,
      price: widget.subscription.price,
      duration: widget.subscription.duration,
      features: List.from(widget.subscription.features),
      description: widget.subscription.description,
      imageUrl: widget.subscription.imageUrl,
      isPopular: widget.subscription.isPopular,
    );
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isEditing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Changes saved for ${_editableSubscription.name}'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with edit/save buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _isEditing
                            ? TextFormField(
                                initialValue: _editableSubscription.name,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Plan name',
                                  hintStyle: theme.textTheme.headlineSmall?.copyWith(
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _editableSubscription = _editableSubscription.copyWith(name: value);
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a plan name';
                                  }
                                  return null;
                                },
                              )
                            : AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                child: Text(
                                  _editableSubscription.name,
                                  key: ValueKey(_editableSubscription.id),
                                  style: theme.textTheme.headlineSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                        const SizedBox(height: 8),
                        _isEditing
                            ? TextFormField(
                                initialValue: '\$${_editableSubscription.price.toStringAsFixed(2)}/${_editableSubscription.formattedDuration}',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                  fontWeight: FontWeight.bold,
                                ),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Price',
                                  hintStyle: theme.textTheme.titleLarge?.copyWith(
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                                onChanged: (value) {
                                  // Parse price from the input
                                  final price = double.tryParse(value.replaceAll(RegExp(r'[^0-9.]'), '')) ?? _editableSubscription.price;
                                  setState(() {
                                    _editableSubscription = _editableSubscription.copyWith(price: price);
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a price';
                                  }
                                  return null;
                                },
                              )
                            : AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                child: Text(
                                  '\$${_editableSubscription.price.toStringAsFixed(2)}/${_editableSubscription.formattedDuration}',
                                  key: ValueKey(_editableSubscription.id),
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    color: Colors.white.withOpacity(0.9),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  if (!_isEditing)
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.white),
                      onPressed: _toggleEdit,
                    ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Popular badge (editable)
            if (_editableSubscription.isPopular)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Center(
                  child: _isEditing
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: _editableSubscription.isPopular,
                              onChanged: (value) {
                                setState(() {
                                  _editableSubscription = _editableSubscription.copyWith(isPopular: value ?? false);
                                });
                              },
                              activeColor: Colors.amber,
                            ),
                            Text(
                              'Mark as Popular',
                              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
                            ),
                          ],
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.amber, Colors.orange],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withOpacity(0.4),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Text(
                            'MOST POPULAR CHOICE',
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                ),
              ),

            const SizedBox(height: 32),

            // Plan benefits section (editable)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PLAN BENEFITS',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_isEditing)
                    ..._editableSubscription.features.asMap().entries.map((entry) {
                      final index = entry.key;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _editableSubscription.features.removeAt(index);
                                });
                              },
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                initialValue: entry.value,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Enter feature',
                                  hintStyle: theme.textTheme.bodyLarge?.copyWith(
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _editableSubscription.features[index] = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  if (_isEditing)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.add_circle, color: Colors.green),
                            onPressed: () {
                              setState(() {
                                _editableSubscription.features.add('');
                              });
                            },
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Add new feature',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (!_isEditing)
                    ..._editableSubscription.features.map((feature) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.check_circle, size: 24, color: Colors.greenAccent),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  feature,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Description section (editable)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DESCRIPTION',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _isEditing
                      ? TextFormField(
                          initialValue: _editableSubscription.description,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.white70,
                          ),
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Enter description',
                            hintStyle: theme.textTheme.bodyLarge?.copyWith(
                              color: Colors.white70.withOpacity(0.5),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _editableSubscription = _editableSubscription.copyWith(description: value);
                            });
                          },
                        )
                      : Text(
                          _editableSubscription.description,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.white70,
                            height: 1.6,
                          ),
                        ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Save/Cancel buttons when editing
            if (_isEditing)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        onPressed: _saveChanges,
                        child: Text(
                          'SAVE CHANGES',
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        onPressed: _toggleEdit,
                        child: Text(
                          'CANCEL',
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Edit button when not editing
            if (!_isEditing)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                      shadowColor: Colors.blueAccent.withOpacity(0.5),
                    ),
                    onPressed: _toggleEdit,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.edit, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'EDIT SUBSCRIPTION',
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 16),

            // Changes notice
            Center(
              child: Text(
                _isEditing ? 'Edit the subscription details' : 'Changes will be applied immediately',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white54,
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class Subscription {
  final String id;
  final String name;
  final double price;
  final Duration duration;
  final List<String> features;
  final String description;
  final String imageUrl;
  final bool isPopular;

  Subscription({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
    required this.features,
    required this.description,
    required this.imageUrl,
    this.isPopular = false,
  });

  String get formattedDuration {
    if (duration.inDays >= 365) {
      return '${(duration.inDays / 365).round()} Year';
    } else if (duration.inDays >= 30) {
      return '${(duration.inDays / 30).round()} Months';
    } else {
      return '${duration.inDays} Days';
    }
  }

  Subscription copyWith({
    String? id,
    String? name,
    double? price,
    Duration? duration,
    List<String>? features,
    String? description,
    String? imageUrl,
    bool? isPopular,
  }) {
    return Subscription(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      duration: duration ?? this.duration,
      features: features ?? List.from(this.features),
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isPopular: isPopular ?? this.isPopular,
    );
  }
}

class SubscriptionRepository {
  static List<Subscription> getSubscriptions() {
    return [
      Subscription(
        id: '1',
        name: 'Mobile Plan',
        price: 4.99,
        duration: const Duration(days: 30),
        features: [
          'Watch on 1 mobile device at a time',
          'HD quality (720p) streaming',
          'Ads included in content',
          'Download on 1 device',
          'Cancel anytime with no fees',
        ],
        description:
            'Perfect for individual users who primarily watch content on their mobile devices and want an affordable, no-commitment option. Enjoy our basic catalog with standard definition quality.',
        imageUrl: 'https://example.com/sub1.jpg',
      ),
      Subscription(
        id: '2',
        name: 'Premium Plan',
        price: 9.99,
        duration: const Duration(days: 30),
        features: [
          'Watch on 2 devices simultaneously',
          'Full HD quality (1080p) streaming',
          'Ad-free viewing experience',
          'Download on 2 devices',
          'Access to exclusive premium content',
          'Cancel anytime with no fees',
        ],
        description: 'Our most popular plan with excellent value, offering premium features for individuals or couples. Enjoy our full catalog in high definition without interruptions.',
        imageUrl: 'https://example.com/sub2.jpg',
        isPopular: true,
      ),
      Subscription(
        id: '3',
        name: 'Family Plan',
        price: 14.99,
        duration: const Duration(days: 30),
        features: [
          'Watch on 4 devices simultaneously',
          '4K Ultra HD quality streaming',
          'Completely ad-free experience',
          'Download on 4 devices',
          'Access to all exclusive content',
          'Early access to new releases',
          'Dedicated kids profile',
          'Cancel anytime with no fees',
        ],
        description: 'Ideal for families with multiple viewers who want the best quality and simultaneous streaming. Includes parental controls and kid-friendly content.',
        imageUrl: 'https://example.com/sub3.jpg',
      ),
      Subscription(
        id: '4',
        name: 'Ultimate Yearly',
        price: 99.99,
        duration: const Duration(days: 365),
        features: [
          'Watch on 4 devices simultaneously',
          '4K Ultra HD & Dolby Atmos support',
          'Completely ad-free experience',
          'Unlimited downloads',
          'Access to all exclusive content',
          'Early access to new releases',
          'Dedicated kids profile',
          'Priority customer support',
          'Save 30% compared to monthly',
        ],
        description: 'Our best value plan with all premium features at a significant discount for yearly commitment. Enjoy the highest quality streaming with all the perks we offer.',
        imageUrl: 'https://example.com/sub4.jpg',
        isPopular: true,
      ),
    ];
  }
}
