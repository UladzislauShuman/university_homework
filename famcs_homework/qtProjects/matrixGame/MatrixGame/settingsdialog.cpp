#include "settingsdialog.h"
#include "ui_settingsdialog.h"

SettingsDialog::SettingsDialog(QWidget *parent)
    : QDialog(parent)
    , ui(new Ui::SettingsDialog)
{
    qDebug() << "SettingsDialog::SettingsDialog(QWidget*)"<<Qt::endl;
    ui->setupUi(this);
}

SettingsDialog::~SettingsDialog()
{
    qDebug() << "~SettingsDialog::SettingsDialog()"<<Qt::endl;
    delete ui;
}

void SettingsDialog::on_okButton_clicked()
{
    qDebug() << "SettingsDialog::on_okButton_clicked()"<<Qt::endl;
    int width;
    int height;
    if(this->ui->widthEdit->text() == "")
        width = 6;
    else
        width = this->ui->widthEdit->text().toInt();
    if(this->ui->heightEdit->text() == "")
        height = 6;
    else
        height = this->ui->heightEdit->text().toInt();
    this->ui->heightEdit->clear();
    this->ui->widthEdit->clear();
    emit Signal_Width_Height(width,height);
    emit SignalSettingsWereChoosen(false);
    this->close();
}

