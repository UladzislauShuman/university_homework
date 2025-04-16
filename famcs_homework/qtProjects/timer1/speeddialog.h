#ifndef SPEEDDIALOG_H
#define SPEEDDIALOG_H

#include <QDialog>
#include <QTimer>

namespace Ui {
class SpeedDialog;
}

class SpeedDialog : public QDialog
{
    Q_OBJECT

public:
    explicit SpeedDialog(QTimer*, int*, QWidget *parent = nullptr);
    ~SpeedDialog();

private slots:
    void on_applyButton_clicked();

    void on_closeButton_clicked();

private:
    Ui::SpeedDialog *ui;
    int* delay;
    QTimer* timer;
};

#endif // SPEEDDIALOG_H
