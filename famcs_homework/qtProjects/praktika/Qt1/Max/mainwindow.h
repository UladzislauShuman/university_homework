#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

#include <QDialog>
#include <QTimer>
#include <QMessageBox>

#include <QPainter>
#include <QLineF>

#include <QString>
#include <QFileDialog>

//stl
#include <vector>
#include <string>
#include <fstream>
#include <algorithm>

QT_BEGIN_NAMESPACE
namespace Ui {
class MainWindow;
}
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent);
    ~MainWindow();
private slots:
    void on_openButton_clicked();
protected:
    void paintEvent(QPaintEvent*);
private:
    Ui::MainWindow *ui;
    std::vector<int> data;
    QPen* pen;
    QColor color;
    QPoint* penPosition;
    bool flag;
};

void ReadFile(std::vector<int>& data_,const std::string& file_name)
{
    std::ifstream fin(file_name);
    int temp;
    while(fin >> temp){
        data_.push_back(temp);
    }
}


#endif // MAINWINDOW_H


