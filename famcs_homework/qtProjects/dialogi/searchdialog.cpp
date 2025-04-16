#include "searchdialog.h"
#include "ui_searchdialog.h"

SearchDialog::SearchDialog(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::SearchDialog)
{
    ui->setupUi(this);
}

SearchDialog::~SearchDialog()
{
    delete ui;
}

void SearchDialog::on_searchButton_clicked()
{
    emit SignalModel(ui->editModel->text());
}


void SearchDialog::on_closeDialogButton_clicked()
{
    this->close();
}

void SearchDialog::slotModel(QString qstr) {
    ui->output->setText(qstr);
}

