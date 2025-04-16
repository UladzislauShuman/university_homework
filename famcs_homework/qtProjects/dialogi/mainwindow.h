#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QString>
#include <QFileDialog>

#include "computeritem.h"
#include "searchdialog.h"
#include "sortdialog.h"

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
    void on_searchButton_clicked();

    void on_sortButton_clicked();

public slots:
    void slotModel(QString);
    void slotSortType(QString);

signals:
    void SignalModel(QString);
    void SignalSort(QString);
private:
    Ui::MainWindow *ui;
    std::vector<ComputerItem> computerItems;
    SearchDialog* searchDialog;
    SortDialog* sortDialog;
    void PrintComputerItems();
};
#endif // MAINWINDOW_H
