import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:success_factors/helps/consts.dart';
import 'package:success_factors/hive/achievement_hive.dart';
import 'package:success_factors/hive/factor_hive.dart';
import 'package:success_factors/provider/hive_provider.dart';

import 'package:success_factors/widgets/icon_picker.dart';

enum AddUpdateViewType {
  addAchievement,
  addFactor,
  updateAchievement,
  updateFactor
}

class AddUpdateView extends StatefulWidget {
  String? heroTag;
  String title;
  AddUpdateViewType type;
  int? achievementIndex;
  int? factorIndex;
  AchievementHive? element;
  bool fromFactor;

  AddUpdateView(
      {Key? key,
      this.heroTag,
      required this.title,
      required this.type,
      this.achievementIndex,
      this.factorIndex,
      this.element,
      bool? fromFactor})
      : fromFactor = fromFactor ?? false , super(key: key);

  @override
  State<AddUpdateView> createState() => _AddUpdateViewState();
}

class _AddUpdateViewState extends State<AddUpdateView> {
  var formKey = GlobalKey<FormState>();

  String? title;
  double? percent;
  String? description;
  int? iconIndex;
  int? iconColorIndex;

  @override
  void initState() {
    if (widget.type == AddUpdateViewType.updateAchievement) {
      title = widget.element!.title;
      description = widget.element!.description;
    } else if (widget.type == AddUpdateViewType.updateFactor) {
      FactorHive factor = widget.element!.factors![widget.factorIndex!];
      title = factor.title;
      percent = factor.percent;
      description = factor.description;
      iconIndex = factor.iconIndex;
      iconColorIndex = factor.iconColorIndex;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      floatingActionButton: FloatingActionButton.extended(
        splashColor: Colors.black,
        backgroundColor: bg1,
        heroTag: widget.heroTag,
        label: (widget.type == AddUpdateViewType.addAchievement ||
                widget.type == AddUpdateViewType.addFactor)
            ? Row(
                children: const [
                  Text(
                    'ADD',
                    style: TextStyle(fontWeight: FontWeight.w900, color: text1),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.add,
                    size: size30,
                    color: text1,
                  ),
                ],
              )
            : Row(
                children: const [
                  Text(
                    'EDIT',
                    style: TextStyle(fontWeight: FontWeight.w900, color: text1),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.edit,
                    size: size30,
                    color: text1,
                  ),
                ],
              ),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            if (widget.type == AddUpdateViewType.addFactor) {
              AchievementHive element =
                  context.read<HiveProvider>().achi[widget.achievementIndex!];
              FactorHive factor = FactorHive(
                title: title!,
                percent: percent!,
                iconIndex: iconIndex!,
                iconColorIndex: iconColorIndex!,
                description: description,
              );
              element.factors ??= element.factors = [];
              // ↑ ↑ otherwise could be null. even though its [] by default in AchievementHive
              element.factors!.add(factor);
              await context
                  .read<HiveProvider>()
                  .updateAchievement(element, widget.achievementIndex!);
            } else if (widget.type == AddUpdateViewType.addAchievement) {
              await context.read<HiveProvider>().addAchievement(
                  AchievementHive(title: title!, description: description));
            } else if (widget.type == AddUpdateViewType.updateAchievement) {
              widget.element!
                ..title = title!
                ..description = description;
              await context
                  .read<HiveProvider>()
                  .updateAchievement(widget.element!, widget.achievementIndex!);
            } else if (widget.type == AddUpdateViewType.updateFactor) {
              widget.element!.factors![widget.factorIndex!]
                ..title = title!
                ..percent = percent!
                ..description = description
                ..iconIndex = iconIndex!
                ..iconColorIndex = iconColorIndex!;
              await context
                  .read<HiveProvider>()
                  .updateAchievement(widget.element!, widget.achievementIndex!);
            }
            Navigator.of(context).pop();
          }
          // may add some cheerful words as snackbar
        },
      ),
      appBar: AppBar(
        actions: [
          if (widget.type == AddUpdateViewType.updateAchievement ||
              widget.type == AddUpdateViewType.updateFactor)
            IconButton(
              onPressed: () async {
                if (widget.type == AddUpdateViewType.updateAchievement) {
                  await context
                      .read<HiveProvider>()
                      .deleteAchievement(widget.achievementIndex!);
                } else if (widget.type == AddUpdateViewType.updateFactor) {
                  await context.read<HiveProvider>().deleteFactor(
                      widget.achievementIndex!, widget.factorIndex!);
                }
                Navigator.pop(context, widget.fromFactor ? 'Deleted' : "");
              },
              icon: const Icon(Icons.delete),
            ),
        ],
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.w900, color: text1),
        ),
        centerTitle: true,
      ),
      gradient: const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: bgGradient1,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(padding30),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: padding30),
                  child: TextFormField(
                    initialValue: title,
                    style: const TextStyle(fontSize: 40, color: Colors.black),
                    decoration: const InputDecoration(
                        errorStyle:
                            TextStyle(fontSize: 20, color: Colors.black),
                        border: InputBorder.none,
                        labelText: "Title",
                        labelStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.black)),
                    validator: (inputValue) {
                      if (inputValue == null || inputValue.isEmpty) {
                        return "Please enter Title";
                      } else {
                        title = inputValue;
                      }
                      return null;
                    },
                  ),
                ),
                if (widget.type == AddUpdateViewType.addFactor ||
                    widget.type == AddUpdateViewType.updateFactor)
                  Container(
                    padding: const EdgeInsets.only(bottom: padding30),
                    child: TextFormField(
                      initialValue:
                          percent != null ? percent!.toStringAsFixed(2) : null,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[-0-9.,]')),
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\-?\d{0,3}(\.\d{0,2})?')),
                        // digits max 3 before point and max 2 after point. allow minus
                      ],
                      style: const TextStyle(
                          fontSize: size30, color: Colors.black),
                      decoration: const InputDecoration(
                          errorStyle:
                              TextStyle(fontSize: 20, color: Colors.black),
                          border: InputBorder.none,
                          labelText: "Percent",
                          labelStyle: TextStyle(
                              fontSize: size30,
                              fontWeight: FontWeight.w900,
                              color: Colors.black)),
                      validator: (inputValue) {
                        if (inputValue == null ||
                            inputValue.isEmpty ||
                            double.tryParse(inputValue) == null) {
                          return "Please enter Percent";
                        }
                        if (double.tryParse(inputValue) != null) {
                          percent = double.tryParse(inputValue) ?? 0;
                        } else {
                          Exception(
                              'addView.dart percent: ${double.tryParse(inputValue)} is null');
                        }
                        return null;
                      },
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: TextFormField(
                    initialValue: description,
                    maxLines: 7,
                    style:
                        const TextStyle(fontSize: size30, color: Colors.black),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: "Description",
                      labelStyle: TextStyle(
                          fontSize: size30,
                          fontWeight: FontWeight.w900,
                          color: Colors.black),
                    ),
                    validator: (inputValue) {
                      description = inputValue;
                      return null;
                    },
                  ),
                ),
                if (widget.type == AddUpdateViewType.addFactor ||
                    widget.type == AddUpdateViewType.updateFactor)
                  IconPicker(
                    initialIconIndex: iconIndex,
                    initialIconColorIndex: iconColorIndex,
                    function: (iconIndex, iconColorIndex) {
                      this.iconIndex = iconIndex;
                      this.iconColorIndex = iconColorIndex;
                    },
                  ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
