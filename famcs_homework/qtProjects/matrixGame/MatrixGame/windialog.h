#ifndef WINDIALOG_H
#define WINDIALOG_H

#include <QDialog>
#include <QDebug>
namespace Ui {
class WinDialog;
}

class WinDialog : public QDialog
{
    Q_OBJECT

public:
    explicit WinDialog(QWidget *parent = nullptr);
    ~WinDialog();
public slots:
    void takeMessage(QString,bool);
signals:
    void SignalNext(bool);
    void SignalMakeNewField(bool);
private slots:
    void on_nextButton_clicked();

private:
    Ui::WinDialog *ui;
};

#endif // WINDIALOG_H
