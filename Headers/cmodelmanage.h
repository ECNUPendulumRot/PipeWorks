#ifndef CMODELMANAGE_H
#define CMODELMANAGE_H

#include <QSqlTableModel>
#include <QObject>

#include <cTmodel.h>
#include <cparamdatabase.h>

class ModelManage : public QObject
{
    Q_OBJECT

public:

    ModelManage();

    ModelManage(ParamDatabase* pdb);

    ModelManage(QString role);

    bool Submit();

    bool Rvert();

    ///
    /// \brief MTruncate
    /// \param index : index of model to execute truncate
    /// \param cl : parameters to be used
    /// \return
    ///
    QString MTruncate(unsigned int index, QList<unsigned int> cl); //model truncate

    ///
    /// \brief setModel
    /// \param db : database used to initialize model
    ///
    void setModel(ParamDatabase *pdb);

    bool setModelTable(unsigned int index, QString tableName);

    QString role;

    TModel* getMTable(unsigned int index);

    void callAngleTableInitialize();

    void callFixedTablesInitialize();

    void deleteModels();

private:

    QSqlDatabase mdb;

    TModel* MTable[6];

    static inline QList<QString> modelNames = {"passFTableModel", "passTableModel", "angleRelatedTableModel",// workers' access
                                               "motionFTableModel", "controlFTableModel", "comFTableModel"}; // senior workers' access

signals:
    void registerRequest(TModel*, QString);

};

#endif // CMODELMANAGE_H
