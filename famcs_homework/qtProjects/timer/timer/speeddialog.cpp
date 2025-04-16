#include "speeddialog.h"
#include "ui_speeddialog.h"

SpeedDialog::SpeedDialog(QTimer* timer_,int* delay_, QWidget *parent)
    : QDialog(parent)
    , ui(new Ui::SpeedDialog)
    ,delay(delay_)
    ,timer(timer_)
{
    ui->setupUi(this);
}

SpeedDialog::~SpeedDialog()
{
    delete ui;
}

void SpeedDialog::on_applyButton_clicked()
{
    ti
    *delay = ui->editSpeed->text().toInt();
}


void SpeedDialog::on_closeButton_clicked()
{
    this->close();
}

