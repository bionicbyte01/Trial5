import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'qrpage_model.dart';
export 'qrpage_model.dart';

class QrpageWidget extends StatefulWidget {
  const QrpageWidget({super.key});

  static String routeName = 'qrpage';
  static String routePath = '/qrpage';

  @override
  State<QrpageWidget> createState() => _QrpageWidgetState();
}

class _QrpageWidgetState extends State<QrpageWidget> {
  late QrpageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QrpageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).info,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).success,
          automaticallyImplyLeading: false,
          title: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Text(
              'Bionic QR Scanner',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Inter Tight',
                    color: Color(0xFF0800E7),
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                  ),
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 100.0, 0.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      await launchURL(_model.qrCodeOutput);
                    },
                    child: Text(
                      'QR Code Output',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            color: Color(0xFFC2DB16),
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    _model.qrCodeOutput =
                        await FlutterBarcodeScanner.scanBarcode(
                      '#C62828', // scanning line color
                      'Terminate!', // cancel button text
                      true, // whether to show the flash icon
                      ScanMode.QR,
                    );

                    safeSetState(() {});
                  },
                  child: Icon(
                    Icons.qr_code_scanner_rounded,
                    color: Color(0xFF19A7CB),
                    size: 190.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 35.0, 0.0, 0.0),
                child: Text(
                  'Click on QR Code 👆',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: Color(0xFFBF0ABD),
                        fontSize: 15.0,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 170.0, 0.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    final _localAuth = LocalAuthentication();
                    bool _isBiometricSupported =
                        await _localAuth.isDeviceSupported();
                    bool canCheckBiometrics =
                        await _localAuth.canCheckBiometrics;
                    if (_isBiometricSupported && canCheckBiometrics) {
                      try {
                        _model.faceorFingerprint = await _localAuth.authenticate(
                            localizedReason:
                                '~Biometrics Only!  to proceed to\n              BIONIC page! ~',
                            options: const AuthenticationOptions(
                                biometricOnly: true));
                      } on PlatformException {
                        _model.faceorFingerprint = false;
                      }
                      safeSetState(() {});
                    }

                    if (_model.faceorFingerprint) {
                      context.pushNamed(
                        BionicbyFluttergenWidget.routeName,
                        extra: <String, dynamic>{
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 1000),
                          ),
                        },
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Access to BIONIC page Denied !! ',
                            style: GoogleFonts.getFont(
                              'Lobster Two',
                              color: Color(0xFFFF0057),
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                          duration: Duration(milliseconds: 2750),
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondary,
                          action: SnackBarAction(
                            label: 'Retry verification?',
                            textColor: Color(0xFFEAA800),
                            onPressed: () async {
                              var confirmDialogResponse =
                                  await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('Retry verification ❔'),
                                            content: Text(
                                                'Wish continue to BIONIC Page ? 🤔'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: Text('No thanks.. 🚶'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, true),
                                                child: Text(_model
                                                    .faceorFingerprint
                                                    .toString()),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                      false;
                            },
                          ),
                        ),
                      );
                    }

                    safeSetState(() {});
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/fingerprint-scan_(1).gif',
                      width: 150.0,
                      height: 100.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(1.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 20.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      context.pushNamed(
                        OnboardingScreenPageWidget.routeName,
                        extra: <String, dynamic>{
                          kTransitionInfoKey: TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.topToBottom,
                            duration: Duration(milliseconds: 1000),
                          ),
                        },
                      );
                    },
                    child: Icon(
                      Icons.logout_rounded,
                      color: Color(0xFFFD0003),
                      size: 45.0,
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
