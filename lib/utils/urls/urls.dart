class Urls {
  static const String _baseUrl='http://35.73.30.144:2005/api/v1';
  static const String resgistration='$_baseUrl/Registration';
    static const String login='$_baseUrl/Login';
    static const String addNewTask='$_baseUrl/createTask';
   
 static const String newTaskList='$_baseUrl/listTaskByStatus/New';
 static const String canceledTaskList='$_baseUrl/listTaskByStatus/canceled';
static const String completedTaskList = '$_baseUrl/listTaskByStatus/Completed';
static const String taskStatusCount='$_baseUrl/taskStatusCount';
static const String updateProfile='$_baseUrl/profileUpdate';
static  String changeStatus(String taskId,String status) =>'$_baseUrl/updateTaskStatus/$taskId/$status';
static  String deleteTask(String taskId) =>'$_baseUrl/deleteTask/$taskId';
}
