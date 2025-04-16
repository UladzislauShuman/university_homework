#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "fieldwidget.h"
#include "tablewidget.h"

#include <QLabel>
#include <QGridLayout>
#include <QMessageBox>
#include <QTabWidget>

#include <QFileDialog>
#include <QFile>
#include <QString>

#include <QColor>
#include <QColorDialog>
#include <QMouseEvent>

QT_BEGIN_NAMESPACE
namespace Ui {
class MainWindow;
}
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();
protected:
    void mousePressEvent(QMouseEvent*);
private slots:

    void on_tableAction_triggered();

    void on_fieldAction_triggered();

    void on_openAction_triggered();
    void on_colorAction_triggered();

    void on_fillAction_triggered();

    void on_saveAction_triggered();

    void on_saveHowAction_triggered();

    void on_cleanAction_triggered();

    void on_GetBackAction_triggered();

signals:
    void SignalFileName_toField(QString);
    void SignalColor_toField(QColor);
    void SignalIsFill_toField(bool);
    void SignalPoint_toField(QPair<int,int>);
    void SignalClean_toField();
    void SignalToSave_toField(QString);
    void SignalGetBack_toField();

    void SignalTakeField_toTable();
private:
    Ui::MainWindow *ui;
    FieldWidget* fieldWidget;
    tableWidget* table;
    QString current_file_name;
    bool isFill{false};
    bool isTable{false};

    void MakeTable();

};
#endif // MAINWINDOW_H
