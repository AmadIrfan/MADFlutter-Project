#MangasVerse

Problem Statement:
The purpose of this web application Project is that users can read the comics and novels. 
The platform provides users with the opportunity to search the comic and novels based 
different parameters like comics, novels, genre etc. 

Functional Requirements:
User registration & Authentication:
Users can register in the website with the fields name, email, date of birth, unique name, 
profile image (Optional) and password. After this a user authentication email will be 
sent to the user (a 6-digit verification code). After email verification user will be 
registered.

Roles:
There will be 4 roles in this project
•	User
•	Admin
•	Publisher
•	Staff

User Portal:
View Comics & Novels:
User should be able to view comics and novels, can read them. Comics/Novels will be in the form of pdf or docx. On homepage there are all of  the comic and novel. There will me multiple chapters for each comic and novel.
Updates:
Users should be able to view/read the recently publisher novels/comics. The recently uploaded 10 comics and novels (amount may vary means it not compulsory that 5 comics and 5 novels. Just 10 recent published comics or novels).
Search:
For the easement of the users, there will be a search feature on user can be able to search comics and novel in app.
User profile:
There will be a user profile for every user and user can view them. Either other users can view the profile of any user. But the user can only him/her self update profile. 
Reviews:
Users can give a review on specified novel. There will be “Leave a Review” section under every novel/comic where users can left review (1-5 rating and a review text). To show reviews show user image, user  name, review date & time and review text. When someone click on the username.  Only those users can left a review who have been registered to the website.

Universal unique identifier:
For every user, there will be a universal unique identifier (uuid) to manage the sessions on the website. After a day, user session will be expired and user will be logged out automatically.
Admin Portal:
Dashboard:
On the dashboard, Admin will be able to view the states that the how many users register the website in last 24 hours.
Manage Publishers and Staff:
Admin should be able to manage publishers and Staff like admin can add, delete or view publishers/Staff. At the time of add publisher, admin can fill the fields like publisher name, email, address and profile image. 
Manage Users:
Admin should also be able to manage the users of the website and manager have the access to view and inactive the users. 
Manage Comics & Novels:
Admin Should be able to manage the comic and novels that will be upload by publishers. Admin can view, accept or reject the publisher comic or novel and it depends on admins that the uploaded novel or comic will be published or not (if 3 admins accept the novel then it will be published otherwise not). Also admin can delete the novel or comic at any time and it will automatically removed from the user portal.
Admins:
There will be multiple admins at a time but only one super admin that will manage all the admins and only super admin can create new admins. 

Change Credentials:
users can change their account credentials by entering the previous password and new password if the previous password matched with the original password.
Email Sending:
Admin can send email to registered publishers, moderators and also users. 
Publisher Portal:
Manage Comics/Novels:
Publishers should be able to manage comics/novels means they can add/update/view/delete the comics/novels. At the time of adding novels/comics, publisher give comic/novel name, genre, category (either comic or novel), Summary, Published date. 
Manage Chapters:
Inside each comic or novel there will be multiple chapters. Publisher can add/delete/update and view the chapters. At the time of adding chapter, publisher will give the name of chapter like (Chapter # 1), publisher date and a file (either pdf or docx).
Stats & analytics:
Publisher should be able to overview stats and analytics that how many users, have read the comic or novels. How many reviews users have left. 
Staff Portal:

Manage Users:
Staff should be able to manage users, can, freeze user account for specific time or freeze account permanent.
Manage Books:
Staff should be able to manage Books. View available books.
Manage Reviews:
User can manage reviews, if someone has used vulgar language in reviews, staff can delete those reviews.
Non-Functional Requirements:
Security:
API must be secured with api_key, that no one access the api data without api_key so that the data will be secured.
Performance:
The website should load quickly and respond to user interactions promptly. 
Scalability:
It should seamlessly handle growth in the user base and content library without compromising performance.
User Experience:
The website should have an intuitive and user-friendly interface to enhance user engagement. 

