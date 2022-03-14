#ifndef USERDB_H
#define USERDB_H

#include <QSqlQuery>
#include <cdatabase.h>
//#include <cuser.h>

enum Role{Undefined, Worker, SeniorWorker};

class UserDb: public Database
{

public:
    UserDb();
    UserDb(QString);
    Role verify(QString id, QString pw);

private:
    QString t = "users";
};

#endif // USERDB_H
