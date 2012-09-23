What is MVC?
============
Sifo separates the code using the Model-view-controller (MVC) design pattern. This means that when you start coding your application
there will be by default 3 places where you will store files.

* The **models** are files that provide only data. They connect to the database or source and return the content.
* The **views** is the HTML that will be printed
* The **controllers** are the files that process the user request and decide what HTML will be printed, and where to take the data from.

The framework separates these 3 parts so the application isolates problems and the code remains well organized and reusable. This
files are stored inside your own `instance`.