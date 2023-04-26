All done!
You can find general documentation for Flutter at: https://docs.flutter.dev/
Detailed API documentation is available at: https://api.flutter.dev/
If you prefer video documentation, consider: https://www.youtube.com/c/flutterdev

In order to run your application, type:

  $ cd .
  $ flutter run

Your application code is in .\lib\main.dart.


Cleaning up


====================
SERVERPOD CREATED :D
====================

All setup. You are ready to rock!

Start your Serverpod by running:

  $ cd .\rrr\rrr_server\
  $ .\setup-tables.cmd // not created the first time
  $ .\setup-tables.cmd //  CREATE INDEX CREATE TABLE - means the table has been created
  $ docker compose up --build --detach  // something like start with reboot
  $ dart .\bin\main.dart // run server


## ERRORE 1
SERVERPOD version: 1.1.0, dart: 2.19.5 (stable) (Mon Mar 20 17:09:37 2023 +0000) on "windows_x64", time: 2023-04-25 21:11:53.988464Z
mode: development, role: monolith, logging: normal, serverId: default
Failed to connect to the database. Retrying in 10 seconds. PostgreSQLSeverity.error 42P01: relation "serverpod_runtime_settings" does not exist 
Database configuration:
database host: localhost
database port: 8090
database name: rrr
database user: postgres
database require SSL: false
database unix socket: false
database pass: ********

Failed to connect to the database. Retrying in 10 seconds. PostgreSQLSeverity.error 42P01: relation "serverpod_runtime_settings" does not exist 
Failed to connect to the database. Retrying in 10 seconds. PostgreSQLSeverity.error 42P01: relation "serverpod_runtime_settings" does not exist 


## Fix Errore 1
delete in file protocol/example.yaml table:example line


