#ifndef SCHEDULER_H
#define SCHEDULER_H

#include <QObject>
#include <QUrl>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include <cuser.h>
#include <cmodelmanage.h>


class Scheduler : public QObject
{
    Q_OBJECT
public:

    explicit Scheduler(QObject *parent = nullptr);

    //index interface:
    //0:PassFTable  ; 1:PassTable;      2:AngleRelatedTable;
    //3:MotionFTable; 4:ControlFTable;  5:ComFTable;

    ///
    /// \brief setParamDb
    /// \param s : the position of the database
    /// \return
    ///
    bool setParamDb(QString s);


    bool managerSetTable(unsigned int i, QString TableName);

    ///
    /// \brief managerGetTable
    /// \param i: index of model
    /// \return model keeping data
    ///
    TModel* managerGetTable(unsigned int i);

    void setEngine(QQmlApplicationEngine*);

    Q_INVOKABLE bool isPdbLoaded() const;

public slots:

    bool userCreate(QString id, QString pw);

    bool userVerify(QString id, QString pw);

    bool userUpdate(QString id, QString opw,QString npw);

    int getAuthority();
    ///
    /// \brief managerInit
    /// \param dbName: name of database
    /// \return bool
    ///
    bool managerInit();

    //bool registerModelPool(ModelPool *m, QString s);
    bool registerModel(TModel*, QString);

    ///
    /// \brief callParamDb
    /// \param url : file location chosen by user
    /// \return
    /// initialize Database and create a manager with empty models
    bool callParamDb(QUrl url);

    bool callUserDb();

    void callUserDbClose();

    void callCloseDataBase();


    ///
    /// \brief callAngleTable
    /// \param index : index of the parameter
    /// \return
    ///
    bool callAngleTable(unsigned int index);

    //TODO:
    void callPassSelected(QString s);

    bool submitData();

    bool revertData();

private:

    User *user;
    ModelManage *manager;
    UserDb *udb;
    ParamDatabase *pdb;

    QQmlApplicationEngine* engine;

    bool status = false; //load :true

signals:
    void modelRegistered();

    void modelChanged(QString s);
};

#endif // SCHEDULER_H
