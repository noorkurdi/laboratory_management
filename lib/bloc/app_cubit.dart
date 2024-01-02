import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project/bloc/app_states.dart';
import 'package:university_project/core/enums/connection_enum.dart';
import 'package:university_project/core/enums/loading_enum.dart';
import 'package:university_project/pages/admin_pages/employees_page/employees_page.dart';
import 'package:university_project/pages/admin_pages/expenses_page/expenses_page.dart';
import 'package:university_project/pages/admin_pages/home_page/home_page.dart';
import 'package:university_project/pages/admin_pages/revenues_page/revenues_page.dart';
import 'package:university_project/pages/doctor_pages/home_page/home_page_items/home_page.dart';
import 'package:university_project/pages/doctor_pages/home_page/result_page/result_page.dart';
import 'package:university_project/pages/employee_pages/expenses_page/expenses_page.dart';
import 'package:university_project/pages/employee_pages/home_page/home_page.dart';
import 'package:university_project/pages/employee_pages/orders_page/orders_page.dart';
import 'package:university_project/pages/employee_pages/result_page/result_page.dart';
import 'package:university_project/pages/logIn/login_page.dart';
import 'package:university_project/sql/db.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as intl;

class AppCubit extends Cubit<AppStates> {
  AppCubit({required this.sharedPreferences}) : super(InitialAppState());
  static AppCubit get(context) => BlocProvider.of(context);

  SharedPreferences sharedPreferences;

  ///controllers///
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController employeeNameController = TextEditingController();
  TextEditingController employeeAddressController = TextEditingController();
  TextEditingController employeePhoneController = TextEditingController();
  TextEditingController employeeSalaryController = TextEditingController();
  TextEditingController employeeTypeController = TextEditingController();
  TextEditingController employeeEmailController = TextEditingController();
  TextEditingController employeePasswpordController = TextEditingController();

  ///expenses//
  TextEditingController expensesDescriptionController = TextEditingController();
  TextEditingController expensesValueController = TextEditingController();
  TextEditingController expensesNameController = TextEditingController();
  TextEditingController expensesDateController = TextEditingController();

  ///tests///
  TextEditingController testNameController = TextEditingController();
  TextEditingController testTypeController = TextEditingController();
  TextEditingController testPriceController = TextEditingController();

  ///order///
  TextEditingController orderPatientNameController = TextEditingController();
  TextEditingController orderDateController = TextEditingController();
  TextEditingController orderPatientPhoneController = TextEditingController();
  TextEditingController orderPatientAgeController = TextEditingController();

  ///pilll///
  TextEditingController pillResultController = TextEditingController();

  ///variables///
  int currentIndexForAdminNavBar = 0;
  List adminsScreenList = [
    const AdminHomePage(),
    const AdminExpensesPage(),
    const AdminRevenuesPage(),
    const AdminEmployeesPage()
  ];
  int currentIndexForEmployeeNavBar = 0;
  List employeesScreenList = [
    const EmployeeHomePage(),
    const EmployeeExpensesPage(),
    const EmployeeOrdersPage(),
    const EmployeeResultPage()
  ];
  int currentIndexForDoctorNavBar = 0;
  List doctorsScreenList = [const DoctorHomePage(), const DoctorResultPage()];
  bool isLoggedin = false;
  late int whoLogged;
  dynamic currentUser;
  late int currentUserId;
  String currentUserName = '';
  List employeesList = [];
  List allExpensesList = [];
  List employeesExpensesList = [];
  List testsList = [];
  List<String> testsNamesList = [];
  List allOrdersList = [];
  List ordersWithoutResultList = [];
  List pillsList = [];
  List employeesTypes = ['موظف الاستقبال', 'طبيب', 'عامل'];
  late int employeeId;
  late int expenseIdForEdit;
  int employeeType = 3;
  bool isvisipleForAddEmp = false;
  bool isvisipleForEditEmp = false;
  List<bool> toggleBoolList = [false, false, false, false];
  dynamic userIdForEditEmployeeInAdminPage;
  int testType = 0;
  late int doctorIdForAddTest;
  List<String> doctorsNamesList = [];
  dynamic testId;
  dynamic testIdBeforConfirm;
  bool orderState = false;
  List<String> ordersTestsNames = [];
  List<String> pillsTestsNames = [];
//
  List expensesValuesbyDays = [];
  List pillsValuesbyDays = [];
  List expList = [];
  List pilList = [];
  Map<String, List> financialList = {};

//
  double thisMonthExpenses = 0;
  double thisMonthPills = 0;
  late int orderIdForEdit;
  String adminImg = 'assets/images/usersTypes/user-suit-male-svgrepo-com.svg';
  String doctorImg = 'assets/images/usersTypes/doctor-svgrepo-com.svg';
  String employeeImg =
      'assets/images/usersTypes/short-hair-nurse-svgrepo-com.svg';

  ///Enums///
  LoadingEnum loadingEnum = LoadingEnum.loaded;
  ConnectionEnum? loginConnEnum;

  ///db///
  SqlDb sqlDb = SqlDb();

  Future<void> initialEvent() async {
    await getAllEmployees();
    await getAllUsersql();
    await getAllExpenses();
    await getDoctors();
    await getAllTests();
    await getAllOrders();
    await getAllPills();
    await getFinancial();
    await getThisMonthExpenses();
    await getThisMonthPills();
    // sharedPreferences.remove('onBoarding');
    // print(sharedPreferences.getBool('onBoarding'));
    // await sharedPreferences.clear();
  }

  ///User sql operation///
  Future<List<Map>> getAllUsersql() async {
    String selectLine = "SELECT * FROM 'users'";
    List<Map<dynamic, dynamic>> response = await sqlDb.readData(selectLine);
    emit(RefreshUIAppState());
    return response;
  }

  Future<List<Map>> getOneUserByNameql(String name) async {
    String selectLine = "SELECT * FROM 'users' WHERE `name`='$name'";
    List<Map<dynamic, dynamic>> response = await sqlDb.readData(selectLine);
    emit(RefreshUIAppState());
    if (response.isNotEmpty) {
      employeeEmailController.text = response[0]['email'];
      employeePasswpordController.text = response[0]['password'];
      userIdForEditEmployeeInAdminPage = response[0]['id'];
      print(
          'userIdForEditEmployeeInAdminPage :$userIdForEditEmployeeInAdminPage');
    }
    // print(response);
    return response;
  }

  Future<List<Map>> getUserIdByEmployeeName(String name) async {
    String selectLine = "SELECT * FROM 'users' WHERE `name`='$name'";
    List<Map<dynamic, dynamic>> response = await sqlDb.readData(selectLine);
    emit(RefreshUIAppState());
    if (response.isNotEmpty) {
      userIdForEditEmployeeInAdminPage = response[0]['id'];
    }
    print(response);
    return response;
  }

  Future<List<Map>> getUserById(int id) async {
    String selectLine = "SELECT * FROM 'users' WHERE `id`='$id'";
    List<Map<dynamic, dynamic>> response = await sqlDb.readData(selectLine);
    emit(RefreshUIAppState());
    return response;
  }

  Future<int> editUserByIdForAdminSql(int id) async {
    String updateSql =
        "UPDATE `users` SET `name` = '${employeeNameController.text}', `email` = '${employeeEmailController.text}', `password` = '${employeePasswpordController.text}' WHERE `id` = '$id' ";
    int response = await sqlDb.updateData(updateSql);

    emit(RefreshUIAppState());
    return response;
  }

  Future<int> addUserSql() async {
    String insertLine =
        "INSERT INTO 'users' ('name','email','password','type') VALUES ('${employeeNameController.text}','${employeeEmailController.text}','${employeePasswpordController.text}','$employeeType')";
    int response = await sqlDb.insertData(insertLine);
    emit(RefreshUIAppState());
    return response;
  }

  Future<int> deleteUserSql({
    required int id,
  }) async {
    loadingEnum = LoadingEnum.loading;
    String deleteLine = "DELETE FROM `users` WHERE `id`='$id'";
    int response = await sqlDb.deleteData(deleteLine);
    emit(RefreshUIAppState());
    loadingEnum = LoadingEnum.loaded;
    return response;
  }

  void changeIndexForAdminNavBar(int index) {
    currentIndexForAdminNavBar = index;

    emit(RefreshUIAppState());
  }

  void changeIndexForDoctorNavBar(int index) {
    currentIndexForDoctorNavBar = index;

    emit(RefreshUIAppState());
  }

  void changeIndexForEmployeeNavBar(int index) {
    currentIndexForEmployeeNavBar = index;

    emit(RefreshUIAppState());
  }

  ///employees sql operation////
  Future<List<Map>> getAllEmployees() async {
    loadingEnum = LoadingEnum.loading;
    String selectLine = "SELECT * FROM employee WHERE id <> 1";
    List<Map<dynamic, dynamic>> response = await sqlDb.readData(selectLine);
    employeesList = response;
    emit(RefreshUIAppState());
    loadingEnum = LoadingEnum.loaded;
    return response;
  }

  Future<int> addNewEmployeeSql(
      {required String name,
      required String address,
      required String phone,
      required String salary}) async {
    String insertLine =
        "INSERT INTO 'employee' ('name','address','phone','type','salary') VALUES ('$name','$address','$phone','$employeeType','$salary')";
    int response = await sqlDb.insertData(insertLine);
    emit(RefreshUIAppState());
    return response;
  }

  Future<int> editEmployeeSql({
    required int id,
  }) async {
    String updateSql =
        "UPDATE `employee` SET `name` = '${employeeNameController.text}', `address` = '${employeeAddressController.text}', `phone` = '${employeePhoneController.text}', `salary` = '${employeeSalaryController.text}' WHERE `id` = '$id' ";
    int response = await sqlDb.updateData(updateSql);

    emit(RefreshUIAppState());
    return response;
  }

  Future<int> deleteEmployeeSql({
    required int id,
  }) async {
    loadingEnum = LoadingEnum.loading;
    String deleteLine = "DELETE FROM `employee` WHERE `id`='$id'";
    int response = await sqlDb.deleteData(deleteLine);
    emit(RefreshUIAppState());
    loadingEnum = LoadingEnum.loaded;
    return response;
  }

  ///expenses sql operation////
  Future<List<Map>> getAllExpenses() async {
    loadingEnum = LoadingEnum.loading;
    String selectLine = "SELECT * FROM 'expense' ORDER BY date DESC";
    List<Map<dynamic, dynamic>> response = await sqlDb.readData(selectLine);
    allExpensesList = response;
    emit(RefreshUIAppState());
    print('expenses: $response');
    loadingEnum = LoadingEnum.loaded;
    return response;
  }

  Future<List> employeeExpensesList(int id) async {
    employeesExpensesList.clear();
    for (var i = 0; i < allExpensesList.length; i++) {
      if (allExpensesList[i]['employee_id'] == id) {
        employeesExpensesList.add(allExpensesList[i]);
      }
    }
    return employeesExpensesList;
  }

  Future<int> addNewExpensesSql(
      {required String name,
      required String description,
      required int value,
      required var date,
      required int employeeId}) async {
    String insertLine =
        "INSERT INTO 'expense' ('name','description','value','date','employee_id') VALUES ('$name','$description','$value','$date','$employeeId')";
    int response = await sqlDb.insertData(insertLine);
    emit(RefreshUIAppState());
    return response;
  }

  Future<int> editExpensesSql({
    required int id,
  }) async {
    String updateSql =
        "UPDATE `expense` SET `name` ='${expensesNameController.text}',`description` ='${expensesDescriptionController.text}',`value` ='${expensesValueController.text}',`date` ='${expensesDateController.text}' WHERE `id`='$id' ";
    int response = await sqlDb.updateData(updateSql);

    emit(RefreshUIAppState());
    return response;
  }

  Future<int> deleteExpensesSql({
    required int id,
  }) async {
    loadingEnum = LoadingEnum.loading;
    String deleteLine = "DELETE FROM `expense` WHERE `id`='$id'";
    int response = await sqlDb.deleteData(deleteLine);
    emit(RefreshUIAppState());
    loadingEnum = LoadingEnum.loaded;
    return response;
  }

  ///test sql operation////
  Future<List<Map>> getAllTests() async {
    loadingEnum = LoadingEnum.loading;
    String selectLine = "SELECT * FROM 'tests'";
    List<Map<dynamic, dynamic>> response = await sqlDb.readData(selectLine);
    testsList = response;
    testsNamesList.clear();
    for (var i = 0; i < response.length; i++) {
      testsNamesList.add(response[i]['name']);
    }
    emit(RefreshUIAppState());
    loadingEnum = LoadingEnum.loaded;
    return response;
  }

  Future<int> addNewTestSql({
    required String name,
    required int type,
    required int price,
  }) async {
    String insertLine =
        "INSERT INTO 'tests' ('name','type','price') VALUES ('$name','$type','$price')";
    int response = await sqlDb.insertData(insertLine);
    emit(RefreshUIAppState());
    return response;
  }

  Future<int> editTestSql({
    required int id,
  }) async {
    String updateSql =
        "UPDATE `tests` SET `name` ='${testNameController.text}',`price` ='${testPriceController.text}',`type` ='$testType' WHERE `id`='$id' ";
    int response = await sqlDb.updateData(updateSql);

    emit(RefreshUIAppState());
    return response;
  }

  Future<int> deleteTestSql({
    required int id,
  }) async {
    loadingEnum = LoadingEnum.loading;
    String deleteLine = "DELETE FROM `tests` WHERE `id`='$id'";
    int response = await sqlDb.deleteData(deleteLine);
    emit(RefreshUIAppState());
    loadingEnum = LoadingEnum.loaded;
    return response;
  }

  ///order sql operation////
  Future<List<Map>> getAllOrders() async {
    loadingEnum = LoadingEnum.loading;
    String firstSelectLine = "SELECT * FROM `order` WHERE `state`='false'";
    List<Map<dynamic, dynamic>> orderWithoutResultResponse =
        await sqlDb.readData(firstSelectLine);
    print(orderWithoutResultResponse);
    ordersWithoutResultList = orderWithoutResultResponse;
    if (orderWithoutResultResponse.isNotEmpty) {
      await getTestNameById(orderWithoutResultResponse, 'orders');
    }
    String selectLine = "SELECT * FROM 'order'";
    List<Map<dynamic, dynamic>> response = await sqlDb.readData(selectLine);

    emit(RefreshUIAppState());
    loadingEnum = LoadingEnum.loaded;
    return response;
  }

  Future<void> getTestNameById(
      List<Map<dynamic, dynamic>> ordersOrPillsResponse, String forWhat) async {
    if (forWhat == 'orders') {
      ordersTestsNames.clear();
      for (var i = 0; i < ordersOrPillsResponse.length; i++) {
        String selectLine =
            "SELECT * FROM 'tests' WHERE `id`='${ordersOrPillsResponse[i]['test_id']}'";
        List<Map<dynamic, dynamic>> response = await sqlDb.readData(selectLine);
        ordersTestsNames.add(response[0]['name']);
      }
    } else if (forWhat == 'pills') {
      pillsTestsNames.clear();
      for (var i = 0; i < ordersOrPillsResponse.length; i++) {
        String selectLine =
            "SELECT * FROM 'tests' WHERE `id`='${ordersOrPillsResponse[i]['test_id']}'";
        List<Map<dynamic, dynamic>> response = await sqlDb.readData(selectLine);
        pillsTestsNames.add(response[0]['name']);
      }
    }
    emit(RefreshUIAppState());
  }

  Future<void> getTestIdByName(String name) async {
    loadingEnum = LoadingEnum.loading;
    String selectLine = "SELECT * FROM 'tests' WHERE `name`='$name'";
    List<Map<dynamic, dynamic>> response = await sqlDb.readData(selectLine);
    testIdBeforConfirm = response[0]['id'];
    testId = response[0]['id'];
    emit(RefreshUIAppState());
    loadingEnum = LoadingEnum.loaded;
  }



  Future<int> addNewOrderSql({
    required String patientName,

    required String patientPhone,
  
    required int patientAge,
 
  }) async {

    var date = intl.DateFormat('yyyy-MM-dd').format(DateTime.now());
    orderState = false;
    String insertLine =
        "INSERT INTO 'order' ('patient_name','date','patient_phone','state','patient_age','test_id','employee_id') VALUES ('$patientName','$date','$patientPhone','$orderState','$patientAge','$testId','$currentUserId')";
    int response = await sqlDb.insertData(insertLine);
    emit(RefreshUIAppState());
    return response;
  }

  Future<int> editOrderSql({
    required int id,
  }) async {
    String updateSql =
        "UPDATE `order` SET `patient_name` ='${orderPatientNameController.text}',`patient_phone` ='${orderPatientPhoneController.text}',`patient_age` ='${orderPatientAgeController.text}',`test_id` ='$testId' WHERE `id`='$id' ";
    int response = await sqlDb.updateData(updateSql);

    emit(RefreshUIAppState());
    return response;
  }

  Future<int> deleteOrderSql({
    required int id,
  }) async {
    loadingEnum = LoadingEnum.loading;
    String deleteLine = "DELETE FROM `order` WHERE `id`='$id'";
    int response = await sqlDb.deleteData(deleteLine);
    emit(RefreshUIAppState());
    loadingEnum = LoadingEnum.loaded;
    return response;
  }

  ///pill sql operation////
  Future<List<Map>> getAllPills() async {
    loadingEnum = LoadingEnum.loading;
    String selectLine = "SELECT * FROM 'pills' ORDER BY date DESC";
    List<Map<dynamic, dynamic>> response = await sqlDb.readData(selectLine);
    print('pills $response');
    if (response.isNotEmpty) {
      await getTestNameById(response, 'pills');
    }
    pillsList = response;
    emit(RefreshUIAppState());
    loadingEnum = LoadingEnum.loaded;
    return response;
  }

  Future<int> addNewPillSql({
    required int index,
  }) async {
    String selectLine =
        "SELECT * FROM 'tests' WHERE `id`='${ordersWithoutResultList[index]['test_id']}'";
    List<Map<dynamic, dynamic>> testResponse = await sqlDb.readData(selectLine);
    var date = intl.DateFormat('yyyy-MM-dd').format(DateTime.now());
    String insertLine =
        "INSERT INTO 'pills' ('value','patient_name','result','date','order_id','test_id','employee_id') VALUES ('${testResponse[0]['price']}','${ordersWithoutResultList[index]['patient_name']}','${pillResultController.text}','$date','${ordersWithoutResultList[index]['id']}','${ordersWithoutResultList[index]['test_id']}','$currentUserId')";
    int response = await sqlDb.insertData(insertLine);
    String updateSql =
        "UPDATE `order` SET `state` ='true' WHERE `id`='${ordersWithoutResultList[index]['id']}' ";
    int updateOrderResponse = await sqlDb.updateData(updateSql);
    emit(RefreshUIAppState());
    return response;
  }

  Future<int> editPillSql({
    required int id,
    required TextEditingController controller,
    required String whatEditing,
  }) async {
    String fieldEditing = controller.text;
    String updateSql =
        "UPDATE `pills` SET `$whatEditing` ='$fieldEditing' WHERE `id`='$id' ";
    int response = await sqlDb.updateData(updateSql);

    emit(RefreshUIAppState());
    return response;
  }

  Future<int> deletePillSql({
    required int id,
  }) async {
    loadingEnum = LoadingEnum.loading;
    String deleteLine = "DELETE FROM `pills` WHERE `id`='$id'";
    int response = await sqlDb.deleteData(deleteLine);
    emit(RefreshUIAppState());
    loadingEnum = LoadingEnum.loaded;
    return response;
  }

  //////////
  ///
  Future<void> getThisMonthExpenses() async {
    var nowDate = DateTime.now();
    thisMonthExpenses = 0;
    for (var i = 0; i < allExpensesList.length; i++) {
      var date = DateTime.parse(allExpensesList[i]['date']);
      if (date.month == nowDate.month) {
        thisMonthExpenses += allExpensesList[i]['value'];
      }
    }
    emit(RefreshUIAppState());
  }

  Future<void> getThisMonthPills() async {
    thisMonthPills = 0;
    var nowDate = DateTime.now();
    for (var i = 0; i < pillsList.length; i++) {
      var date = DateTime.parse(pillsList[i]['date']);
      if (date.month == nowDate.month) {
        thisMonthPills += pillsList[i]['value'];
      }
    }
  }

  Future<void> expensesValuesDays(List allDates) async {
    expensesValuesbyDays.clear();

    for (var i = 0; i < allDates.length; i++) {
      double s = 0;
      for (var j = 0; j < allExpensesList.length; j++) {
        if (allExpensesList[j]['date'] == allDates[i]) {
          s = s + allExpensesList[j]['value'];
        }
      }
      expensesValuesbyDays.add([s, allDates[i]]);
    }
  }

  Future<void> pillsValuesDays(List allDates) async {
    pillsValuesbyDays.clear();

    for (var i = 0; i < allDates.length; i++) {
      double s = 0;
      for (var j = 0; j < pillsList.length; j++) {
        if (pillsList[j]['date'] == allDates[i]) {
          s = s + pillsList[j]['value'];
        }
      }
      pillsValuesbyDays.add([s, allDates[i]]);
    }
  }

  Future<void> getFinancial() async {
    expList.clear();
    pilList.clear();
    List<dynamic> allDates = [];
    Set<dynamic> datesSet = {};

    for (var expense in allExpensesList) {
      datesSet.add(expense['date']);
    }
    for (var pill in pillsList) {
      datesSet.add(pill['date']);
    }
    allDates = datesSet.toList();
    allDates.sort((a, b) => a.compareTo(b));
    // print(allDates);

    bool aded = false;
    financialList.clear();
    financialList['dates'] = allDates;
    await pillsValuesDays(allDates);
    await expensesValuesDays(allDates);

    for (var i = 0; i < allDates.length; i++) {
      aded = false;
      for (var j = 0; j < expensesValuesbyDays.length; j++) {
        if (expensesValuesbyDays[j][1] == allDates[i]) {
          expList.add(expensesValuesbyDays[j][0]);
          aded = true;
        }
      }
      if (aded == false) {
        expList.add('null');
      }
    }
    for (var i = 0; i < allDates.length; i++) {
      aded = false;
      for (var j = 0; j < pillsValuesbyDays.length; j++) {
        if (pillsValuesbyDays[j][1] == allDates[i]) {
          pilList.add(pillsValuesbyDays[j][0]);
          aded = true;
        }
      }
      if (aded == false) {
        pilList.add('null');
      }
    }
    financialList['expenses'] = expList;
    financialList['pills'] = pilList;
    // print(expList);
    // print(pilList);
    // print('\n result:::::::\n $financialList');
    emit(RefreshUIAppState());
  }

  Future<void> clearEvent({
    required List<TextEditingController> controller,
  }) async {
    for (int i = 0; i < controller.length; i++) {
      controller[i].clear();
    }
  }

  bool checkEmpty({
    required List<TextEditingController> controller,
  }) {
    for (int i = 0; i < controller.length; i++) {
      if (controller[i].text == "") {
        return false;
      }
    }
    return true;
  }

  void toggleEmpType(int index) {
    for (var i = 0; i < toggleBoolList.length; i++) {
      if (i == index) {
        toggleBoolList[i] = true;
      } else {
        toggleBoolList[i] = false;
      }
    }
    emit(RefreshUIAppState());
  }

  void boolForAddVisipilyt() {
    if (employeeType == 0 || employeeType == 1 || employeeType == 2) {
      isvisipleForAddEmp = true;
    } else {
      isvisipleForAddEmp = false;
    }
    emit(RefreshUIAppState());
  }

  Future<void> boolForEditVisipilyt() async {
    if (employeeTypeController.text == '0' ||
        employeeTypeController.text == '1' ||
        employeeTypeController.text == '2') {
      isvisipleForEditEmp = true;
    } else {
      isvisipleForEditEmp = false;
    }

    emit(RefreshUIAppState());
  }

  Future<List<Map>> getDoctors() async {
    loadingEnum = LoadingEnum.loading;
    String selectLine = "SELECT * FROM 'employee' WHERE `type`=1";
    List<Map<dynamic, dynamic>> response = await sqlDb.readData(selectLine);
    for (var i = 0; i < response.length; i++) {
      doctorsNamesList.add(response[i]['name']);
    }
    emit(RefreshUIAppState());
    loadingEnum = LoadingEnum.loaded;
    return response;
  }

  Future<void> getDoctorIdByName(String name) async {
    loadingEnum = LoadingEnum.loading;
    String selectLine = "SELECT * FROM 'employee' WHERE `name`='$name'";
    List<Map<dynamic, dynamic>> response = await sqlDb.readData(selectLine);
    doctorIdForAddTest = response[0]['id'];
    emit(RefreshUIAppState());
    print(doctorIdForAddTest);
    loadingEnum = LoadingEnum.loaded;
  }

  String getUserPhoto(int type) {
    if (type == 0) {
      return adminImg;
    } else if (type == 1) {
      return doctorImg;
    } else {
      return employeeImg;
    }
  }

  Future<int> loginEvent() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String selectLine =
        "SELECT * FROM `users` WHERE `email`='${loginEmailController.text}' AND `password`='${loginPasswordController.text}'";
    List<Map<dynamic, dynamic>> response = await sqlDb.readData(selectLine);
    emit(RefreshUIAppState());
    if (response.isNotEmpty) {
      isLoggedin = true;
      print('islogged $isLoggedin');
      await sharedPreferences.setBool('isloggedin', isLoggedin);
      whoLogged = response[0]['type'];
      print('whologged $whoLogged');

      await sharedPreferences.setInt('whoLogged', whoLogged);
      currentUser = response.first;
      currentUserId = response[0]['id'];
      print('currentUserId::::$currentUserId');
      await sharedPreferences.setInt('currentUserId', currentUserId);
      currentUserName = response[0]['name'];
      print('currentUserName::::$currentUserName');
      await sharedPreferences.setString('currentUserName', currentUserName);

      return response[0]['type'];
    }
    return 4;
  }

  Future<void> logOut() async {
    await sharedPreferences.remove('isloggedin');
    await sharedPreferences.remove('whoLogged');
    // await sharedPreferences.clear();
    isLoggedin = false;
  }

  rememberUser({
    required Widget login,
    required Widget admin,
    required Widget doctor,
    required Widget employee,
    required Widget onBoarding,
  }) {
    if (sharedPreferences.getBool('isloggedin') == true &&
        sharedPreferences.getBool('onBoarding') != null) {
      currentUserId = sharedPreferences.getInt('currentUserId')!;
      whoLogged = sharedPreferences.getInt('whoLogged')!;
      currentUserName = sharedPreferences.getString('currentUserName')!;
      print('currentUserId:::::$currentUserId');
      print('currentUserName :::$currentUserName');
      if (sharedPreferences.getInt('whoLogged') == 0) {
        return admin;
      } else if (sharedPreferences.getInt('whoLogged') == 1) {
        return doctor;
      } else if (sharedPreferences.getInt('whoLogged') == 2) {
        int? userId = sharedPreferences.getInt('currentUserId');
        employeeExpensesList(userId!);
        return employee;
      }
    } else if (sharedPreferences.getBool('onBoarding') != null) {
      return login;
    } else {
      return onBoarding;
    }
    // return login;
  }

  // Widget onBoarding() {
  //   if (sharedPreferences.getBool('onBoarding') == null) {
  //     sharedPreferences.setBool('onBoarding', true);

  //     return const OnBoarding();
  //   } else {
  //     return rememberUser(
  //         login: LogInPage(),
  //         admin: const AdminHomePage(),
  //         doctor: const DoctorHomePage(),
  //         employee: const EmployeeHomePage());
  //   }
  // }

  Widget mainPage() {
    if (isLoggedin) {
      if (whoLogged == 0) {
        return const AdminHomePage();
      } else if (whoLogged == 1) {
        return const DoctorHomePage();
      } else if (whoLogged == 2) {
        return const EmployeeHomePage();
      }
    }
    return LogInPage();
  }
}
