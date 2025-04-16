#ifndef SETTINGSDIALOG_H
#define SETTINGSDIALOG_H

#include <QDialog>
#include <QColorDialog>

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
    void on_pushButton_clicked();
    void on_colorBoatButton_clicked();

    void on_colorFlagButton_clicked();

signals:
    void SignalSettings(int,int,int,int);
    void SignalColorBoat(QColor);
    void SignalColorFlag(QColor);
private:
    Ui::SettingsDialog *ui;
};

#endif // SETTINGSDIALOG_H
