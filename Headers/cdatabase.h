#ifndef CDATABASE_H
#define CDATABASE_H

#include <QObject>
#include <QSqlDatabase>

class Database : public QObject
{
    Q_OBJECT
public:

    // Constructor
    Database();
    Database(QString s);

    // Destructor
    ~Database();

    bool createConnection(QString s);
    bool isConnected();

    QSqlDatabase& getdb();

    bool closeDatabase();

protected:

    QSqlDatabase db;
    bool status;
};

#endif // CDATABASE_H
