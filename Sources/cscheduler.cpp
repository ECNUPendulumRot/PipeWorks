﻿#include "cscheduler.h"
#include <QCoreApplication>
#include <QFile>
#include <QDataStream>

Scheduler::Scheduler(QObject *parent): QObject{parent}
{
    udb     = nullptr;
    user    = nullptr;
    manager = nullptr;
    pdb     = nullptr;
    engine  = nullptr;
    status  = false;

    qDebug()<<QCoreApplication::applicationDirPath();
}


bool Scheduler::userCreate(QString id, QString pw)
{
    callUserDb();

    bool login = false;
    user = new User(id, pw);
    user->login(udb);//get user's role
    if(user->getRole() == SeniorWorker || user->getRole() == Worker){
        login = true;
    }
    else{
        user->clear();
        login = false;
    }

    callUserDbClose();

    return login;
}

bool Scheduler::userVerify(QString id, QString pw)
{
    bool login = false;
    login = userCreate(id, pw);
    user->clear();

    return login;
}

bool Scheduler::userUpdate(QString id, QString opw, QString npw)
{

    callUserDb();
    bool result;
    result = udb->informationUpdate(id, opw, npw);
    callUserDbClose();
    return result;
}

int Scheduler::getAuthority()
{
    return user->getRole();
}

bool Scheduler::isPdbLoaded() const
{
    return status;
}

void Scheduler::callCloseDataBase()
{
    this->manager->clear();
    this->pdb->closeDatabase();
    this->status = false;
}


bool Scheduler::managerInit(){
    if(user->getRole() != SeniorWorker && user->getRole() != Worker )
        return false;
    manager = user->getRole() == SeniorWorker ? new ModelManager("SW") : new ModelManager("W");
    QObject::connect(manager, &ModelManager::registerRequest,
                     this,  &Scheduler::registerModel);
    QObject::connect(manager, &ModelManager::registerRequestPartModel,
                     this,  &Scheduler::registerPartModel);
//    QObject::connect(manager, &ModelManager::registerRequestPool,
//                     this,  &Scheduler::registerModelPool);
    return true;
}


bool Scheduler::setParamDb(QString s)
{
    if(this->pdb != nullptr)
        delete this->pdb;
    this->pdb = new ParamDatabase(s);
    return true;
}


bool Scheduler::callParamDb(QUrl url)
{
    QString file = url.toLocalFile();

    setParamDb(file);

    if(manager != nullptr){
        manager->setModel(pdb);
        manager->callFixedTablesInitialize();
        manager->callAngleTableInitialize();
        this->status = true;
    }
    else
        return false;
    return true;
}

bool Scheduler::callUserDb()
{
    UserDb *udb = new UserDb(QCoreApplication::applicationDirPath().append("/Database/Users.db"));
    this->udb = udb;
    return true;
}

void Scheduler::callUserDbClose()
{
    this->udb->closeDatabase();
    delete udb;
}


bool Scheduler::submitData(){
    this->manager->submit();
    return true;
}

bool Scheduler::revertData(){
    this->manager->revert();
    return true;
}

bool Scheduler::callIsDirty()
{
    if(manager != nullptr)
        return manager->isDirty();
    else
        return false;
}

void Scheduler::saveToFile(QUrl source ,QUrl dest)
{
    qDebug() << source << " " << dest;
    QString sourceString = source.toLocalFile();
    QString destString = dest.toLocalFile();
    qDebug() << sourceString << " " << destString;

    if(!QFile::copy(sourceString, destString))
        qDebug() << "copy failed";
}


bool Scheduler::callAngleTable(unsigned int index)
{
    // fix!
    manager->changeSelectIndex(index);
    return true;
}


void Scheduler::callPassSelected(QString s)
{
    manager->changePass(s);
}

//bool Scheduler::registerModelPool(ModelPool *m, QString s)
//{
//    if(engine !=  nullptr){
//        engine->rootContext()->setContextProperty(s, m);
//        QObject::connect(m, &ModelPool::modelChanged,
//                         this,  &Scheduler::modelChanged);
//        return true;
//    }
//    else
//        return false;
//}

bool Scheduler::registerModel(TModel *m, QString s)
{
    if(engine !=  nullptr){
        engine->rootContext()->setContextProperty(s, m);
        QObject::connect(m, &TModel::modelChanged,
                         this,  &Scheduler::modelChanged);
        return true;
    }
    else
        return false;
}

bool Scheduler::registerPartModel(PartModel *m, QString s)
{
    if(engine !=  nullptr){
        engine->rootContext()->setContextProperty(s, m);
        QObject::connect(m, &PartModel::dataReady,
                         this,  &Scheduler::modelDataReady);
        return true;
    }
    else
        return false;
}

void Scheduler::setEngine(QQmlApplicationEngine* e)
{
    engine = e;
}

bool Scheduler::managerSetTable(unsigned int i, QString TableName){
    this->manager->setModelTable(i, TableName);
    return true;
}

TModel* Scheduler::managerGetTable(unsigned int i){
    return this->manager->getMTable(i);
}
