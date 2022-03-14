#ifndef CPARAMDATABASE_H
#define CPARAMDATABASE_H

#include <QObject>
#include "cdatabase.h"
class ParamDatabase : public Database
{
public:
    explicit ParamDatabase();

    explicit ParamDatabase(QString s);

    bool verify();//验证加密是否通过

};

#endif // CPARAMDATABASE_H
