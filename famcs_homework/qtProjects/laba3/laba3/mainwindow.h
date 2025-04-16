#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

#include "gistogramadialog.h"
#include "boatdialog.h"
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
    void on_zad1Button_clicked();
    void on_zad2Button_clicked();

private:
    Ui::MainWindow *ui;
    BoatDialog* boat;
    GistogramaDialog* gistograma;
};
#endif // MAINWINDOW_H
