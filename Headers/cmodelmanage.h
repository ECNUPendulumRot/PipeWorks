#ifndef CMODELMANAGE_H
#define CMODELMANAGE_H

#include <QSqlTableModel>
#include <QObject>

#include <cTmodel.h>
#include <cparamdatabase.h>

QT_BEGIN_NAMESPACE
class PartModel;
class ModelPool;
QT_END_NAMESPACE

class ModelManage : public QObject
{
    Q_OBJECT

public:

    ModelManage();

    ModelManage(ParamDatabase* pdb);

    ModelManage(QString role);

    ///
    /// \brief setModel
    /// \param db : database used to initialize model
    ///
    void setModel(ParamDatabase *pdb);

    void deleteModels();

    bool Submit();

    bool Rvert();


    //新添加
    bool addModelPool(ParamDatabase* pdb, QString modelName);   //add to pool
    bool changePass(QString modelName);                         //原setModelTable
    void Clear();                                               //原deleteModels
    QString changeSelectIndex(QList<unsigned int> cl);          //原MTruncate
    //新添加

    ///
    /// \brief MTruncate
    /// \param index : index of model to execute truncate
    /// \param cl : parameters to be used
    /// \return
    ///
    QString MTruncate(unsigned int index, QList<unsigned int> cl);

    bool setModelTable(unsigned int index, QString tableName);

    TModel* getMTable(unsigned int index);

    void callAngleTableInitialize();

    void callFixedTablesInitialize();

    QString role;

private:

    QSqlDatabase mdb;

    PartModel* pm;

    ModelPool* mPool;           //
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
                                        {4, comFTableModel},
                                    });


//    static inline QList<QString> modelNames = {"passFTableModel", "passTableModel", "angleRelatedTableModel", "systemFTableModel", "motionFTableModel", // workers' access
//                                               "controlFTableModel", "comFTableModel"}; // senior workers' access

signals:
    void registerRequest(TModel*, QString);
    void registerRequestPool(ModelPool*, QString);
};

#endif // CMODELMANAGE_H
