#include "cparamdatabase.h"

ParamDatabase::ParamDatabase()
    : Database()
{
}


ParamDatabase::ParamDatabase(QString s):Database(s)
{
}


// TODO: implement encryption
bool ParamDatabase::verify()
{
    return true;
}
