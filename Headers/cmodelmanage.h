#ifndef CMODELMANAGE_H
#define CMODELMANAGE_H

#include <QSqlTableModel>
#include <QObject>

#include <cTmodel.h>
#include <cparamdatabase.h>
#include <partmodel.h>
#include <modelpool.h>

class ModelManager : public QObject
{
    Q_OBJECT

public:

    ModelManager();

    ModelManager(ParamDatabase* pdb);

    ModelManager(QString role);

    ///
    /// \brief setModel
    /// \param db : database used to initialize model
    ///
    void setModel(ParamDatabase *pdb);

    void deleteModels();

    bool submit();

    bool revert();

    ///
    /// \brief MTruncate
    /// \param index : index of model to execute truncate
    /// \param cl : parameters to be used
    /// \return
    ///
    //QString MTruncate(unsigned int index, QList<unsigned int> cl);

    bool setModelTable(unsigned int index, QString tableName);

    TModel* getMTable(int index);

    void callAngleTableInitialize();

    void callFixedTablesInitialize();

    QString role;

    //新添加

    bool addModelPool(QString modelName);   //add to pool

    bool changePass(QString modelName);                         //原setModelTable

    void clear();                                               //原deleteModels

    void changeSelectIndex(unsigned int index);          //原MTruncate


    bool isDirty();
    //新添加

signals:

    void registerRequest(TModel*, QString);

    void registerRequestPartModel(PartModel*, QString);

private:

    QSqlDatabase mdb;

    PartModel* pm;

    ModelPool* mPool;

    TModel* passFTableModel;    //
    TModel* systemFTableModel;  //
    TModel* motionFTableModel;  // workers' access
    TModel* controlFTableModel; //
    TModel* comFTableModel;     // senior workers' access

    QHash<unsigned int, TModel*> indexToModel =
            QHash<unsigned int, TModel*>({
                                        {0, passFTableModel},
                                        {1, systemFTableModel},
                                        {2, motionFTableModel},
                                        {3, controlFTableModel},
                                        {4, comFTableModel}
                                    });

    static inline QList<QString> registerNames =    {"passFTableModel", "systemFTableModel", "motionFTableModel", "controlFTableModel", "comFTableModel"};

    static inline QList<QString> tableNames    =    {"pass",            "SystemParameter",   "MotionJog",          "ControlParameter",  "CommunicationParameter"};

};

#endif // CMODELMANAGE_H
