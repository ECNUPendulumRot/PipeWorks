#include <cuser.h>
#include <cuserdb.h>


User::User(QObject *parent)
    : QObject{parent}
{
    this->status = AuthWaiting;
    this->role = Undefined;
}

User::User(QString id, QString pw)
{
    this->id = id;
    this->pw = pw;
}


void User::login(UserDb *udb)
{
    this->role = udb->verify(this->id, this->pw);
    if(role == Undefined) status = AuthWaiting;
    else status = AuthSuccess;
}


void User::clear()
{
    this->id.clear();
    this->pw.clear();
    this->role = Undefined;
    this->status = AuthWaiting;
}


void User::setPw(const QString &newPw)
{
    this->pw = newPw;
}


void User::setId(const QString &newId)
{
    id = newId;
}


Status User::getStatus()
{
    return this->status;
}


Role User::getRole() const
{
    return role;
}

