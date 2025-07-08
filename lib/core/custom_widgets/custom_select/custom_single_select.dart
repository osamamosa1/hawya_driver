import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hawiah_driver/core/custom_widgets/api_response_widget.dart';
import 'package:hawiah_driver/core/custom_widgets/custom-text-field-widget.dart';
import 'package:hawiah_driver/core/custom_widgets/svg_prefix_icon.dart';
import 'package:hawiah_driver/core/extension/context_extension.dart';
import 'package:hawiah_driver/core/locale/app_locale_key.dart';
import 'package:hawiah_driver/core/networking/api_helper.dart';
import 'package:hawiah_driver/core/theme/app_colors.dart';
import 'package:hawiah_driver/core/theme/app_text_style.dart';
import 'package:hawiah_driver/core/utils/common_methods.dart';
import 'package:hawiah_driver/core/utils/navigator_methods.dart';

import 'custom_select_item.dart';

class CustomSingleSelect extends StatefulWidget {
  final dynamic value;
  final List<CustomSelectItem>? items;
  final void Function(dynamic)? onChanged;
  final String? Function(dynamic)? validator;
  final String? hintText;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double radius;
  final Color? fillColor;
  final Color? focusColor;
  final Color? unFocusColor;
  final String? title;
  final String? otherSideTitle;
  final ApiResponse? apiResponse;
  final void Function()? onReload;
  final void Function()? onReInitial;
  final Widget? icon;
  final TextStyle? hintStyle;
  final bool hasRemove;
  final FormFieldBorder formFieldBorder;
  final Widget? label;
  final String? labelText;
  final String? prefixIconSvg;
  final Color? prefixIconSvgColor;
  final String? suffixIconSvg;
  final Color? suffixIconSvgColor;
  final double? width;
  const CustomSingleSelect({
    super.key,
    this.value,
    this.items,
    this.onChanged,
    this.validator,
    this.hintText,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.radius = 12,
    this.fillColor,
    this.focusColor,
    this.unFocusColor,
    this.title,
    this.otherSideTitle,
    this.apiResponse,
    this.onReload,
    this.icon,
    this.onReInitial,
    this.formFieldBorder = FormFieldBorder.outLine,
    this.hintStyle,
    this.hasRemove = true,
    this.label,
    this.labelText,
    this.prefixIconSvg,
    this.suffixIconSvg,
    this.prefixIconSvgColor,
    this.suffixIconSvgColor,
    this.width,
  });

  @override
  State<CustomSingleSelect> createState() => _CustomSingleSelectState();
}

class _CustomSingleSelectState extends State<CustomSingleSelect> {
  final _selectedEC = TextEditingController();
  final _focusNode = FocusNode();

  void _showValue() {
    Future.delayed(Duration.zero, () {
      _selectedEC.text = widget.items
              ?.firstWhereOrNull((element) => element.value == widget.value)
              ?.name ??
          "";
    });
  }

  @override
  Widget build(BuildContext context) {
    _showValue();
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (widget.title != null) ...{
                Expanded(
                  child: Text(
                    widget.title!,
                    style: AppTextStyle.formTitleStyle,
                  ),
                ),
              },
              if (widget.otherSideTitle != null) ...{
                Text(
                  widget.otherSideTitle!,
                  style: AppTextStyle.formTitleStyle,
                ),
              },
            ],
          ),
          if (widget.title != null || widget.otherSideTitle != null) ...{
            const SizedBox(height: 10),
          },
          TextFormField(
            focusNode: _focusNode,
            controller: _selectedEC,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            validator: widget.validator != null
                ? (v) {
                    return widget.validator?.call(widget.value);
                  }
                : null,
            onTap: widget.apiResponse?.state == ResponseState.loading
                ? null
                : widget.items != null && widget.items?.isNotEmpty == true
                    ? () {
                        NavigatorMethods.showAppBottomSheet(
                          context,
                          CustomSingleSelectBottomSheet(
                            value: widget.value,
                            items: widget.items,
                            hasRemove: widget.hasRemove,
                            onChanged: (v) {
                              widget.onChanged?.call(v);
                            },
                          ),
                          isScrollControlled: true,
                        );
                      }
                    : () {
                        CommonMethods.showAlertDialog(
                          message: context.apiTr(
                            ar: "لا توجد بيانات",
                            en: "There is no data",
                          ),
                        );
                      },
            readOnly: true,
            style: AppTextStyle.textFormStyle,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: widget.maxLines,
            cursorColor: widget.focusColor,
            decoration: InputDecoration(
              label: widget.label,
              labelText: widget.labelText,
              hintMaxLines: 2,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ?? AppTextStyle.hintStyle,
              fillColor: widget.fillColor ??
                  (widget.formFieldBorder == FormFieldBorder.underLine
                      ? Colors.transparent
                      : AppColor.textFormFillColor),
              filled: true,
              border: _border(
                color: widget.unFocusColor ?? AppColor.textFormBorderColor,
              ),
              disabledBorder: _border(
                color: widget.unFocusColor ?? AppColor.textFormBorderColor,
              ),
              focusedBorder: _border(
                color: widget.unFocusColor ?? AppColor.mainAppColor,
              ),
              enabledBorder: _border(
                color: widget.unFocusColor ?? AppColor.textFormBorderColor,
              ),
              errorBorder: _border(color: Colors.red.shade700),
              focusedErrorBorder: _border(color: Colors.red.shade700),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              suffixIconConstraints: BoxConstraints(
                maxWidth: widget.suffixIcon != null ? 110 : 40,
              ),
              prefixIcon: widget.prefixIconSvg != null
                  ? Container(
                      width: 45,
                      height: 47,
                      margin: const EdgeInsets.all(1),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.horizontal(
                          start: Radius.circular(widget.radius),
                        ),
                      ),
                      child: Stack(
                        children: [
                          PositionedDirectional(
                            bottom: 0,
                            top: 0,
                            start: 0,
                            end: 2,
                            child: SvgPrefixIcon(
                              imagePath: widget.prefixIconSvg!,
                              color: widget.prefixIconSvgColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  : widget.prefixIcon,
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 35,
                    child: widget.apiResponse != null
                        ? ApiResponseWidget(
                            apiResponse: widget.apiResponse!,
                            onReload: widget.onReload,
                            isEmpty: false,
                            errorWidget: IconButton(
                              onPressed: widget.onReload,
                              icon: Icon(
                                CupertinoIcons.refresh_circled_solid,
                                color: AppColor.hintColor,
                              ),
                            ),
                            offlineWidget: GestureDetector(
                              onTap: widget.onReload,
                              child: Icon(
                                CupertinoIcons.refresh_circled_solid,
                                color: AppColor.hintColor,
                              ),
                            ),
                            loadingWidget: const CupertinoActivityIndicator(),
                            child: widget.icon ??
                                Icon(
                                  widget.items == null || widget.items!.isEmpty
                                      ? Icons.error_rounded
                                      : Icons.keyboard_arrow_down_rounded,
                                  color: AppColor.hintColor,
                                  size: 25,
                                ),
                          )
                        : widget.icon ??
                            Icon(
                              widget.items == null || widget.items!.isEmpty
                                  ? Icons.error_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                              color: AppColor.hintColor,
                              size: 25,
                            ),
                  ),
                  if (widget.suffixIcon != null ||
                      widget.suffixIconSvg != null) ...{
                    widget.suffixIconSvg != null
                        ? Container(
                            width: 45,
                            height: 47,
                            margin: const EdgeInsets.all(1),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.horizontal(
                                end: Radius.circular(widget.radius),
                              ),
                            ),
                            child: Stack(
                              children: [
                                PositionedDirectional(
                                  bottom: 0,
                                  top: 0,
                                  start: 0,
                                  end: 2,
                                  child: SvgPrefixIcon(
                                    imagePath: widget.suffixIconSvg!,
                                    color: widget.suffixIconSvgColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : (widget.suffixIcon ?? const SizedBox()),
                    const SizedBox(width: 10),
                  },
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputBorder _border({required Color color}) {
    switch (widget.formFieldBorder) {
      case FormFieldBorder.outLine:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide(color: color),
        );
      case FormFieldBorder.underLine:
        return UnderlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: color),
        );
      case FormFieldBorder.none:
        return InputBorder.none;
    }
  }
}

class CustomSingleSelectBottomSheet extends StatefulWidget {
  final dynamic value;
  final List<CustomSelectItem>? items;
  final void Function(dynamic)? onChanged;
  final bool hasRemove;
  const CustomSingleSelectBottomSheet({
    super.key,
    this.value,
    this.items,
    this.onChanged,
    this.hasRemove = true,
  });

  @override
  State<CustomSingleSelectBottomSheet> createState() =>
      _CustomSingleSelectBottomSheetState();
}

class _CustomSingleSelectBottomSheetState
    extends State<CustomSingleSelectBottomSheet> {
  dynamic _initialValue;
  List<CustomSelectItem>? _items;
  @override
  void initState() {
    _initialValue = widget.value;
    _items = widget.items;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      ),
      constraints: BoxConstraints(maxHeight: context.height() * 0.75),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                // CustomButton(
                //   text: context.apiTr(ar: 'تطبيق', en: 'Done'),
                //   height: 47,
                //   width: 90,
                //   onPressed: () {

                //   },
                // ),
                // const SizedBox(width: 10),
                Expanded(
                  child: CustomTextField(
                    fillColor: AppColor.offWhiteColor,
                    unFocusColor: AppColor.offWhiteColor,
                    hintText: tr(AppLocaleKey.search),
                    onChanged: (v) {
                      _items = widget.items
                          ?.where(
                            (element) => element.name.toLowerCase().contains(v),
                          )
                          .toList();
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  ...List.generate(
                    _items?.length ?? 0,
                    (index) => Column(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              switch (widget.hasRemove) {
                                case true:
                                  if (_initialValue == _items?[index].value) {
                                    setState(() {
                                      _initialValue = null;
                                    });
                                  } else {
                                    setState(() {
                                      _initialValue = _items?[index].value;
                                    });
                                  }
                                  break;
                                case false:
                                  setState(() {
                                    _initialValue = _items?[index].value;
                                  });
                                  break;
                              }
                              widget.onChanged?.call(_initialValue);
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _items?[index].name ?? "",
                                      style: TextStyle(
                                        color: AppColor.textPrimaryColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  CircleAvatar(
                                    backgroundColor:
                                        _initialValue == _items?[index].value
                                            ? AppColor.mainAppColor
                                            : AppColor.greyColor,
                                    radius: 11,
                                    child: CircleAvatar(
                                      backgroundColor: AppColor.whiteColor,
                                      radius: 9,
                                      child: CircleAvatar(
                                        backgroundColor: _initialValue ==
                                                _items?[index].value
                                            ? AppColor.mainAppColor
                                            : AppColor.whiteColor,
                                        radius: 7,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.viewInsetsOf(context).bottom),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
