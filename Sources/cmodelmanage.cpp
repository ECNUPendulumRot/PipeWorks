#include "cmodelmanage.h"

#include <QDebug>

ModelManage::ModelManage()
{
    pm = nullptr;
    mPool = nullptr;
    for(int i = 0; i < indexToModel.size(); i++){
        indexToModel[i] = nullptr;
    }
}

ModelManage::ModelManage(ParamDatabase* pdb)
    : QObject()
{
    mdb = pdb->getdb();

    pm = new PartModel(?);
    mPool = new ModelPool(mdb);
    for(int i = 0; i < indexToModel.size(); i++){
        indexToModel[i] = new TModel(mdb);
    }
}


ModelManage::ModelManage(QString role)
    : QObject()
{
    this->role = role;

    pm = nullptr;
    mPool = nullptr;
    for(int i = 0; i < indexToModel.size(); i++){
        indexToModel[i] = nullptr;
    }
}

void ModelManage::setModel(ParamDatabase* pdb)
{
    if(pm != nullptr)
        delete pm;
    pm = new PartModel(?);
    if(mPool != nullptr)
        delete mPool;
    mPool = new ModelPool(pdb->getdb());
    for(int i = 0; i < indexToModel.size(); i++){
        if(indexToModel[i] != nullptr)
            delete indexToModel[i];
        indexToModel[i] = new TModel(pdb->getdb());
    }
}



bool ModelManage::Submit(){
    if(role == "W"){
        for(int i = 0; i < 3; i++)
            indexToModel[i]->callSubmit();
        //mPool->callSubmit();
        return true;
    }
    else if(role =="SW"){
        for(int i = 0; i < indexToModel.size(); i++)
            indexToModel[i]->callSubmit();
        //mPool->callSubmit();
        return true;
    }
    else
        return false;
}

bool ModelManage::Rvert(){
    if(role == "W"){
        for(int i = 0; i < 3; i++)
            indexToModel[i]->callRevert();
        //mPool->callRevert();
        return true;
    }
    else if(role =="SW"){
        for(int i = 0; i < indexToModel.size(); i++)
            indexToModel[i]->callRevert();
        //mPool->callRevert();
        return true;
    }
    else
        return false;
}

bool ModelManage::addModelPool(ParamDatabase *pdb, QString modelName){
    //return mPool->addModel(modelName, pdb);
}

QString ModelManage::changeSelectIndex(QList<unsigned int> cl){
    //return mPool->truncate(cl);
}

QString ModelManage::MTruncate(unsigned int index, QList<unsigned int> cl){
    QString s;
    if(role == "W" && index < 3){
        s = indexToModel[index]->truncate(cl);
    }
    else if(role == "SW" && index < indexToModel.size()){
        s = indexToModel[index]->truncate(cl);
     }
    return s;
}

bool ModelManage::changePass(QString modelName){
    //mPool->setTable(modelName);
    //mPool->setEditStrategy(QSqlTableModel::OnManualSubmit);
    //mPool->select();
    return true;
}

bool ModelManage::setModelTable(unsigned int index, QString tableName){
    indexToModel[index]->setTable(tableName);
    indexToModel[index]->setEditStrategy(QSqlTableModel::OnManualSubmit);
    indexToModel[index]->select();
    return true;
}


TModel* ModelManage::getMTable(unsigned int index){
    if(index < indexToModel.size() && index >= 0){
        return indexToModel[index];
    }
    else
        return nullptr;
}

void ModelManage::callAngleTableInitialize()
{
    // maybe add new function in here
    emit registerRequestPool(mPool, "angleRelatedTableModel");
}

void ModelManage::callFixedTablesInitialize()
{
    this->setModelTable(0, "Pass");
    emit registerRequest(indexToModel[0], "passFTableModel");

    this->setModelTable(1, "SystemParameter");
    emit registerRequest(indexToModel[1], "systemFTableModel");

    this->setModelTable(2, "MotionJog");
    emit registerRequest(indexToModel[2], "motionFTableModel");

    this->setModelTable(3, "ControlParameter");
    emit registerRequest(indexToModel[3], "controlFTableModel");

    this->setModelTable(4, "CommunicationParameter");
    emit registerRequest(indexToModel[4], "comFTableModel");
}

void ModelManage::Clear()
{
    if(pm != nullptr){
        delete pm;
        pm = nullptr;
    }
    if(mPool != nullptr){
        delete mPool;
        mPool = nullptr;
    }
    for(int i = 0; i < indexToModel.size(); i++){
        if(this->indexToModel[i] != nullptr){
            delete indexToModel[i];
            indexToModel[i] = nullptr;
        }
    }
}

void ModelManage::deleteModels()
{
    for(int i = 0; i < indexToModel.size(); i++){
        if(this->indexToModel[i] != nullptr){
            delete indexToModel[i];
            indexToModel[i] = nullptr;
        }
    }
}
