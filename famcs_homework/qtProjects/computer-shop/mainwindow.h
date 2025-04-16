#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QString>
#include <QFileDialog>

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
    void on_readFileButton_clicked();
    void on_saveFileButton_clicked();
    void on_addItemButton_clicked();

private:
    Ui::MainWindow *ui;
    std::vector<ComputerItem> computerItems;
    void PrintComputerItems();
};
#endif // MAINWINDOW_H
