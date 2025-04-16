#include "settingsdialog.h"
#include "ui_settingsdialog.h"

SettingsDialog::SettingsDialog(QWidget *parent)
    : QDialog(parent)
    , ui(new Ui::SettingsDialog)
{
    ui->setupUi(this);
}

SettingsDialog::~SettingsDialog()
{
    delete ui;
}

void SettingsDialog::on_pushButton_clicked()
{
    int x_pos = ui->x_pos_edit->text().toInt();
    int y_pos = ui->y_pos_edit->text().toInt();
    int width = ui->widthEdit->text().toInt();
    int height = ui->heightEdit->text().toInt();

    if(ui->x_pos_edit->text().isEmpty())
        x_pos = -1;
    if(ui->y_pos_edit->text().isEmpty())
       y_pos = -1;
    if(ui->widthEdit->text().isEmpty())
        width = -1;
    if(ui->heightEdit->text().isEmpty())
        height = -1;

    emit SignalSettings(x_pos,
                        y_pos,
                        width,
                        height);
    this->close();
}


void SettingsDialog::on_colorBoatButton_clicked()
{
    emit SignalColorBoat(QColorDialog::getColor());
}


void SettingsDialog::on_colorFlagButton_clicked()
{
    emit SignalColorFlag(QColorDialog::getColor());
}

