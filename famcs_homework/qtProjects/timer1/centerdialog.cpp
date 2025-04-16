#include "centerdialog.h"
#include "ui_centerdialog.h"

CenterDialog::CenterDialog(QPoint* center_, QWidget *parent) :
    QDialog(parent),
    center(center_),
    ui(new Ui::CenterDialog)
{
    ui->setupUi(this);
}

CenterDialog::~CenterDialog()
{
    delete ui;
}

void CenterDialog::on_applyButton_clicked()
{
    center->setX(ui->editX->text().toInt());
    center->setY(ui->editY->text().toInt());
}


void CenterDialog::on_closeButton_clicked()
{
    this->close();
}

