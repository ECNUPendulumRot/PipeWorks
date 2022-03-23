#ifndef MODELPOOL_H
#define MODELPOOL_H

#include <QObject>
#include <cTmodel.h>
#include <cparamdatabase.h>
class modelPool : public QObject
{
    Q_OBJECT
public:
    modelPool();

    TModel* getModel(QString modelName);

    bool addModel(QString modelName, ParamDatabase* pdb);

    bool deleteModel(QString modelName);

    bool checkModel();

    bool clearModel();

    bool initModel(ParamDatabase* pdb);

private:

    static inline QHash<QString, TModel*> Pool =
        QHash<QString, TModel*>();

};

#endif // MODELPOOL_H
