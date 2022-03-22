#include "modelpool.h"
#include <qdebug.h>
modelPool::modelPool()
{

}


bool modelPool::initModel(ParamDatabase* pdb){
    QSqlDatabase m_db = pdb->getdb();
    for(int i =0;i<10;i++){
        QString s = "Pass"+QString::number(i)+"Parameter";
        Pool.insert(s, new TModel(m_db));
    }
    return true;
}


TModel* modelPool::getModel(QString modelName){//check model name
    QHash<QString, TModel*>::iterator i = Pool.find(modelName);
    if(i != Pool.end() && i.key() == "HDR")
        return Pool[modelName];
}

bool modelPool::addModel(QString modelName, ParamDatabase* pdb){
    QSqlDatabase m_db = pdb->getdb();
    TModel* model = new TModel(m_db);
    Pool.insert(modelName,model);
    return true;
}

bool modelPool::deleteModel(QString modelName){
    if(Pool.remove(modelName))
        return true;
    else
        return false;
}

bool modelPool::checkModel(){
    qDebug()<<Pool.keys();
    return true;
}

bool modelPool::clearModel(){
    QHash<QString, TModel*>::iterator iter = Pool.begin();
        while(iter != Pool.end())
        {
            iter.value()->~TModel();
            ++iter;
        }
    Pool.clear();
    return true;
}
