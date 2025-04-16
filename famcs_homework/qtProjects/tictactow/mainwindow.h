#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QPushButton>

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();
    bool checkWin();

private slots:
    void on_pushButton00_clicked();

    void on_pushButton10_clicked();

    void on_pushButton20_clicked();

    void on_pushButton01_clicked();

    void on_pushButton02_clicked();

    void on_pushButton11_clicked();

    void on_pushButton21_clicked();

    void on_pushButton12_clicked();

    void on_pushButton22_clicked();

private:
    Ui::MainWindow *ui;
    static int turn;
    static bool flag;
    static char board[3][3];

    void ClickHandler(int row, int col, QPushButton* button);
};
#endif // MAINWINDOW_H
