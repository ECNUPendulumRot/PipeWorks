#include <cdatabase.h>
#include <QDir>
#include <QDebug>
#include <QStringList>

Database::Database()
{
    this->status = false;
}


Database::Database(QString filename, QString type, QString pw)
{
    this->status = false;
    createConnection(filename,type,pw);
}


Database::~Database()
{
    db.close();
    this->status = false;
}


bool Database::createConnection(QString filename, QString type, QString pw)
{
    if(QSqlDatabase::isDriverAvailable(type))
        db = QSqlDatabase::addDatabase(type, filename);

    db.setDatabaseName(filename);
    db.setPassword(pw);
    if(type == "SQLITECIPHER")
        db.setConnectOptions("QSQLITE_USE_CIPHER=sqlcipher");
    this->status = db.open();

    if (this->status){
        //qDebug() << "connected";
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
        //qDebug() << "closed";
        return true;
    }else{
        return false;
    }

}


