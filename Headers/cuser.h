#ifndef USER_H
#define USER_H

#include <QObject>
#include <cuserdb.h>

enum Status{AuthWaiting, AuthSuccess};

class User : public QObject
{
    Q_OBJECT

private:

    QString id;// ID of the user
    QString pw;// Password of the user
    Status status;// whether the user login
    Role role;

public:
    explicit User(QObject *parent = nullptr);

    User(QString id, QString pw);

    void login(UserDb*);

    void clear();

    Status getStatus();

    void setPw(const QString &newPw);

    void setId(const QString &newId);

    Role getRole() const;
};

#endif // USER_H
