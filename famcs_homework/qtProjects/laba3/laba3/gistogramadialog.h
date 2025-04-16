#ifndef GISTOGRAMADIALOG_H
#define GISTOGRAMADIALOG_H

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
namespace Ui {
class GistogramaDialog;
}

class GistogramaDialog : public QDialog
{
    Q_OBJECT

public:
    explicit GistogramaDialog(QWidget *parent = nullptr);
    ~GistogramaDialog();

private slots:
    void on_openButton_clicked();
protected:
    void paintEvent(QPaintEvent*);
private:
    Ui::GistogramaDialog *ui;
    std::vector<int> data;
    QPen* pen;
    QColor color;
    QPoint* penPosition;
    bool flag;
};

void ReadFile(std::vector<int>&,const std::string&);

#endif // GISTOGRAMADIALOG_H
