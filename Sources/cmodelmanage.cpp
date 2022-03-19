#include "cmodelmanage.h"

#include <QDebug>
ModelManage::ModelManage()
{
    for(int i = 0; i < indexToTModel.size(); i++){
        indexToTModel[i] = nullptr;
    }
}

ModelManage::ModelManage(ParamDatabase* pdb)
    : QObject()
{
    mdb = pdb->getdb();
    for(int i = 0; i < indexToTModel.size(); i++){
        indexToTModel[i] = new TModel(mdb);
    }
}


ModelManage::ModelManage(QString role)
    : QObject()
{
    this->role = role;
    for(int i = 0; i < indexToTModel.size(); i++){
        indexToTModel[i] = nullptr;
    }
}


bool ModelManage::Submit(){
    if(role == "W"){
        for(int i = 0; i < 5; i++)
            indexToTModel[i]->callSubmit();
        return true;
    }
    else if(role =="SW"){
        for(int i = 0; i < indexToTModel.size(); i++)
            indexToTModel[i]->callSubmit();
        return true;
    }
    else
        return false;
}

bool ModelManage::Rvert(){
    if(role == "W"){
        for(int i = 0; i < 5; i++)
            indexToTModel[i]->callRevert();
        return true;
    }
    else if(role =="SW"){
        for(int i = 0; i < indexToTModel.size(); i++)
            indexToTModel[i]->callRevert();
        return true;
    }
    else
        return false;
}


QString ModelManage::MTruncate(unsigned int index, QList<unsigned int> cl){
    QString s;
    if(role == "W" && index < 5){
        s = indexToTModel[index]->truncate(cl);
    }
    else if(role == "SW" && index < indexToTModel.size()){
        s = indexToTModel[index]->truncate(cl);
     }
    return s;
}


void ModelManage::setModel(ParamDatabase* pdb)
{
    for(int i = 0; i < indexToTModel.size(); i++){
        if(indexToTModel[i] != nullptr)
            delete indexToTModel[i];
        indexToTModel[i] = new TModel(pdb->getdb());
    }
}

bool ModelManage::setModelTable(unsigned int index, QString tableName){
    indexToTModel[index]->setTable(tableName);
    indexToTModel[index]->setEditStrategy(QSqlTableModel::OnManualSubmit);
    indexToTModel[index]->select();
    return true;
}


TModel* ModelManage::getMTable(unsigned int index){
    if(index < indexToTModel.size() && index >= 0){
        return indexToTModel[index];
    }
    else
        return nullptr;
}

void ModelManage::callAngleTableInitialize()
{
    // maybe add new function in here
    //emit registerRequest(indexToTModel[2], "angleRelatedTableModel");
}

void ModelManage::callFixedTablesInitialize()
{
    this->setModelTable(0, "Pass");
    emit registerRequest(indexToTModel[0], "passFTableModel");

    this->setModelTable(1, "SystemParameter");
    emit registerRequest(indexToTModel[1], "systemFTableModel");

    this->setModelTable(2, "MotionJog");
    emit registerRequest(indexToTModel[2], "motionFTableModel");

    this->setModelTable(3, "ControlParameter");
    emit registerRequest(indexToTModel[3], "controlFTableModel");

    this->setModelTable(4, "CommunicationParameter");
    emit registerRequest(indexToTModel[4], "comFTableModel");
}


void ModelManage::deleteModels()
{
    for(int i = 0; i < indexToTModel.size(); i++){
        if(this->indexToTModel[i] != nullptr){
            delete indexToTModel[i];
            indexToTModel[i] = nullptr;
        }
    }
}
