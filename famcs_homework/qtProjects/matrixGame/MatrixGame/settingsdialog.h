#ifndef SETTINGSDIALOG_H
#define SETTINGSDIALOG_H

#include <QDialog>

namespace Ui {
class SettingsDialog;
}

class SettingsDialog : public QDialog
{
    Q_OBJECT

public:
    explicit SettingsDialog(QWidget *parent = nullptr);
    ~SettingsDialog();
private slots:
    void on_okButton_clicked();

private:
    Ui::SettingsDialog *ui;
signals:
    void Signal_Width_Height(int,int);
    void SignalSettingsWereChoosen(bool);
};

#endif // SETTINGSDIALOG_H
