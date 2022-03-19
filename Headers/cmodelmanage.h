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

    //const static int MTableCount = 7;

    static inline TModel* passFTableModel;    //
    static inline TModel* systemFTableModel;  //
    static inline TModel* motionFTableModel;  // workers' access

    static inline TModel* controlFTableModel; //
    static inline TModel* comFTableModel;     // senior workers' access

    static inline QHash<unsigned int, TModel*> indexToTModel =
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

};

#endif // CMODELMANAGE_H
