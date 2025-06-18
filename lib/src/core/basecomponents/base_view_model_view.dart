import 'package:flutter/material.dart';
import 'package:flutter_app/src/core/basecomponents/base_responsive_widget.dart';
import 'package:flutter_app/src/core/basecomponents/base_view_model.dart';
import 'package:flutter_app/src/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart';
import 'package:flutter_app/src/core/utils/helpers/extension_functions/size_extension.dart';
import 'package:flutter_app/src/core/utils/helpers/responsive_ui_helper/responsive_config.dart';
import 'package:provider/provider.dart';

class BaseViewModelView<T> extends StatefulWidget {
  const BaseViewModelView({
    super.key,
    this.onInitState,
    required this.buildWidget,
  });
  final void Function(T provider)? onInitState;
  final Widget Function(T provider) buildWidget;

  @override
  State<BaseViewModelView<T>> createState() => _BaseViewModelViewState<T>();
}

class _BaseViewModelViewState<T> extends State<BaseViewModelView<T>> {
  bool _showLoader = false;

  @override
  void initState() {
    super.initState();
    final T provider = Provider.of<T>(context, listen: false);
    toggleLoadingWidget(provider);
    if (widget.onInitState != null) {
      widget.onInitState!(provider);
    }
  }

  void toggleLoadingWidget(T provider) {
    (provider as BaseViewModel).toggleLoading.stream.listen((bool show) {
      if (!mounted) {
        return;
      }
      setState(() {
        _showLoader = show;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (BuildContext context, T provider, Widget? child) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            widget.buildWidget(provider),
            if (_showLoader)
              BaseResponsiveWidget(
                buildWidget: (BuildContext context,
                    ResponsiveUiConfig responsiveUiConfig,
                    AppConfigurations appConfigurations) {
                  return AnimatedOpacity(
                    opacity: 1,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      width: responsiveUiConfig.screenWidth,
                      height: responsiveUiConfig.screenHeight,
                      color: Colors.transparent,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: appConfigurations.appTheme.primaryColor,
                          ),
                          padding: EdgeInsets.all(
                            15.w,
                          ),
                          width: 70.w,
                          height: 70.w,
                          child: CircularProgressIndicator(
                            color:
                                appConfigurations.appTheme.backgroundLightColor,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }
}
