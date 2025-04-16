#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <vector>
#include <QString>
#include <QFileDialog>
#include <algorithm>

#include "computeritem.h"


QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private slots:
    // Buttons
    void on_readFileButton_clicked();
    void on_saveFileButton_clicked();
    void on_addItemButton_clicked();
    void on_sortButton_clicked();
    void on_openButton_clicked();

    void on_dayButton_clicked();

    void on_searchButton_clicked();

public slots:
    //void slotModel(QString);

signals:
    //void SignalModel(QString);

private:
    Ui::MainWindow *ui;
    std::vector<EmployeeProjects> employeeProjects;

    //void Connect();
    void PrintEmployeeProjects();
};
#endif // MAINWINDOW_H
