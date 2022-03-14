#include "cmodelmanage.h"

ModelManage::ModelManage()
{
    for(int i=0;i < 6;i++){
        MTable[i] = nullptr;
    }
}

ModelManage::ModelManage(ParamDatabase* pdb)
    : QObject()
{
    mdb = pdb->getdb();
    for(int i=0;i < 6;i++){
        MTable[i] = new TModel(mdb);
    }
}


ModelManage::ModelManage(QString role)
    : QObject()
{
    this->role = role;
    for(int i=0;i<6;i++){
        MTable[i] = nullptr;
    }
}


bool ModelManage::Submit(){
    if(role == "W"){
        for(int i=0;i<3;i++)
            MTable[i]->callSubmit();
        return true;
    }
    else if(role =="SW"){
        for(int i=0;i<6;i++)
            MTable[i]->callSubmit();
        return true;
    }
        else
            return false;
}

bool ModelManage::Rvert(){
    if(role == "W"){
        for(int i=0; i< 3;i++)
            MTable[i]->callRevert();
        return true;
    }
    else if(role =="SW"){
        for(int i=0; i<6; i++)
            MTable[i]->callRevert();
        return true;
    }
        else
            return false;
}


QString ModelManage::MTruncate(unsigned int index, QList<unsigned int> cl){
    QString s;
    if(role == "W" && index<3){
        s = MTable[index]->truncate(cl);
    }
    else if(role == "SW" && index<6){
        s = MTable[index]->truncate(cl);
     }
    return s;
}


void ModelManage::setModel(ParamDatabase* pdb)
{
    for(int i = 0; i < 6; i++){
        if(MTable[i] != nullptr)
            delete MTable[i];
        MTable[i] = new TModel(pdb->getdb());
    }
}

bool ModelManage::setModelTable(unsigned int index, QString tableName){
    MTable[index]->setTable(tableName);
    MTable[index]->setEditStrategy(QSqlTableModel::OnManualSubmit);
    MTable[index]->select();
    return true;
}


TModel* ModelManage::getMTable(unsigned int index){
    if(index<6 && index >=0)
        return MTable[index];
    else
        return nullptr;
}

void ModelManage::callAngleTableInitialize()
{
    // maybe add new function in here
    emit registerRequest(MTable[2], modelNames[2]);
}

void ModelManage::callFixedTablesInitialize()
{
    this->setModelTable(0, "Pass");
    emit registerRequest(MTable[0], modelNames[0]);

    this->setModelTable(3, "MotionJog");
    emit registerRequest(MTable[3], modelNames[3]);

    this->setModelTable(4, "ControlParameter");
    emit registerRequest(MTable[4], modelNames[4]);

    this->setModelTable(5, "CommunicationParameter");
    emit registerRequest(MTable[5], modelNames[5]);
}


void ModelManage::deleteModels()
{
    for(int i = 0; i < 6; i++){
        if(this->MTable[i] != nullptr){
            delete MTable[i];
            MTable[i] = nullptr;
        }

    }
}
