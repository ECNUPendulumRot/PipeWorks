#include <cdatabase.h>
#include <QDir>
#include <QDebug>
#include <QStringList>

Database::Database()
{
    this->status = false;
}


Database::Database(QString s)
{
    this->status = false;
    createConnection(s);
}


Database::~Database()
{
    db.close();
    this->status = false;
}


bool Database::createConnection(QString s)
{
    if(QSqlDatabase::isDriverAvailable("QSQLITE"))
         db = QSqlDatabase::addDatabase("QSQLITE");

    db.setDatabaseName(s);
    this->status = db.open();

    if (this->status){
        qDebug() << "connected";
        return true;
    }

    else
        return false;
}


bool Database::isConnected()
{
    return this->status;
}


QSqlDatabase& Database::getdb(){
    return this->db;
}

bool Database::closeDatabase()
{
    if(this->db.isOpen()){
        this->db.close();
        qDebug() << "closed";
        return true;
    }else{
        return false;
    }

}


