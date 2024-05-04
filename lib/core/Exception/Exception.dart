// Login Exception Error
// handle Error Login Service
class AppException {
  String code;
  String message;

  AppException({
    required this.code,
    required this.message
  });
}

AppException showException(status,message){
  String code = status.toString();
  switch(code){
    case '-1':
    return AppException(code: code, message: 'پسورد وارد شده نامعتبر است');
    case '-2':
    return AppException(code: code, message: 'دسترسی غیرمجاز');
    case '-3':
    return AppException(code: code, message: 'نام کاربری اشتباه است یا این نام کاربری در سایت وجود ندارد');
    case '-100':
    return AppException(code: code, message: 'خطای متفرقه');
    default:
    return AppException(code: code, message: 'خطای ناشناخته لطفا در ساعاتی دیگر تلاش فرمایید');
  }
} 