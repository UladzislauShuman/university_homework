#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QString>
#include <QFileDialog>
#include <QPainter>
#include <QLineF>

#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>

#include "member.h"
#include "choosepersondialog.h"
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
    void on_openButton_clicked();

    void on_pushButton_clicked();
public slots:
    void takePersonIndex(int);
private:
    Ui::MainWindow *ui;
    std::vector<Member> members;
    ChoosePersonDialog* choosePerson;
    int maxScore;
    void PrintMembers();

    QPen* pen;
    QColor color;

    int current_index{0};
    bool flag;
signals:
    void SignaleMembers(std::vector<Member>&);
protected:
    void paintEvent(QPaintEvent*);
};

void ReadFile(std::vector<Member>&,QString&);
#endif // MAINWINDOW_H

