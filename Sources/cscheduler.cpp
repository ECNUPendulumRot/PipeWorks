#include "cscheduler.h"
#include <QCoreApplication>

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
    this->manager->deleteModels();
    this->pdb->closeDatabase();
    this->status = false;
}


bool Scheduler::managerInit(){
    if(user->getRole() != SeniorWorker && user->getRole() != Worker )
        return false;
    manager = user->getRole() == SeniorWorker ? new ModelManage("SW") : new ModelManage("W");
    QObject::connect(manager, &ModelManage::registerRequest,
                     this,  &Scheduler::registerModel);
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
    this->manager->Submit();
    return true;
}

bool Scheduler::revertData(){
    this->manager->Rvert();
    return true;
}


bool Scheduler::callAngleTable(unsigned int index)
{
    this->manager->MTruncate(2, {index});
    // emit modelChanged(s);
    return true;
}


void Scheduler::callPassSelected(QString s)
{
    managerSetTable(2, s);
}


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
