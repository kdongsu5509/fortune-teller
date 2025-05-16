import 'package:ai_fortune_teller_app/common/router.dart';
import 'package:ai_fortune_teller_app/setting/repository/model/birth_time.dart';
import 'package:ai_fortune_teller_app/setting/view_model/user_info_update_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/model/user_info_dto.dart';
import '../util/user_info_view_model_provider.dart';

class UserInfoUpdateView extends ConsumerStatefulWidget {
  const UserInfoUpdateView({super.key});

  @override
  ConsumerState<UserInfoUpdateView> createState() => _UserInfoUpdateViewState();
}

class _UserInfoUpdateViewState extends ConsumerState<UserInfoUpdateView> {
  late final UserInfoUpdateViewModel viewModel;
  UserInfoDTO? userInfo;

  @override
  void initState() {
    super.initState();
    viewModel = ref.read(userInfoUpdateViewModelProvider);
    viewModel.init();
    userInfo = viewModel.userInfo;
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSmall = sw < 400;

    List<Widget> children = [
      _buildTitle(context),
      SizedBox(height: sh * 0.03),
      _buildNameField(sw, sh, isSmall, isDark),
      SizedBox(height: sh * 0.03),
      _buildDateInkwells(sw, sh, isDark),
      SizedBox(height: sh * 0.03),
      _buildSexAndTimeRow(sw, sh, isSmall, isDark),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: sw * 0.06,
          right: sw * 0.06,
          top: sh * 0.04,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: sw * 0.06,
          right: sw * 0.06,
          bottom:
              MediaQuery.of(context).viewInsets.bottom > 0
                  ? MediaQuery.of(context).viewInsets.bottom
                  : sh * 0.03,
          top: sh * 0.02,
        ),
        child: _buildSaveButton(sw, isSmall),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) => Text(
    "사용자 정보 수정",
    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.w600,
      fontFamily: "ChosunCentennial",
    ),
  );

  Widget _buildNameField(double sw, double sh, bool isSmall, bool isDark) =>
      _outlinedContainer(
        sw,
        sh,
        TextField(
          controller: viewModel.nameController,
          style: TextStyle(fontSize: isSmall ? 14 : 16),
          decoration: const InputDecoration(
            labelText: "이름",
            border: InputBorder.none,
          ),
        ),
        isDark,
      );

  Widget _buildDateInkwells(double sw, double sh, bool isDark) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 4,
        child: _buildDateInkWell("생년", viewModel.selectedYear, sw, sh, isDark),
      ),
      SizedBox(width: sw * 0.03),
      Expanded(
        flex: 3,
        child: _buildDateInkWell("월", viewModel.selectedMonth, sw, sh, isDark),
      ),
      SizedBox(width: sw * 0.03),
      Expanded(
        flex: 3,
        child: _buildDateInkWell("일", viewModel.selectedDay, sw, sh, isDark),
      ),
    ],
  );

  Widget _buildDateInkWell(
    String label,
    int? selected,
    double sw,
    double sh,
    bool isDark,
  ) => InkWell(
    onTap: () async {
      final picked = await showModalBottomSheet<int>(
        context: context,
        builder:
            (context) => ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: _getList(label).length,
              itemBuilder: (context, index) {
                final value = _getList(label)[index];
                return ListTile(
                  title: Text("$value"),
                  onTap: () => Navigator.pop(context, value),
                );
              },
              separatorBuilder: (context, index) => const Divider(height: 1),
            ),
      );
      if (picked != null) {
        setState(() {
          switch (label) {
            case "생년":
              viewModel.selectedYear = picked;
              viewModel.generateDayList();
              break;
            case "생월":
              viewModel.selectedMonth = picked;
              viewModel.generateDayList();
              break;
            case "생일":
              viewModel.selectedDay = picked;
              break;
          }
        });
      }
    },
    borderRadius: BorderRadius.circular(16),
    child: _outlinedContainer(
      sw,
      sh,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label: ${selected ?? '-'}",
            style: TextStyle(fontSize: sw * 0.035, fontWeight: FontWeight.w500),
          ),
          const Icon(Icons.expand_more, color: Colors.grey),
        ],
      ),
      isDark,
    ),
  );

  List<int> _getList(String label) {
    switch (label) {
      case "생년":
        return viewModel.years;
      case "생월":
        return viewModel.months;
      case "생일":
        return viewModel.days;
      default:
        return [];
    }
  }

  Widget _buildSexAndTimeRow(double sw, double sh, bool isSmall, bool isDark) =>
      Row(
        children: [
          Expanded(
            flex: 1,
            child: _outlinedDropdown(sw, sh, viewModel.sex, "성별", isDark),
          ),
          SizedBox(width: sw * 0.03),
          Expanded(
            flex: 2,
            child: _buildBirthTimePicker(sw, sh, isSmall, isDark),
          ),
        ],
      );

  Widget _buildBirthTimePicker(
    double sw,
    double sh,
    bool isSmall,
    bool isDark,
  ) => InkWell(
    onTap: () async {
      final picked = await showModalBottomSheet<String>(
        context: context,
        builder:
            (context) => ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: BirthTime.values.length,
              itemBuilder: (context, index) {
                final time = BirthTime.values[index];
                return ListTile(
                  title: Text(time.label),
                  onTap: () => Navigator.pop(context, time.name),
                );
              },
              separatorBuilder: (context, index) => const Divider(height: 1),
            ),
      );
      if (picked != null) {
        setState(
          () =>
              viewModel.selectedTime = BirthTime.values.firstWhere(
                (e) => e.name == picked,
              ),
        );
      }
    },
    borderRadius: BorderRadius.circular(16),
    child: _outlinedContainer(
      sw,
      sh,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '생시: ${viewModel.selectedTime.label}',
            style: TextStyle(fontSize: sw * 0.035, fontWeight: FontWeight.w500),
          ),
          const Icon(Icons.expand_more, color: Colors.grey),
        ],
      ),
      isDark,
    ),
  );

  Widget _buildSaveButton(double sw, bool isSmall) => SizedBox(
    width: double.infinity,
    height: 52,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: _handleSave,
      child: Text(
        "저장",
        style: TextStyle(
          fontSize: isSmall ? 14 : 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );

  Widget _outlinedContainer(double sw, double sh, Widget child, bool isDark) =>
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: sw * 0.04,
          vertical: sh * 0.018,
        ),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.transparent : Colors.black12,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: child,
      );

  Widget _outlinedDropdown(
    double sw,
    double sh,
    List<int> items,
    String label,
    bool isDark,
  ) {
    final isSex = label == "성별";
    int? selected;
    switch (label) {
      case "성별":
        selected = viewModel.selectedGender;
        break;
    }

    return _outlinedContainer(
      sw,
      sh,
      DropdownButtonHideUnderline(
        child: DropdownButtonFormField<int>(
          value: selected,
          decoration: InputDecoration(
            labelStyle: TextStyle(
              color: isDark ? Colors.white70 : Colors.grey[800],
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
          ),
          dropdownColor: isDark ? Colors.grey[900] : Colors.white,
          isExpanded: true,
          borderRadius: BorderRadius.circular(12),
          items:
              items.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    isSex ? (value == 1 ? "남자" : "여자") : "$value",
                    style: TextStyle(
                      fontSize: sw * 0.035,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                );
              }).toList(),
          onChanged: (value) {
            setState(() {
              if (label == "성별") {
                viewModel.selectedGender = value;
              }
            });
          },
        ),
      ),
      isDark,
    );
  }

  void _handleSave() async {
    if (viewModel.nameController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("이름을 입력해주세요")));
      return;
    }

    await viewModel.updateUserInfo();

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("저장 완료")));

    router.pop();
  }
}
