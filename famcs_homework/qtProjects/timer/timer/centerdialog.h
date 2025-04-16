#ifndef CENTERDIALOG_H
#define CENTERDIALOG_H

#include <QDialog>

namespace Ui {
class CenterDialog;
}

class CenterDialog : public QDialog
{
    Q_OBJECT

public:
    explicit CenterDialog(QPoint* center, QWidget *parent = nullptr);
    ~CenterDialog();

private slots:
    void on_applyButton_clicked();

    void on_closeButton_clicked();

private:
    Ui::CenterDialog *ui;

};

#endif // CENTERDIALOG_H
