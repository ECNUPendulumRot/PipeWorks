#include "cmodelmanage.h"

#include <QDebug>

ModelManager::ModelManager()
{
    pm = nullptr;
    mPool = nullptr;
    for(int i = 0; i < indexToModel.size(); i++){
        indexToModel[i] = nullptr;
    }
}

ModelManager::ModelManager(ParamDatabase* pdb)
    : QObject()
{
    mdb = pdb->getdb();

    pm = nullptr;
    mPool = nullptr;
    for(int i = 0; i < indexToModel.size(); i++){
        indexToModel[i] = new TModel(mdb);
    }
}


ModelManager::ModelManager(QString role)
    : QObject()
{
    this->role = role;
    pm = nullptr;
    mPool = nullptr;
    for(int i = 0; i < indexToModel.size(); i++){
        indexToModel[i] = nullptr;
    }
}


void ModelManager::setModel(ParamDatabase* pdb)
{
    if(pm != nullptr){
        pm->clear();
        delete pm;
    }

    if(mPool != nullptr){
        mPool->clearModel();
        delete mPool;
        mPool = nullptr;
    }

    pm = new PartModel();
    mPool = new ModelPool();
    this->mdb = pdb->getdb();
    for(int i = 0; i < indexToModel.size(); i++){
        if(indexToModel[i] != nullptr)
            delete indexToModel[i];
        indexToModel[i] = new TModel(mdb);
        indexToModel[i]->setTable(tableNames[i]);
        indexToModel[i]->select();
    }
}


bool ModelManager::submit(){
    for(int i = 0; i < indexToModel.size(); i++){
        indexToModel[i]->submitAll();
    }
    mPool->submit();
    return true;
}


bool ModelManager::revert(){
    for(int i = 0; i < indexToModel.size(); i++){
        indexToModel[i]->revertAll();
    }
    mPool->revert();
    return true;
}

//QString ModelManager::MTruncate(unsigned int index, QList<unsigned int> cl){
//    QString s;
//    if(role == "W" && index < 3){
//        s = indexToModel[index]->truncate(cl);
//    }
//    else if(role == "SW" && index < indexToModel.size()){
//        s = indexToModel[index]->truncate(cl);
//     }
//    return s;
//}

bool ModelManager::setModelTable(unsigned int index, QString tableName){
    indexToModel[index]->setTable(tableName);
    indexToModel[index]->setEditStrategy(QSqlTableModel::OnManualSubmit);
    indexToModel[index]->select();
    return true;
}


TModel* ModelManager::getMTable(int index){
    if(index < indexToModel.size() && index >= 0){
        return indexToModel[index];
    }
    else
        return nullptr;
}

void ModelManager::callAngleTableInitialize()
{
    // maybe add new function in here
    emit registerRequestPartModel(this->pm, "angleRelatedTableModel");
}


void ModelManager::callFixedTablesInitialize()
{
    for(int i = 0; i < 5; i++){
        this->setModelTable(i,tableNames[i]);
        emit registerRequest(indexToModel[i], registerNames[i]);
    }
}


void ModelManager::clear()
{
    if(pm != nullptr)
        pm->clear();

    if(mPool != nullptr){
        mPool->clearModel();
        mPool = nullptr;
    }
    for(int i = 0; i < indexToModel.size(); i++){
        if(this->indexToModel[i] != nullptr){
            delete indexToModel[i];
            indexToModel[i] = nullptr;
        }
    }
}

bool ModelManager::addModelPool(QString modelName){
    //return mPool->addModel(modelName, pdb);
    if(this->mPool->inPool(modelName))
        return true;

    this->mPool->addModel(modelName, mdb);

    return true;
}

void ModelManager::changeSelectIndex(unsigned int index){
    //return mPool->truncate(cl);
    this->pm->changeSelectIndex(index);
}

bool ModelManager::isDirty()
{
    bool dirty = false;
    for(int i = 0; i < indexToModel.size(); i++){
        dirty = dirty || indexToModel[i]->isDirty();
    }
    dirty = dirty || mPool->isDirty();
    return dirty;
}

QVector<QString> *ModelManager::getTableQuery()
{
    return this->pm->getConnectedTable()->getTableQuery();
}

bool ModelManager::changePass(QString modelName){
    //mPool->setTable(modelName);
    //mPool->setEditStrategy(QSqlTableModel::OnManualSubmit);
    //mPool->select();
    TModel *curModel;
    if(!mPool->inPool(modelName))
        addModelPool(modelName);

    curModel = mPool->getModel(modelName);

    if(curModel == nullptr)
        qDebug() << "invalid model!";

    this->pm->changeBackendTable(curModel);
    return true;
}


void ModelManager::deleteModels()
{
    for(int i = 0; i < indexToModel.size(); i++){
        if(this->indexToModel[i] != nullptr){
            delete indexToModel[i];
            indexToModel[i] = nullptr;
        }
    }
    mPool->clearModel();
}
