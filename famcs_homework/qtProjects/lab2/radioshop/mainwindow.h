#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QString>
#include <QFileDialog>
#include <algorithm>
//#include "functions.h"

#include "radioitem.h"
#include "searchdatedialog.h"
#include "sortdialog.h"
#include "errorwindow.h"

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

private slots:
    void on_readFileButton_clicked();

    void on_saveFileButton_clicked();

    void on_additonButton_clicked();

    void on_cleanButton_clicked();

    void on_openButton_clicked();
    void on_searchDateButton_clicked();

    void on_sortButton_clicked();

public slots:
    void takeDateFromDateDialog(QString,QString);
    void takeSortDialog(QString,bool);
signals:
    void SignalTypeFromMainWidget(std::vector<radioitem>&);
private:
    Ui::MainWindow *ui;
    std::vector<radioitem> radioitems;
    SearchDateDialog* searchdatedialog;
    SortDialog* sortdialog;
    ErrorWindow* errorwindow;
    void PrintRadioitems();
};
#endif // MAINWINDOW_H
