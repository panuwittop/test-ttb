*** Variables ***
${URL}            http://the-internet.herokuapp.com/login
${REQRES_HOST}    https://reqres.in

##### API ####
##### Headers ####
${Content-Type}       application/json
${Accept-Language}    en

##### PATH ####
${PATH_USERS}              /api/users/12
${PATH_USERS_NOT_FOUND}    /api/users/1234

##### UI WEB ####
#### Element ID - Login Page #####
${input_username}          //*[@id="username"]
${input_password}          //*[@id="password"]
${btn_login}               //*[@id="login"]/button 
${btn_logout}              //*[@class="button secondary radius"]
${message_logged}          //*[@id="flash"]
${message_logged_error}    //*[@class="flash error"]


##### UI MOBLIE ####
##### Config ####
${REMOTE_URL}         http://127.0.0.1:4723/wd/hub
${platformName}       Android
${platformVersion}    9
${deviceName}         emulator-5554
${appPackage}         com.avjindersinghsekhon.minimaltodo
${appActivity}        com.example.avjindersinghsekhon.toodle.MainActivity

##### xpath ####
${icon_addnode}           addToDoItemFAB
${edit_note}              userToDoEditText
${buttonsave}             makeToDoFloatingActionButton
${view_title}             toDoListItemTextview
${remind_me}              toDoHasDateSwitchCompat
${seting_date}            newTodoDateEditText
${select_date}            //android.view.View[@content-desc="25 เมษายน 2024"]
${confirm_date}           ok
${menu}                   //android.widget.ImageView[@content-desc="ตัวเลือกเพิ่มเติม"]
${menu_seting}            title
${checbox_ningth_mode}    xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.ListView/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.CheckBox
${back_button}            //android.widget.ImageButton[@content-desc="นำทางขึ้น"]




