import 'package:mysql_app/models/user.dart';

const String hostUrl="https://mlggrand.ir/db";

const User userGuest=User(name: "guest", email: "email", pass: "123456",phoneNumber: "",level: 0);
const String kFavoriteHeader="https://mlggrand.ir/wp-content/uploads/2015/07/header-image.jpg";
const String kFavoriteHeader2="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSG_TB1R7WQQj3k8YOcqQ9zKnPYKfQyPMnj2w&usqp=CAU";


//use this command to build flutter web
//flutter build web --no-tree-shake-icons

//test the app link
//adb shell 'am start -W -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "https://mlggrand2.ir/payScreen?user_id=4235465&Authority=000000235235&Status=OK"'