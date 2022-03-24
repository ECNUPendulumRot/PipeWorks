#include <cuserdb.h>
#include <QVariant>
UserDb::UserDb():Database()
{

}


UserDb::UserDb(QString s):Database(s)
{

}


Role UserDb::verify(QString id, QString pw)
{
    QSqlQuery q = this->db.exec("select password, role from " + this->t + \
                                " where id=" + id + ";");
    q.first();
    Role r = Undefined;
    if(q.isValid() && q.value("password").toString() == pw)
        r = q.value("role").toString() == "SW" ? SeniorWorker : Worker;
    return r;
}


//informationUpdate(QString id, QString opw, QString npw);
bool UserDb::informationUpdate(QString id, QString opw, QString npw){

    if(verify(id, opw)!=Undefined){
        QSqlQuery q;
        q.prepare("update "+this->t+" set password= :npw where id = :id");
        q.bindValue(":npw",npw);
        q.bindValue(":id",id);
        q.exec();

        return true;
    }
    else
        return false;
}
