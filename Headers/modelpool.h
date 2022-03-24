#ifndef MODELPOOL_H
#define MODELPOOL_H

#include <QObject>
#include <cTmodel.h>
#include <cparamdatabase.h>

class ModelPool : public QObject
{
    Q_OBJECT
public:
    ModelPool();

    TModel* getModel(QString modelName);

    bool addModel(QString modelName, QSqlDatabase& pdb);

    bool deleteModel(QString modelName);

    bool checkModel();

    bool clearModel();

    bool initModel(QSqlDatabase& pdb);

    bool inPool(QString modelName);

    bool isDirty();

    void submit();

    void revert();
private:

    QHash<QString, TModel*> pool = QHash<QString, TModel*>();

};

#endif // MODELPOOL_H
