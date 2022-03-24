#include "modelpool.h"
#include <qdebug.h>
ModelPool::ModelPool()
{

}


bool ModelPool::initModel(QSqlDatabase& pdb){
    for(int i =0;i<10;i++){
        QString s = "Pass"+QString::number(i)+"Parameter";
        pool.insert(s, new TModel(pdb));
    }
    return true;
}

bool ModelPool::inPool(QString modelName)
{
    QHash<QString, TModel*>::iterator i = pool.find(modelName);
    if(i != pool.end() && i.key() == modelName)
        return true;
    else
        return false;
}

bool ModelPool::isDirty()
{
    if(pool.size() == 0)
        return false;

    bool dirty = false;

    QHash<QString, TModel*>::iterator iter = pool.begin();
    while(iter != pool.end()){
        dirty = dirty || iter.value()->isDirty();
        ++iter;
    }
    return dirty;
}

void ModelPool::submit()
{
    QHash<QString, TModel*>::iterator iter = pool.begin();
    while(iter != pool.end()){
        iter.value()->callSubmit();
        ++iter;
    }
}


void ModelPool::revert()
{
    QHash<QString, TModel*>::iterator iter = pool.begin();
    while(iter != pool.end()){
        iter.value()->callRevert();
        ++iter;
    }
}


TModel* ModelPool::getModel(QString modelName){//check model name
    QHash<QString, TModel*>::iterator i = pool.find(modelName);
    if(i != pool.end() && i.key() == modelName)
        return pool[modelName];
    else
        return nullptr;
}

bool ModelPool::addModel(QString modelName, QSqlDatabase& pdb){
    TModel* model = new TModel(pdb);

    model->setTable(modelName);// the name should be same to the database table
    model->setEditStrategy(QSqlTableModel::OnManualSubmit);
    model->select();

    pool.insert(modelName,model);
    return true;
}

bool ModelPool::deleteModel(QString modelName){
    if(pool.remove(modelName))
        return true;
    else
        return false;
}

bool ModelPool::checkModel(){
    qDebug()<<pool.keys();
    return true;
}

bool ModelPool::clearModel(){
    QHash<QString, TModel*>::iterator iter = pool.begin();
    while(iter != pool.end()){
        delete iter.value();
        ++iter;
    }
    pool.clear();
    return true;
}
