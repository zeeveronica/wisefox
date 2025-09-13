import 'package:flutter/material.dart';
import 'package:wisefox/apps/features/bloc/profile/user_bloc.dart';
import 'package:wisefox/apps/model/user.dart';
import 'package:wisefox/apps/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalDetailsPage extends StatefulWidget {
  const PersonalDetailsPage({super.key});

  @override
  _PersonalDetailsPageState createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> with TickerProviderStateMixin {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Address Info
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _postCodeController = TextEditingController();
  final TextEditingController _addressLineController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  // Second Contact
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();
  final TextEditingController _secondPhoneController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _loadUser();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadUser() async {
    final user = await AppUtils.getUser();
    if (user != null) {
      _firstNameController.text = user.firstName ?? '';
      _lastNameController.text = user.lastName ?? '';
      _usernameController.text = user.username ?? '';
      _emailController.text = user.email ?? '';
      _phoneController.text = user.phoneNumber ?? '';
      context.read<UserBloc>().add(LoadUser(user));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 768;

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[50],
          body: CustomScrollView(
            slivers: [
              _buildSliverAppBar(context, state),
              SliverToBoxAdapter(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: isTablet ? 800 : double.infinity,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: isTablet ? (size.width - 800) / 2 : 0,
                    ),
                    child: Column(
                      children: [
                        _buildProfileSection(state.user, size),
                        _buildBasicDetailsCard(state, size),
                        _buildAddressInfoCard(size),
                        _buildSecondContactCard(size),
                        SizedBox(height: 100), // Bottom padding for FAB
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // floatingActionButton: _buildFloatingActionButton(context, state),
        );
      },
    );
  }

  Widget _buildSliverAppBar(BuildContext context, UserState state) {
    return SliverAppBar(
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: AppColors.primaryColor,
      iconTheme: IconThemeData(
        color: Colors.white, // <-- set your back icon color here
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          "Personal Info",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primaryColor,
                AppColors.primaryColor.withOpacity(0.8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(User? user, Size size) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Hero(
            tag: "profile_image",
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: _buildProfileImage(user),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.camera_alt, color: Colors.white, size: 18),
                      onPressed: () {
                        // Handle profile image update
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            "${user?.firstName ?? 'User'} ${user?.lastName ?? ''}".trim(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          Text(
            user?.email ?? "No email provided",
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicDetailsCard(UserState state, Size size) {
    return _buildCard(
      title: "Basic Details",
      icon: Icons.person_outline,
      // trailing: _buildEditButton(state),
      children: [
        _buildModernTextField("First Name", _firstNameController, Icons.person, editable: state.isEditing),
        _buildModernTextField("Last Name", _lastNameController, Icons.person_outline, editable: state.isEditing),
        _buildModernTextField("Username", _usernameController, Icons.alternate_email),
        _buildModernTextField("Email Address", _emailController, Icons.email_outlined, keyboardType: TextInputType.emailAddress),
        _buildModernTextField("Phone Number", _phoneController, Icons.phone_outlined, keyboardType: TextInputType.phone),
      ],
    );
  }

  Widget _buildAddressInfoCard(Size size) {
    return _buildCard(
      title: "Address Information",
      icon: Icons.location_on_outlined,
      children: [
        _buildModernTextField("Country", _countryController, Icons.public),
        _buildModernTextField("Post Code", _postCodeController, Icons.markunread_mailbox_outlined),
        _buildModernTextField("Address Line", _addressLineController, Icons.home_outlined),
        _buildModernTextField("City", _cityController, Icons.location_city_outlined),
        _buildModernTextField("State", _stateController, Icons.map_outlined),
      ],
    );
  }

  Widget _buildSecondContactCard(Size size) {
    return _buildCard(
      title: "Emergency Contact",
      icon: Icons.contact_phone_outlined,
      children: [
        _buildModernTextField("Contact Name", _secondNameController, Icons.person_add_outlined),
        _buildModernTextField("Relationship", _relationshipController, Icons.family_restroom_outlined),
        _buildModernTextField("Phone Number", _secondPhoneController, Icons.phone_in_talk_outlined, keyboardType: TextInputType.phone),
      ],
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    Widget? trailing,
    required List<Widget> children,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: AppColors.primaryColor, size: 20),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                if (trailing != null) trailing,
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditButton(UserState state) {
    return Container(
      decoration: BoxDecoration(
        color: state.isEditing ? Colors.green.withOpacity(0.1) : AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(
          state.isEditing ? Icons.check : Icons.edit_outlined,
          color: state.isEditing ? Colors.green : AppColors.primaryColor,
          size: 20,
        ),
        onPressed: () {
          if (state.isEditing) {
            context.read<UserBloc>().add(UpdateBasicDetails(
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
            ));
            // Show success alert
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.check_circle_outline, color: Colors.white),
                    SizedBox(width: 12),
                    Text(
                      "Basic details updated successfully!",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.all(16),
                duration: Duration(seconds: 3),
              ),
            );
          } else {
            context.read<UserBloc>().add(ToggleEdit());
          }
        },
      ),
    );
  }

  Widget _buildModernTextField(
      String label,
      TextEditingController controller,
      IconData icon, {
        bool editable = false,
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        readOnly: !editable,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.grey[600], size: 20),
          filled: true,
          fillColor: editable ? Colors.blue.withOpacity(0.05) : Colors.grey.withOpacity(0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          ),
          labelStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildProfileImage(User? user) {
    if (user?.profilePhoto != null && user!.profilePhoto!.isNotEmpty) {
      return CircleAvatar(
        radius: 60,
        backgroundColor: Colors.grey[200],
        child: ClipOval(
          child: Image.network(
            user.profilePhoto!,
            width: 120,
            height: 120,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _buildInitialsAvatar(user);
            },
          ),
        ),
      );
    } else {
      return _buildInitialsAvatar(user);
    }
  }

  Widget _buildInitialsAvatar(User? user) {
    String initials = '';
    if (user?.firstName?.isNotEmpty ?? false) {
      initials += user!.firstName![0].toUpperCase();
    }
    if (user?.lastName?.isNotEmpty ?? false) {
      initials += user!.lastName![0].toUpperCase();
    }
    if (initials.isEmpty) initials = 'U';

    return CircleAvatar(
      radius: 60,
      backgroundColor: AppColors.primaryColor,
      child: Text(
        initials,
        style: TextStyle(
          fontSize: 36,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context, UserState state) {
    return FloatingActionButton.extended(
      onPressed: () {
        // Handle save action
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text("Profile updated successfully!"),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      },
      icon: Icon(Icons.save_outlined),
      label: Text("Save Changes", style: TextStyle(fontWeight: FontWeight.w600)),
      backgroundColor: AppColors.primaryColor,
      elevation: 4,
    );
  }
}