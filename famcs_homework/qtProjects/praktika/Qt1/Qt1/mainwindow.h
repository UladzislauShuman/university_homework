#ifndef MAINWINDOW_H
#define MAINWINDOW_H
#include <vector>
#include <string>
#include <fstream>
#include <algorithm>

#include <QMainWindow>
#include <QDialog>
#include <QTimer>
#include <QMessageBox>
#include <QPainter>
#include <QLineF>
#include <QString>
#include <QFileDialog>
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
protected:
    void paintEvent(QPaintEvent*);
private:
    Ui::MainWindow *ui;
    std::vector<int> data;
    QPen* pen;
    QColor color;
    QPoint* penPosition;
};

void ReadFile(std::vector<int>&,const std::string&);
#endif // MAINWINDOW_H
