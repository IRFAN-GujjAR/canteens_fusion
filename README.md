# Canteens Fusion
Canteens Fusion is an app that allows canteen owners to register their canteens, They can set boundaries on Google Maps inside which customers can place orders. This project has complete signup, login, forgot password, email verification, phone number verification, profile picture upload, canteen info setup with Google Maps boundaries, in which customers can order.

**App ScreenShots**
                                  
<img src="screenshots/splash.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="screenshots/user_selection.png" width="217">
<br><br><br>
**Owner Onboarding**

<img src="screenshots/owner_onboarding_1.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="screenshots/owner_onboarding_2.png" width="217">
<br><br><br>
**Owner Login & Signup**

<img src="screenshots/owner_login.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="screenshots/owner_signup.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="screenshots/email_confirmation_1.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="screenshots/email_confirmation_2.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br><br><br><img src="screenshots/email_confirmation_3.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="screenshots/phone_number_send_otp.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="screenshots/phone_number_verify_otp.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="screenshots/complete_profile.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br><br><br><img src="screenshots/owner_canteen_info_1.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="screenshots/owner_canteen_info_2.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="screenshots/owner_canteen_info_3.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="screenshots/owner_canteen_info_4.png" width="217">
<br><br><br>
**Customer Login & Signup**

<img src="screenshots/customer_login.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="screenshots/customer_signup.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="screenshots/email_confirmation_1.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="screenshots/email_confirmation_2.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br><br><br><img src="screenshots/email_confirmation_3.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="screenshots/phone_number_send_otp.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="screenshots/phone_number_verify_otp.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="screenshots/complete_profile.png" width="217">
<br><br><br>
**Forgot Password**

<img src="screenshots/forgot_password_1.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="screenshots/forgot_password_2.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="screenshots/forgot_password_3.png" width="217">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="screenshots/forgot_password_4.png" width="217">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br><br><br><img src="screenshots/forgot_password_5.png" width="217">

***Technical Specs***
- Firebase Authentication (Email + Phone number)
- Cloud Firestore, Cloud Storage
- Google Maps for defining the canteen boundary

***Instructions to use this project***
- Create a Firebase project. Add Android(com.codewithirfan.canteens_fusion) and iOS(com.codewithirfan.canteens-fusion) packages.
- Add google-services.json and GoogleService-Info.plist to the project.
- Add Google Maps Api key to /android/app/src/main/AndroidManifest.xml and /ios/Runner/AppDelegate.swift
- Add Geocoding Api Key to .env as GEO_CODING_API_KEY variable.
