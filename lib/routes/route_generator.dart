import 'package:flutter/material.dart';
import 'package:safeharvest_frontend/features/fao/notifications/notification_screen.dart';
import 'package:safeharvest_frontend/features/fao/reports/report_screen.dart';
import 'package:safeharvest_frontend/features/farmers_and_food_processors/notifications/notification_screen.dart';
import 'package:safeharvest_frontend/features/inspectors/notifications/notification_screen.dart';
import 'package:safeharvest_frontend/features/inspectors/reports/report_screen.dart';

import '../data/models/checklist.dart';
import '../data/models/guideline.dart';
import '../data/models/inspection.dart';
import '../features/fao/checklists/add_checklist_screen.dart';
import '../features/fao/checklists/checklist_screen.dart';
import '../features/fao/checklists/update_checklist_screen.dart';
import '../features/fao/guidelines/add_guideline_screen.dart';
import '../features/fao/guidelines/guideline_screen.dart';
import '../features/fao/guidelines/update_guideline_screen.dart';
import '../features/fao/inspections/inspection_screen.dart';
import '../features/farmers_and_food_processors/guidelines/guideline_screen.dart';
import '../features/farmers_and_food_processors/inspections/inspection_screen.dart';
import '../features/farmers_and_food_processors/monitoring/monitoring_screen.dart';
import '../features/farmers_and_food_processors/traceability/create_traceability.dart';
import '../features/farmers_and_food_processors/traceability/traceability_screen.dart';
import '../features/inspectors/guidelines/guideline_screen.dart';
import '../features/inspectors/inspections/add_inspection_screen.dart';
import '../features/inspectors/inspections/inspection_screen.dart';
import '../features/inspectors/inspections/update_inspection_screen.dart';
import '../features/fao/main/main_screen.dart';
import '../features/farmers_and_food_processors/main/main_screen.dart';
import '../features/inspectors/main/main_screen.dart';
import '../features/authentication/screens/confirm_email_screen.dart';
import '../features/authentication/screens/not_found_screen.dart';
import '../features/authentication/screens/change_password_screen.dart';
import '../features/authentication/screens/login_screen.dart';
import '../features/authentication/screens/register_screen.dart';
import '../features/authentication/screens/reset_password_screen.dart';
import '../features/onboarding/screens/onboarding_screen.dart';
import '../features/splash/screens/splash_screen.dart';
import 'app_routes.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {

      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case AppRoutes.resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case AppRoutes.changePassword:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => ChangePasswordScreen(token: args),
          );
        }
        return _errorRoute();

      case AppRoutes.confirmEmail:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => ConfirmEmailScreen(token: args),
          );
        }
        return _errorRoute();

      case AppRoutes.adminDashboard:
        return MaterialPageRoute(builder: (_) => const AdminMainScreen());
      case AppRoutes.farmerDashboard:
        return MaterialPageRoute(builder: (_) => const FarmersAndFoodProcessorsMainScreen());
      case AppRoutes.inspectorDashboard:
        return MaterialPageRoute(builder: (_) => const InspectorMainScreen());
        //---------------------- GUIDELINES -----------------------
      case AppRoutes.adminGuidelineScreen:
        return MaterialPageRoute(builder: (_) => const AdminGuidelineScreen());
      case AppRoutes.inspectionGuidelineScreen:
        return MaterialPageRoute(builder: (_) => const InspectorGuidelineScreen());
      case AppRoutes.farmerGuidelineScreen:
        return MaterialPageRoute(builder: (_) => const FarmerGuidelineScreen());
      case AppRoutes.addGuideline:
        return MaterialPageRoute(builder: (_) => const AddGuidelineScreen());
      case AppRoutes.updateGuideline:
        if (args is Guideline) {
          return MaterialPageRoute(
            builder: (_) => UpdateGuidelineScreen(guideline: args),
          );
        }
        return _errorRoute();
      //---------------------- CHECKLISTS -----------------------
      case AppRoutes.checklistScreen:
        return MaterialPageRoute(builder: (_) => const ChecklistScreen());
      case AppRoutes.addChecklist:
        return MaterialPageRoute(builder: (_) => const AddChecklistScreen());
      case AppRoutes.updateChecklist:
        if (args is Checklist) {
          return MaterialPageRoute(
            builder: (_) => UpdateChecklistScreen(checklist: args),
          );
        }
        return _errorRoute();
      //---------------------- INSPECTIONS -----------------------
      case AppRoutes.adminInspectionScreen:
        return MaterialPageRoute(builder: (_) => const AdminInspectionScreen());
      case AppRoutes.farmerInspectionScreen:
        return MaterialPageRoute(builder: (_) => const FarmerInspectionScreen());
      case AppRoutes.inspectionScreen:
        return MaterialPageRoute(builder: (_) => const InspectionScreen());
      case AppRoutes.addInspection:
        return MaterialPageRoute(builder: (_) => const OnsiteInspectionScreen());
      case AppRoutes.updateInspection:
        if (args is Inspection) {
          return MaterialPageRoute(
            builder: (_) => UpdateInspectionScreen(inspection: args),
          );
        }
        return _errorRoute();
      //---------------------- NOTIFICATIONS -----------------------
      case AppRoutes.adminNotificationScreen:
        return MaterialPageRoute(builder: (_) => const AdminNotificationScreen());
      case AppRoutes.farmerNotificationScreen:
        return MaterialPageRoute(builder: (_) => const FarmerNotificationScreen());
      case AppRoutes.inspectorNotificationScreen:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      //---------------------- REPORTS -----------------------
      case AppRoutes.adminReportScreen:
        return MaterialPageRoute(builder: (_) => const AdminReportScreen());
      case AppRoutes.inspectionReportScreen:
        return MaterialPageRoute(builder: (_) => const ReportScreen());

      //---------------------- TRACEABILITY -----------------------
      case AppRoutes.farmerTraceabilityScreen:
        return MaterialPageRoute(builder: (_) => const TraceabilityScreen());
      case AppRoutes.addFarmerTraceabilityScreen:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => AddTraceabilityScreen(
                foodStatus: args
            ),
          );
        }
        return _errorRoute();
    //---------------------- MONITORING -----------------------
      case AppRoutes.farmerMonitoringScreen:
        return MaterialPageRoute(builder: (_) => const MonitoringScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const NotFoundScreen();
    });
  }
}


